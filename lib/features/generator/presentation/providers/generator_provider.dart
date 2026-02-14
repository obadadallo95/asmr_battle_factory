import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/battle_script.dart';
import '../../../configurator/domain/entities/battle_config.dart';
import '../../domain/repositories/generator_repository.dart';
import '../../../../config/di/injection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/services/navigation_guard_service.dart';
import '../../../history/data/models/battle_history.dart';
import '../../../history/data/repositories/history_repository.dart';

// State
abstract class GeneratorState {
  const GeneratorState();
}

class GeneratorInitial extends GeneratorState {
  const GeneratorInitial();
}

class GeneratorLoading extends GeneratorState {
  final List<String> logs;
  final int currentStep;
  const GeneratorLoading(this.logs, this.currentStep);
}

class GeneratorSuccess extends GeneratorState {
  final BattleScript script;
  const GeneratorSuccess(this.script);
}

class GeneratorDominoRunning extends GeneratorState {
  final int total;
  final int current; // 1-based index
  final List<BattleScript> results;
  final String log;
  
  const GeneratorDominoRunning({
    required this.total, 
    required this.current, 
    required this.results, 
    required this.log
  });
}

class GeneratorDominoSuccess extends GeneratorState {
   final List<BattleScript> results;
   const GeneratorDominoSuccess(this.results);
}

class GeneratorError extends GeneratorState {
  final String message;
  const GeneratorError(this.message);
}

// Notifier
class GeneratorNotifier extends StateNotifier<GeneratorState> {
  final GeneratorRepository _repository;
  final NavigationGuardNotifier _guard;

  GeneratorNotifier(this._repository, this._guard) : super(const GeneratorInitial()) {
    _checkForInterruptedOperations();
  }

  Future<void> _checkForInterruptedOperations() async {
    final box = Hive.box('operations');
    final interrupted = box.get('last_operation');
    if (interrupted != null) {
      // In a real app, we would calculate cost or resume specific step
      // For now, we just acknowledge it
      // _emitLog("Recovered interrupted operation: ${interrupted['title']}");
      // We could set state to a "Recovery Mode" or just log it
    }
  }

  Future<void> generateBattle(BattleConfig config) async {
    if (state is! GeneratorInitial) return;

    final names = config.contestants.map((c) => c.nameEn.isEmpty ? c.category.name : c.nameEn).toList();

    _emitLog("Intializing Battle Factory protocol...");
    _emitLog("Analyzing contestant strength: ${config.contestants.map((c) => c.powerLevel).toList()}");
    
    // Start Critical Guard
    _guard.startCriticalOperation('Battle Generation', 4.50); // Hardcoded cost for now
    Hive.box('operations').put('last_operation', {
      'title': 'Battle Generation',
      'status': 'running',
      'timestamp': DateTime.now().toIso8601String(),
    });

    // Simulate steps
    await Future.delayed(const Duration(seconds: 1));
    _emitLog("Step 1: Drafting Cinematic Script...");
    state = const GeneratorLoading(["Drafting Script..."], 0);

    final result = await _repository.generateBattleScript(names);
    
    result.fold(
      (failure) {
         state = GeneratorError(failure.message);
         _guard.endCriticalOperation();
      },
      (script) async {
        _emitLog("Script Generated: ${script.title}");
        state = const GeneratorLoading(["Script Generated...", "Generating Image Prompts..."], 1);
        await Future.delayed(const Duration(seconds: 1)); // Simulating Image Gen
        
        state = const GeneratorLoading(["Images Ready...", "Rendering Motion Vectors..."], 2);
        await Future.delayed(const Duration(seconds: 1)); // Simulating Video Gen
        
        state = const GeneratorLoading(["Finalizing Render...", "Ready for Preview"], 3);
        await Future.delayed(const Duration(milliseconds: 500));
        
        // Log to History
        final historyRepo = getIt<HistoryRepository>();
        await historyRepo.logBattle(BattleHistory(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          timestamp: DateTime.now(),
          contestantNames: config.contestants.map((c) => c.nameAr).toList(),
          winner: script.winner, // Assuming BattleScript has winner
          actualCost: 4.50, // Hardcoded or calculated
          scriptTitle: script.title,
          style: config.slowMotion ? 'slow_mo' : 'cinematic',
        ));

        state = GeneratorSuccess(script);
        _guard.endCriticalOperation();
        Hive.box('operations').delete('last_operation');
      },
    );
  }
  
  Future<void> startDominoMode(int count) async {
    state = GeneratorDominoRunning(total: count, current: 0, results: [], log: 'Initializing Domino Protocol...');
    _guard.startCriticalOperation('Domino Batch ($count)', count * 2.50);
    
    List<String> allIdeas = [];
    int attempts = 0;
    
    // 1. Generate enough ideas
    while (allIdeas.length < count && attempts < 5) {
      attempts++;
      final result = await _repository.generateBattleIdeas();
      result.fold(
        (l) => _emitLog('Failed to fetch ideas batch'),
        (newIdeas) => allIdeas.addAll(newIdeas),
      );
      if (allIdeas.length >= count) break;
      await Future.delayed(const Duration(seconds: 1));
    }
    
    if (allIdeas.isEmpty) {
      state = const GeneratorError('Could not generate any battle ideas. Check AI connection.');
      _guard.endCriticalOperation();
      return;
    }
    
    final battleIdeas = allIdeas.take(count).toList();
    List<BattleScript> generatedScripts = [];
    
    // 2. Process each battle
    for (int i = 0; i < battleIdeas.length; i++) {
       final idea = battleIdeas[i];
       
       state = GeneratorDominoRunning(
          total: count, 
          current: i + 1, 
          results: List.from(generatedScripts), 
          log: 'Generating Battle ${i+1}/$count: $idea'
       );
       
       // Parse "Lava vs Ice" -> ["Lava", "Ice"]
       // If "vs" is missing, just treat as single prompt or split casually
       List<String> contestants = idea.contains(' vs ') 
           ? idea.split(' vs ') 
           : [idea, 'The World']; // Fallback
           
       // Clean up names
       contestants = contestants.map((s) => s.trim()).toList();
       
       final scriptResult = await _repository.generateBattleScript(contestants);
       
       scriptResult.fold(
         (l) {
           _emitLog('Failed to generate script for $idea: ${l.message}');
           // Continue to next? Or fail? Let's continue.
         },
         (script) {
            generatedScripts.add(script);
            // Update state with new result
            state = GeneratorDominoRunning(
              total: count, 
              current: i + 1, 
              results: List.from(generatedScripts), 
              log: 'Completed: ${script.title}'
            );
         }
       );
       
       // Pacing
       await Future.delayed(const Duration(seconds: 1));
    }
    
    state = GeneratorDominoSuccess(generatedScripts);
    _guard.endCriticalOperation();
  }

  void _emitLog(String message) {
    // In a real app, we would append to the log list in state
    // For simplicity here, passing logs in Loading state
  }

  void reset() {
    state = const GeneratorInitial();
  }
}

// Provider
final generatorProvider = StateNotifierProvider<GeneratorNotifier, GeneratorState>((ref) {
  return GeneratorNotifier(
    getIt<GeneratorRepository>(),
    ref.read(navigationGuardProvider.notifier),
  );
});
