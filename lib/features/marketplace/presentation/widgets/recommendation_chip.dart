import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/services/provider_recommender.dart';
import 'package:asmr_battle_factory/features/budget/domain/models/budget_mode.dart';
import 'package:asmr_battle_factory/config/di/injection.dart';
import 'package:asmr_battle_factory/features/configurator/presentation/providers/battle_config_provider.dart';

final recommendationProvider = Provider.family<Recommendation, BudgetMode>((ref, mode) {
  final recommender = getIt<ProviderRecommender>();
  return recommender.suggest(mode);
});

class RecommendationChip extends ConsumerWidget {
  const RecommendationChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(battleConfigProvider.select((s) => s.budgetMode));
    final recommendation = ref.watch(recommendationProvider(mode));

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amberAccent, size: 16.sp),
              SizedBox(width: 8.w),
              Text(
                'توصية ذكية | Smart Mix',
                style: GoogleFonts.cairo(
                  color: Colors.amberAccent,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                'جودة: ${recommendation.qualityScore}/10',
                style: TextStyle(color: Colors.white38, fontSize: 10.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            recommendation.messageAr,
            style: TextStyle(color: Colors.white70, fontSize: 11.sp),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProviderSmall(recommendation.ideaProvider, 'Ideas'),
              Icon(Icons.arrow_forward_ios, size: 10.sp, color: Colors.white24),
              _buildProviderSmall(recommendation.imageProvider, 'Images'),
              if (recommendation.videoProvider != null) ...[
                Icon(Icons.arrow_forward_ios, size: 10.sp, color: Colors.white24),
                _buildProviderSmall(recommendation.videoProvider!, 'Video'),
              ],
            ],
          ),
        ],
      ),
    ).animate().slideX(begin: 0.1, end: 0, duration: 400.ms);
  }

  Widget _buildProviderSmall(String id, String label) {
    return Column(
      children: [
        Text(
          id.toUpperCase(),
          style: GoogleFonts.jetBrainsMono(
            color: Colors.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white38, fontSize: 8.sp),
        ),
      ],
    );
  }
}
