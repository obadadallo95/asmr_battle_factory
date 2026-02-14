import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:asmr_battle_factory/core/services/app_logger.dart';
import 'package:asmr_battle_factory/core/services/prompt_engineering/cinematic_engine.dart';
import 'package:asmr_battle_factory/features/generator/domain/entities/contestant.dart';
import 'package:asmr_battle_factory/features/generator/data/models/battle_script_model.dart';
import 'package:asmr_battle_factory/core/errors/failures.dart';
import 'package:asmr_battle_factory/features/ai/data/services/smart_router.dart';
import 'package:asmr_battle_factory/features/ai/domain/models/task_type.dart';


@singleton
class AIOrchestrator {
  final AppLogger _logger;
  final CinematicEngine _cinematicEngine;
  final SmartRouter _smartRouter;

  AIOrchestrator(this._logger, this._cinematicEngine, this._smartRouter);

  Future<BattleScriptModel> generateBattleScript(List<String> contestants) async {
    final contestantObjects = contestants.map((name) => 
      Contestant(
        id: 'temp',
        nameAr: name,
        nameEn: name,
        category: ContestantCategory.wildAnimals,
        iconAsset: '❓',
        strengths: [],
        weaknesses: [],
        powerLevel: 5,
      )
    ).toList();

    final prompt = _cinematicEngine.craftCinematicPrompt(contestantObjects);

    try {
      _logger.d('Orchestrating Battle Script generation...');
      
      final response = await _smartRouter.routeAndExecute(
        prompt, 
        overrideType: AITaskType.narrativeScripting,
      );
      
      final jsonText = _cleanJson(response.content);
      final jsonMap = jsonDecode(jsonText);
      return BattleScriptModel.fromJson(jsonMap);

    } catch (e) {
      _logger.e('Failed to generate battle script', e);
      throw ServerFailure('AI Orchestration Failed: $e');
    }
  }

  Future<String> orchestrateStage(String stage, String prompt) async {
    try {
      final response = await _smartRouter.routeAndExecute(
        prompt,
        overrideType: _mapStageToTaskType(stage),
      );
      return response.content;
    } catch (e) {
      _logger.e('Failed to orchestrate stage: $stage', e);
      rethrow;
    }
  }

  Future<List<String>> generateBattleIdeas() async {
    try {
      final response = await _smartRouter.routeAndExecute(
        'Generate 5 creative ASMR Battle ideas. Return JSON array of strings.',
        overrideType: AITaskType.creativeIdeation,
      );
      final jsonText = _cleanJson(response.content);
      return List<String>.from(jsonDecode(jsonText));
    } catch (e) {
       _logger.e('Failed to generate battle ideas', e);
       throw ServerFailure('Ideation Failed: $e');
    }
  }

  AITaskType _mapStageToTaskType(String stage) {
    if (stage.contains('idea')) return AITaskType.creativeIdeation;
    if (stage.contains('script')) return AITaskType.narrativeScripting;
    return AITaskType.technicalPrompting;
  }

  String _cleanJson(String text) {
    return text.replaceAll('```json', '').replaceAll('```', '').trim();
  }
}
