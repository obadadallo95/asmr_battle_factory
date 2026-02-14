import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:asmr_battle_factory/features/generator/domain/repositories/generator_repository.dart';
import 'package:asmr_battle_factory/features/generator/domain/entities/battle_script.dart';
import 'package:asmr_battle_factory/features/ai/data/services/ai_orchestrator.dart';
import 'package:asmr_battle_factory/features/generator/data/models/battle_script_model.dart';
import 'package:asmr_battle_factory/core/errors/failures.dart';
import 'package:asmr_battle_factory/core/services/app_logger.dart';

import 'package:asmr_battle_factory/features/vault/data/repositories/vault_repository.dart';
import 'package:asmr_battle_factory/features/vault/data/models/saved_scenario.dart';

@LazySingleton(as: GeneratorRepository)
class GeneratorRepositoryImpl implements GeneratorRepository {
  final AIOrchestrator _aiOrchestrator;
  final VaultRepository _vaultRepository;
  final AppLogger _logger;
  static const String _cacheBoxName = 'battle_script_cache';

  GeneratorRepositoryImpl(this._aiOrchestrator, this._vaultRepository, this._logger);

  @override
  Future<Either<Failure, BattleScript>> generateBattleScript(List<String> contestants) async {
    try {
      if (contestants.isEmpty) {
        return const Left(ServerFailure('No contestants provided'));
      }

      final cacheKey = _generateCacheKey(contestants);
      // Ensure box is open (Lazy opening might be safer or check if open)
      final box = await Hive.openBox<BattleScriptModel>(_cacheBoxName);

      // Check Cache
      if (box.containsKey(cacheKey)) {
        _logger.i('Returning cached battle script for: $contestants');
        final cached = box.get(cacheKey);
        if (cached != null) {
          return Right(cached);
        }
      }

      // Call AI Orchestrator (Tries OpenAI -> DeepSeek -> Groq -> Gemini)
      final result = await _aiOrchestrator.generateBattleScript(contestants);
      
      // Save to Cache
      await box.put(cacheKey, result);
      
      // Save to Vault (History)
      try {
        final savedScenario = SavedScenario(
          id: result.id,
          titleAr: result.title, // Assuming title is language agnostic or English
          titleEn: result.title,
          briefDescriptionAr: 'Battle between ${contestants.join(' vs ')}',
          briefDescriptionEn: 'Battle between ${contestants.join(' vs ')}',
          contestantIds: contestants,
          savedAt: DateTime.now(),
          suggestedWinnerId: result.winner,
          providerUsed: 'AI Orchestrator',
        );
        await _vaultRepository.saveScenario(savedScenario);
        _logger.d('Battle saved to Vault: ${result.id}');
      } catch (e) {
        _logger.e('Failed to save to Vault', e);
        // Don't fail the generation if vault save fails
      }
      
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> generateBattleIdeas() async {
    try {
      final ideas = await _aiOrchestrator.generateBattleIdeas();
      return Right(ideas);
    } catch (e) {
      _logger.e('Failed to generate battle ideas', e);
      return Left(ServerFailure(e.toString()));
    }
  }

  String _generateCacheKey(List<String> contestants) {
    // Sort to ensure "A vs B" is same as "B vs A" for caching
    final sorted = List.from(contestants)..sort();
    final combined = sorted.join('_');
    return md5.convert(utf8.encode(combined)).toString();
  }
}
