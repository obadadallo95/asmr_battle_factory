import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/budget_mode.dart';

part 'cost_estimate.freezed.dart';

@freezed
class CostEstimate with _$CostEstimate {
  const factory CostEstimate({
    required double totalCostUSD,
    required double totalDurationSeconds,
    required CostBreakdown breakdown,
    required ProviderStack apiStack, // Which providers were selected
    required String riskLevel, // Low, Medium, High
    required BudgetMode mode,
    @Default([]) List<String> optimizationSuggestions,
  }) = _CostEstimate;
}

@freezed
class CostBreakdown with _$CostBreakdown {
  const factory CostBreakdown({
    required double ideaGeneration,
    required double scriptWriting,
    required double imageGeneration,
    required double videoGeneration,
    required double audioGeneration,
  }) = _CostBreakdown;
}
