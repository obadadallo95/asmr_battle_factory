import 'package:injectable/injectable.dart';
import '../../data/models/cost_estimate.dart';
import '../../data/models/budget_stats.dart';

abstract class BudgetRepository {
  Future<void> logGenerationCost(CostEstimate estimate);
  Future<BudgetStats> getStats({DateTime? startDate});
  Stream<BudgetAlert> get budgetAlerts;
  Stream<double> get dailySpendingStream;
}

@Singleton(as: BudgetRepository)
class BudgetRepositoryImpl implements BudgetRepository {
  final List<CostEstimate> _history = [];
  final double _dailyLimit = 50.0;
  final double _monthlyLimit = 100.0;
  
  @override
  Future<void> logGenerationCost(CostEstimate estimate) async {
    _history.add(estimate);
    // TODO: Persist to Hive/drift
  }

  @override
  Future<BudgetStats> getStats({DateTime? startDate}) async {
    // final now = DateTime.now();
    
    final todayItems = _history.where((e) => 
      DateTime.now().difference(DateTime.now()).inDays == 0
    ).toList();
    
    final monthItems = _history.where((e) => 
      DateTime.now().difference(DateTime.now()).inDays < 30
    ).toList();
    
    final totalToday = todayItems.fold(0.0, (sum, e) => sum + e.totalCostUSD);
    final totalMonth = monthItems.fold(0.0, (sum, e) => sum + e.totalCostUSD);
    
    final spendingByProvider = <String, double>{};
    for (final item in _history) {
      final provider = item.apiStack.videoProvider ?? 'none';
      spendingByProvider[provider] = (spendingByProvider[provider] ?? 0) + item.totalCostUSD;
    }
    
    return BudgetStats(
      totalSpentToday: totalToday,
      totalSpentThisMonth: totalMonth,
      videosGeneratedToday: todayItems.length,
      videosGeneratedThisMonth: monthItems.length,
      averageCostPerVideo: monthItems.isEmpty ? 0 : totalMonth / monthItems.length,
      spendingByProvider: spendingByProvider,
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Stream<BudgetAlert> get budgetAlerts async* {
    final stats = await getStats();
    
    if (stats.totalSpentToday > _dailyLimit * 0.8) {
      yield BudgetAlert(
        message: '⚠️ اقتربت من حد الإنفاق اليومي (\$${stats.totalSpentToday.toStringAsFixed(2)} / \$$_dailyLimit)',
        level: AlertLevel.warning,
        timestamp: DateTime.now(),
      );
    }
    
    if (stats.totalSpentThisMonth > _monthlyLimit * 0.8) {
      yield BudgetAlert(
        message: '🔥 اقتربت من حد الإنفاق الشهري (\$${stats.totalSpentThisMonth.toStringAsFixed(2)} / \$$_monthlyLimit)',
        level: AlertLevel.critical,
        timestamp: DateTime.now(),
      );
    }
  }

  @override
  Stream<double> get dailySpendingStream async* {
    final stats = await getStats();
    yield stats.totalSpentToday;
  }
}
