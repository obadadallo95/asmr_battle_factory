import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/vault/data/models/saved_scenario.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:asmr_battle_factory/features/contestants/presentation/providers/contestants_provider.dart';

class SavedScenarioCard extends ConsumerWidget {
  final SavedScenario scenario;

  const SavedScenarioCard({super.key, required this.scenario});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C2D),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContestantPreview(ref),
                SizedBox(height: 15.h),
                Text(
                  context.locale.languageCode == 'ar' ? scenario.titleAr : scenario.titleEn,
                  style: GoogleFonts.cairo(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
// ... (middle content same)
                SizedBox(height: 5.h),
                Text(
                  context.locale.languageCode == 'ar' ? scenario.briefDescriptionAr : scenario.briefDescriptionEn,
                  style: GoogleFonts.cairo(color: Colors.white38, fontSize: 12.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTwistBadge(context),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.05),
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                      ),
                      child: Text('generator.initiate_btn'.tr(), style: GoogleFonts.cairo(color: Colors.purpleAccent, fontSize: 11.sp)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.white10, size: 18),
              onPressed: () {},
            ),
          ),
        ],
      ),
    ).animate().fadeIn().scale(duration: 400.ms, curve: Curves.easeOutBack);
  }

  Widget _buildContestantPreview(WidgetRef ref) {
    final contestantsAsync = ref.watch(contestantsProvider);

    return Row(
      children: scenario.contestantIds.take(3).map((id) {
        return contestantsAsync.when(
          data: (all) {
            final c = all.firstWhere((item) => item.id == id, orElse: () => all.first);
            return Container(
              margin: EdgeInsets.only(left: 8.w),
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.03), shape: BoxShape.circle),
              child: Text(c.iconAsset, style: TextStyle(fontSize: 18.sp)),
            );
          },
          loading: () => Container(width: 32.w, height: 32.w, color: Colors.white10),
          error: (_, __) => const SizedBox(),
        );
      }).toList(),
    );
  }

  Widget _buildTwistBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: Colors.amber, size: 12),
          SizedBox(width: 5.w),
          Text(
            'vault.twist_label'.tr(args: ['${scenario.twistLevel}']),
            style: GoogleFonts.jetBrainsMono(color: Colors.amber, fontSize: 10.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
