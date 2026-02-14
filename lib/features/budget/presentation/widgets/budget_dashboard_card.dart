import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';
import 'package:asmr_battle_factory/core/utils/responsive_extensions.dart';
import '../../../../core/widgets/glass_card.dart';
import 'package:asmr_battle_factory/features/budget/presentation/providers/budget_provider.dart';

class BudgetDashboardCard extends ConsumerWidget {
  const BudgetDashboardCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(budgetStatsProvider);

    return GlassCard(
      child: Padding(
        padding: context.gPadding(Factor.sm),
        child: statsAsync.when(
          data: (stats) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'budget.dashboard.title'.tr(),
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 2.t,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.g, vertical: 0.g),
                    decoration: BoxDecoration(
                      color: _getAlertColor(stats.totalSpentToday),
                      borderRadius: context.gBorderRadius(Factor.xs),
                    ),
                    child: Text(
                      stats.totalSpentToday < 10
                          ? 'budget.dashboard.status.good'.tr()
                          : 'budget.dashboard.status.warning'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 0.t),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.g),
              
              _buildStatRow('budget.dashboard.spent_today'.tr(), '\$${stats.totalSpentToday.toStringAsFixed(2)}'),
              _buildStatRow('budget.dashboard.videos_today'.tr(), 'budget.dashboard.video_count'.tr(args: ['${stats.videosGeneratedToday}'])),
              _buildStatRow('budget.dashboard.avg_cost'.tr(), '\$${stats.averageCostPerVideo.toStringAsFixed(2)}'),
              
              Divider(color: Colors.white12, height: 2.g),
              
              _buildStatRow('budget.dashboard.spent_month'.tr(), '\$${stats.totalSpentThisMonth.toStringAsFixed(2)}'),
              _buildStatRow('budget.dashboard.videos_month'.tr(), 'budget.dashboard.video_count'.tr(args: ['${stats.videosGeneratedThisMonth}'])),
              
              if (stats.totalSpentThisMonth > 50) ...[
                SizedBox(height: 1.g),
                Container(
                  padding: EdgeInsets.all(1.g),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: context.gBorderRadius(Factor.xs),
                    border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 2.t),
                      SizedBox(width: 0.g),
                      Expanded(
                        child: Text(
                          'budget.dashboard.monthly_warning'.tr(),
                          style: TextStyle(color: Colors.orange, fontSize: 1.t),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('budget.dashboard.load_error'.tr(), style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 1.t),
          ),
          Text(
            value,
            style: GoogleFonts.jetBrainsMono(
              color: Colors.white,
              fontSize: 1.t,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getAlertColor(double spent) {
    if (spent < 10) return Colors.green;
    if (spent < 30) return Colors.orange;
    return Colors.red;
  }
}
