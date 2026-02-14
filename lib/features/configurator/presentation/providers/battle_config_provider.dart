import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/battle_config.dart';
import '../../../generator/domain/entities/contestant.dart';
import '../../../budget/domain/models/budget_mode.dart';
import '../../../contestants/data/repositories/contestant_repository_impl.dart';
import '../../../projects/data/models/battle_project.dart' hide ProviderMix; // Keep original with hide
import '../../../projects/data/models/battle_project.dart' as project_model; // Add alias for project model's ProviderMix
import '../../../history/data/models/battle_history.dart';
import '../../../../config/di/injection.dart';

class BattleConfigNotifier extends StateNotifier<BattleConfig> {
  final ContestantRepository _repository;

  BattleConfigNotifier(this._repository) : super(const BattleConfig(contestants: [])) {
    _loadInitialContestants();
  }

  Future<void> _loadInitialContestants() async {
    final ids = ['ant', 'bee', 'rock', 'scissors'];
    final List<Contestant> loaded = [];
    
    for (final id in ids) {
      final contestant = await _repository.getById(id);
      if (contestant != null) loaded.add(contestant);
    }
    
    if (loaded.isNotEmpty) {
      state = state.copyWith(contestants: loaded);
    } else {
       // Fallback if load fails (shouldn't happen if JSON is correct)
       // Keeping strict logic for now
    }
  }

  void updateContestants(List<Contestant> contestants) {
    state = state.copyWith(contestants: contestants);
  }

  void updateContestant(int index, Contestant updated) {
    final current = List<Contestant>.from(state.contestants);
    if (index >= 0 && index < current.length) {
      current[index] = updated;
      state = state.copyWith(contestants: current);
    }
  }

  void reorderContestants(int oldIndex, int newIndex) {
    final current = List<Contestant>.from(state.contestants);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = current.removeAt(oldIndex);
    current.insert(newIndex, item);
    state = state.copyWith(contestants: current);
  }

  void setWinnerMode(WinnerMode mode) => state = state.copyWith(winnerMode: mode);
  void setProviderMix(ProviderMix mix) => state = state.copyWith(providerMix: mix);
  void setBattleType(BattleType type) => state = state.copyWith(type: type);
  void setBudgetMode(BudgetMode mode) => state = state.copyWith(budgetMode: mode);
  void toggleSlowMotion() => state = state.copyWith(slowMotion: !state.slowMotion);

  void reset() {
    _loadInitialContestants();
  }
  
  // Contestant Management (for Browser)
  void addContestant(Contestant contestant) {
    if (state.contestants.length < 8 && !state.contestants.any((c) => c.id == contestant.id)) {
      state = state.copyWith(
        contestants: [...state.contestants, contestant],
      );
    }
  }
  
  void removeContestant(String id) {
    state = state.copyWith(
      contestants: state.contestants.where((c) => c.id != id).toList(),
    );
  }
  
  // Apply AI-generated idea
  Future<void> applyIdea(String ideaDescription) async {
    // Parse idea like "Lion vs Tiger" or "Fire vs Water vs Earth"
    final vs = ideaDescription.toLowerCase().split(' vs ');
    if (vs.isEmpty) return;
    
    // Clear current contestants
    state = state.copyWith(contestants: []);
    
    // Try to find contestants matching the idea
    final allContestants = await _repository.getAll();
    final List<Contestant> matched = [];
    
    for (final name in vs) {
      final trimmed = name.trim();
      final found = allContestants.where((c) {
        return c.nameEn.toLowerCase() == trimmed ||
               c.id.toLowerCase() == trimmed ||
               c.nameAr == trimmed;
      }).firstOrNull;
      
      if (found != null && !matched.contains(found)) {
        matched.add(found);
      }
    }
    
    // Update with matched contestants (or keep empty if none found)
    if (matched.isNotEmpty) {
      state = state.copyWith(contestants: matched);
    }
  }

  Future<void> loadProject(BattleProject project) async {
    // 1. Load contestants by ID
    final List<Contestant> loaded = [];
    for (final id in project.contestants) {
      final c = await _repository.getById(id);
      if (c != null) loaded.add(c);
    }

    // 2. Map ProviderMix from project model to domain enum
    final mix = _mapProviderMix(project.providerMix);

    // 3. Update state
    state = state.copyWith(
      contestants: loaded,
      providerMix: mix,
      budgetMode: project.budgetMode,
      // Map other fields if necessary
    );
  }

  ProviderMix _mapProviderMix(project_model.ProviderMix model) {
    if (model.useSmartRouting) return ProviderMix.balanced;
    // Simple heuristic for mapping
    if (model.videoProvider == 'runway') return ProviderMix.quality;
    if (model.ideaProvider == 'groq') return ProviderMix.speed;
    return ProviderMix.balanced;
  }

  Future<void> loadHistory(BattleHistory history) async {
    // History only has names, so we try to find contestants by name
    final all = await _repository.getAll();
    final List<Contestant> matched = [];
    
    for (final nameAr in history.contestantNames) {
      final found = all.where((c) => c.nameAr == nameAr || c.nameEn == nameAr).firstOrNull;
      if (found != null) matched.add(found);
    }
    
    if (matched.isNotEmpty) {
      state = state.copyWith(contestants: matched);
    }
  }
}

final battleConfigProvider = StateNotifierProvider<BattleConfigNotifier, BattleConfig>((ref) {
  return BattleConfigNotifier(getIt<ContestantRepository>());
});

