
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../domain/services/cost_calculator.dart';
import '../../data/models/cost_estimate.dart';
import '../../data/models/budget_stats.dart';
import '../../domain/repositories/budget_repository.dart';
import 'package:asmr_battle_factory/config/di/injection.dart';

import '../../../configurator/presentation/providers/battle_config_provider.dart';

// The main estimate provider
final costEstimateProvider = Provider.autoDispose.family<CostEstimate, int>((ref, sceneCount) {
  final config = ref.watch(battleConfigProvider);
  final mode = config.budgetMode;
  final isSlow = config.slowMotion;
  
  final calculator = GetIt.I<CostCalculator>();
  
  return calculator.calculate(
    mode: mode,
    sceneCount: sceneCount,
    isSlowMotion: isSlow,
    includeVoiceover: true, // simplified for now
  );
});

final budgetStatsProvider = FutureProvider<BudgetStats>((ref) async {
  final repo = getIt<BudgetRepository>();
  return repo.getStats();
});
