import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:asmr_battle_factory/features/ai/data/services/ai_orchestrator.dart';
import 'package:asmr_battle_factory/features/vault/data/models/saved_scenario.dart';
import 'package:uuid/uuid.dart';
// Actually ContestantRepository is in data/repositories/contestant_repository_impl.dart but usually interface is in domain. 
// Aah, the previous file view showed the interface is defined in the same file as implementation in `contestant_repository_impl.dart` (lines 6-8).
// So the import is correct, but I should use the specific class.
import 'package:asmr_battle_factory/features/contestants/data/repositories/contestant_repository_impl.dart';

@singleton
class MultiScenarioGenerator {
  final AIOrchestrator _ai;
  final ContestantRepository _repository;

  MultiScenarioGenerator(this._ai, this._repository);

  Future<List<SavedScenario>> generateBatch(List<String> contestantIds) async {
    final allContestants = await _repository.getAll();
    final contestants = contestantIds.map((id) => 
      allContestants.firstWhere((c) => c.id == id, orElse: () => allContestants.first).nameEn
    ).join(', ');

    final prompt = '''
    Generate 5 different cinematic battle scenarios between: $contestants.
    Return a JSON array of objects.
    Each object MUST have:
    - titleAr: Catchy Arabic title
    - titleEn: Catchy English title
    - briefDescriptionAr: One sentence summary in Arabic
    - briefDescriptionEn: One sentence summary in English
    - suggestedWinnerId: Pick one ID from this list: $contestantIds
    - twistLevel: 1-10
    
    Keep it brief and dramatic.
    ''';

    try {
      final response = await _ai.orchestrateStage('idea_generation_batch', prompt);
      // Assuming AI returns cleaned JSON
      final List<dynamic> data = jsonDecode(response);
      
      return data.map((item) => SavedScenario(
        id: const Uuid().v4(),
        titleAr: item['titleAr'],
        titleEn: item['titleEn'],
        briefDescriptionAr: item['briefDescriptionAr'],
        briefDescriptionEn: item['briefDescriptionEn'],
        contestantIds: contestantIds,
        savedAt: DateTime.now(),
        suggestedWinnerId: item['suggestedWinnerId'],
        twistLevel: item['twistLevel'] ?? 5,
        providerUsed: 'batch_ai',
      )).toList();
    } catch (e) {
      // Return empty or fallback
      return [];
    }
  }
}
