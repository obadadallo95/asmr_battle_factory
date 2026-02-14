import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../data/models/cost_estimate.dart';

class CostBreakdownSheet extends StatelessWidget {
  final CostEstimate estimate;
  final int sceneCount;

  const CostBreakdownSheet({
    super.key,
    required this.estimate,
    required this.sceneCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'budget.breakdown.title'.tr(),
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
          _buildStepCard(
            step: 'budget.breakdown.step'.tr(args: ['1']),
            title: 'budget.breakdown.idea_title'.tr(),
            provider: estimate.apiStack.ideaProvider,
            details: 'budget.breakdown.idea_details'.tr(),
            cost: estimate.breakdown.ideaGeneration,
            icon: '💡',
          ),
          
          _buildStepCard(
            step: 'budget.breakdown.step'.tr(args: ['2']),
            title: 'budget.breakdown.script_title'.tr(),
            provider: estimate.apiStack.scriptProvider,
            details: 'budget.breakdown.script_details'.tr(),
            cost: estimate.breakdown.scriptWriting,
            icon: '📝',
          ),
          
          _buildStepCard(
            step: 'budget.breakdown.step'.tr(args: ['3']),
            title: 'budget.breakdown.image_title'.tr(),
            provider: estimate.apiStack.imageProvider,
            details: 'budget.breakdown.image_details'.tr(args: ['$sceneCount']),
            cost: estimate.breakdown.imageGeneration,
            icon: '🎨',
          ),
          
          if (estimate.apiStack.videoProvider != null)
            _buildStepCard(
              step: 'budget.breakdown.step'.tr(args: ['4']),
              title: 'budget.breakdown.video_title'.tr(),
              provider: estimate.apiStack.videoProvider!,
              details: 'budget.breakdown.video_details'.tr(args: ['${estimate.totalDurationSeconds.toInt()}']),
              cost: estimate.breakdown.videoGeneration,
              icon: '🎬',
            ),
          
          _buildStepCard(
            step: 'budget.breakdown.step'.tr(args: [estimate.apiStack.videoProvider != null ? '5' : '4']),
            title: 'budget.breakdown.voice_title'.tr(),
            provider: 'ElevenLabs',
            details: 'budget.breakdown.voice_details'.tr(),
            cost: estimate.breakdown.audioGeneration,
            icon: '🔊',
          ),
          
          Divider(color: Colors.white12, height: 32.h),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'budget.breakdown.total'.tr(),
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${estimate.totalCostUSD.toStringAsFixed(2)}',
                style: GoogleFonts.jetBrainsMono(
                  color: _getCostColor(estimate.totalCostUSD),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          if (estimate.optimizationSuggestions.isNotEmpty) ...[
            SizedBox(height: 20.h),
            Text(
              'budget.breakdown.saving_suggestions'.tr(),
              style: GoogleFonts.cairo(
                color: Colors.yellowAccent,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            ...estimate.optimizationSuggestions.map((suggestion) => 
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.yellowAccent, size: 16.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        _resolveSuggestion(context, suggestion),
                        style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepCard({
    required String step,
    required String title,
    required String provider,
    required String details,
    required double cost,
    required String icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: TextStyle(fontSize: 20.sp)),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$step: $title',
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$provider · $details',
                      style: TextStyle(color: Colors.white38, fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${cost.toStringAsFixed(4)}',
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.white70,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCostColor(double cost) {
    if (cost < 0.5) return Colors.greenAccent;
    if (cost < 2.0) return Colors.amberAccent;
    return Colors.redAccent;
  }

  String _resolveSuggestion(BuildContext context, String suggestion) {
    final parts = suggestion.split('|');
    final key = parts.first;
    final args = parts.length > 1 ? parts.sublist(1) : const <String>[];
    return context.tr(key, args: args);
  }
}
