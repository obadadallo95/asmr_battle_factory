import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';
import 'package:asmr_battle_factory/core/utils/responsive_extensions.dart';
import 'package:asmr_battle_factory/features/history/presentation/providers/history_provider.dart';
import 'package:asmr_battle_factory/features/history/data/models/battle_history.dart';
import 'package:asmr_battle_factory/features/configurator/presentation/providers/battle_config_provider.dart';
import 'package:go_router/go_router.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);

    return historyAsync.when(
      data: (history) => history.isEmpty 
        ? _buildEmptyState(context)
        : _buildHistoryList(context, ref, history),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('common.error'.tr(args: ['$e']))),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.history, color: Colors.white10, size: 5.t),
          SizedBox(height: 1.g),
          Text(
            'history.empty'.tr(),
            style: GoogleFonts.cairo(color: Colors.white38, fontSize: 3.t),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context, WidgetRef ref, List<BattleHistory> history) {
    return ListView.separated(
      padding: context.gPadding(Factor.md),
      itemCount: history.length,
      separatorBuilder: (_, __) => SizedBox(height: 1.g),
      itemBuilder: (context, index) => _HistoryItem(entry: history[index]),
    ).animate().fadeIn(duration: 400.ms);
  }
}

class _HistoryItem extends ConsumerWidget {
  final BattleHistory entry;
  const _HistoryItem({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: context.gPadding(Factor.sm),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: context.gBorderRadius(Factor.sm),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          _buildLeadingInfo(context),
          SizedBox(width: 2.g),
          Expanded(child: _buildMainInfo(context)),
          SizedBox(width: 1.g),
          _buildActionButton(context, ref),
        ],
      ),
    );
  }

  Widget _buildLeadingInfo(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.flash_on, color: Colors.amberAccent, size: 3.t),
        SizedBox(height: 0.g),
        Text(
          DateFormat('MMM d').format(entry.timestamp),
          style: TextStyle(color: Colors.white24, fontSize: 1.t),
        ),
      ],
    );
  }

  Widget _buildMainInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entry.scriptTitle,
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 2.t,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 0.g),
        Row(
          children: [
            Text(
              entry.contestantNames.join(' ⚔️ '),
              style: TextStyle(color: Colors.white54, fontSize: 1.t),
            ),
            const Spacer(),
            Text(
              '\$${entry.actualCost.toStringAsFixed(3)}',
              style: TextStyle(color: Colors.cyanAccent.withValues(alpha: 0.7), fontSize: 1.t),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        // In a real app, this would need to load the full config
        // Since history only saves some fields, we might need to store full BattleConfig in entry
        // For now, satisfy the "Re-battle" intent by helping user load something
        context.push('/studio');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purpleAccent.withValues(alpha: 0.2),
        foregroundColor: Colors.white,
        padding: context.gSymmetricPadding(horizontal: Factor.sm, vertical: Factor.xs),
      ),
      child: Text('projects.produce'.tr(), style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
    );
  }
}
