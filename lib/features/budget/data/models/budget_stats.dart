import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_stats.freezed.dart';

@freezed
class BudgetStats with _$BudgetStats {
  const factory BudgetStats({
    required double totalSpentToday,
    required double totalSpentThisMonth,
    required int videosGeneratedToday,
    required int videosGeneratedThisMonth,
    required double averageCostPerVideo,
    required Map<String, double> spendingByProvider,
    required DateTime lastUpdated,
  }) = _BudgetStats;
}

@freezed
class BudgetAlert with _$BudgetAlert {
  const factory BudgetAlert({
    required String message,
    required AlertLevel level,
    required DateTime timestamp,
  }) = _BudgetAlert;
}

enum AlertLevel { info, warning, critical }
