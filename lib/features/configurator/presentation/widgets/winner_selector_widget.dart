import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/configurator/presentation/pages/battle_configurator_page.dart';
import 'package:asmr_battle_factory/features/configurator/data/models/battle_config.dart';
import 'package:asmr_battle_factory/features/contestants/presentation/providers/contestants_provider.dart';

class WinnerSelectorWidget extends ConsumerWidget {
  const WinnerSelectorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(battleConfigProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'configurator.winner.title'.tr(),
          style: GoogleFonts.cairo(color: Colors.white54, fontSize: 13.sp),
        ),
        SizedBox(height: 15.h),
        _modeItem(ref, WinnerMode.aiDecided, 'configurator.winner.ai'.tr(), Icons.psychology),
        _modeItem(ref, WinnerMode.random, 'configurator.winner.random'.tr(), Icons.casino),
        _modeItem(ref, WinnerMode.userSelected, 'configurator.winner.manual'.tr(), Icons.touch_app),
        
        if (config.winnerMode == WinnerMode.userSelected && config.selectedContestantIds.isNotEmpty)
          _buildContestantPicker(ref, config),
      ],
    );
  }

  Widget _modeItem(WidgetRef ref, WinnerMode mode, String label, IconData icon) {
    final config = ref.watch(battleConfigProvider);
    final isSelected = config.winnerMode == mode;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: InkWell(
        onTap: () => ref.read(battleConfigProvider.notifier).update((s) => s.copyWith(winnerMode: mode)),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purpleAccent.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: isSelected ? Colors.purpleAccent : Colors.white10),
          ),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? Colors.purpleAccent : Colors.white24, size: 20.sp),
              SizedBox(width: 12.w),
              Text(label, style: GoogleFonts.cairo(color: isSelected ? Colors.white : Colors.white38, fontSize: 13.sp)),
              const Spacer(),
              if (isSelected) const Icon(Icons.check_circle, color: Colors.purpleAccent, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContestantPicker(WidgetRef ref, BattleConfig config) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: ref.watch(contestantsProvider).when(
        data: (allContestants) => Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: config.selectedContestantIds.map((id) {
            final contestant = allContestants.firstWhere(
              (c) => c.id == id,
              orElse: () => allContestants.first,
            );
            final isWinner = config.userSelectedWinnerId == id;
            return InkWell(
              onTap: () => ref.read(battleConfigProvider.notifier).update((s) => s.copyWith(userSelectedWinnerId: id)),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: isWinner ? Colors.amber.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: isWinner ? Colors.amber : Colors.white10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(contestant.iconAsset),
                    if (isWinner) ...[
                      SizedBox(width: 5.w),
                      const Icon(Icons.emoji_events, color: Colors.amber, size: 14),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (_, __) => const SizedBox(),
      ),
    );
  }
}
