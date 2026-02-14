
import 'package:injectable/injectable.dart';
import 'package:asmr_battle_factory/features/ai/data/adapters/ai_provider_adapter.dart';
import 'package:asmr_battle_factory/features/ai/domain/models/task_type.dart';
import 'package:asmr_battle_factory/features/ai/domain/models/unified_request.dart';
import 'package:asmr_battle_factory/core/services/app_logger.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/repositories/provider_repository.dart';
import 'package:asmr_battle_factory/core/services/security/api_key_service.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';

enum RoutingPriority { speed, quality, cost, balanced }

@singleton
class SmartRouter {
  final IProviderRepository _db;
  final APIKeyService _keyService;
  final Map<String, AIProviderAdapter> _adapters = {};
  final AppLogger _logger;

  RoutingPriority _currentPriority = RoutingPriority.balanced;

  SmartRouter(this._db, this._keyService, this._logger);

  void registerAdapter(AIProviderAdapter adapter) {
    _adapters[adapter.providerId] = adapter;
  }

  void setPriority(RoutingPriority priority) {
    _currentPriority = priority;
    _logger.i('SmartRouter priority set to: $priority');
  }

  Future<UnifiedResponse> routeAndExecute(String prompt, {
    AITaskType? overrideType,
    RoutingPriority? overridePriority,
  }) async {
    final taskType = overrideType ?? TaskClassifier.classify(prompt);
    final priority = overridePriority ?? _currentPriority;
    
    // Get all providers from marketplace catalog
    final allProviders = _db.getAll();
    
    // Filter to those with configured keys OR those that don't require keys (like Pollinations)
    final candidates = <ProviderCatalogEntry>[];
    for (var p in allProviders) {
      if (!p.requiresKey || await _keyService.isConfigured(p.id)) {
        candidates.add(p);
      }
    }

    if (candidates.isEmpty) {
      throw Exception('No AI providers configured. Please go to Marketplace to add API keys.');
    }

    // Scoring based on catalog ratings and task priority
    final scoredCandidates = candidates.map((entry) {
      final score = _calculateDynamicScore(entry, taskType, priority);
      return MapEntry(entry, score);
    }).toList();

    scoredCandidates.sort((a, b) => b.value.compareTo(a.value));

    for (final entry in scoredCandidates) {
      final catalogEntry = entry.key;
      final adapter = _adapters[catalogEntry.id];

      if (adapter == null) continue; // Skip if adapter not registered

      try {
        if (!await adapter.isAvailable()) continue;

        final request = UnifiedRequest.simple(prompt, taskType);
        return await adapter.generate(request);
      } catch (e) {
        _logger.e('Failed to execute with ${catalogEntry.name}', e);
      }
    }

    throw Exception('All AI providers failed to execute the task.');
  }

  double _calculateDynamicScore(ProviderCatalogEntry entry, AITaskType taskType, RoutingPriority priority) {
    double score = entry.qualityRating / 5.0;

    switch (priority) {
      case RoutingPriority.speed:
        score += (entry.speedRating / 5.0) * 0.5;
        break;
      case RoutingPriority.quality:
        score *= 1.5;
        break;
      case RoutingPriority.cost:
        score += (entry.costEfficiencyRating / 5.0) * 0.4;
        break;
      case RoutingPriority.balanced:
        score += (entry.speedRating / 5.0) * 0.2;
        score += (entry.costEfficiencyRating / 5.0) * 0.1;
        break;
    }
    return score;
  }
}
