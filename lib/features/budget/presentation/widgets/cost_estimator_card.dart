import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/widgets/glass_card.dart';
import '../providers/budget_provider.dart';
import '../../data/models/cost_estimate.dart';
import '../../domain/models/budget_mode.dart';
import 'cost_breakdown_sheet.dart';

class CostEstimatorCard extends ConsumerStatefulWidget {
  final int sceneCount;
  
  const CostEstimatorCard({super.key, required this.sceneCount});

  @override
  ConsumerState<CostEstimatorCard> createState() => _CostEstimatorCardState();
}

class _CostEstimatorCardState extends ConsumerState<CostEstimatorCard> {
  // final bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final estimate = ref.watch(costEstimateProvider(widget.sceneCount));
    final color = _getStatusColor(estimate.totalCostUSD);

    return GestureDetector(
      onTap: () => _showDetailedBreakdown(context, estimate),
      child: GlassCard(
        color: Colors.black.withValues(alpha: 0.6),
        borderColor: color.withValues(alpha: 0.5),
        borderWidth: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with total cost
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '💰 تقدير التكلفة', 
                            style: GoogleFonts.cairo(color: Colors.white70, fontSize: 12.sp)
                          ),
                          SizedBox(width: 4.w),
                          Icon(Icons.info_outline, color: Colors.white38, size: 12.sp),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '\$${estimate.totalCostUSD.toStringAsFixed(2)}',
                        style: GoogleFonts.jetBrainsMono(
                          color: color, 
                          fontSize: 24.sp, 
                          fontWeight: FontWeight.bold
                        ),
                      ).animate(key: ValueKey(estimate.totalCostUSD))
                        .fadeIn(duration: 200.ms)
                        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: _getModeColor(estimate.mode),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          estimate.mode.label,
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.timer_outlined, color: Colors.white54, size: 12.sp),
                          SizedBox(width: 4.w),
                          Text(
                            '${estimate.totalDurationSeconds.toInt()}s',
                            style: TextStyle(color: Colors.white54, fontSize: 11.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Quick breakdown (always visible)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: const BoxDecoration(
                color: Colors.black26,
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: Column(
                children: [
                  // Duration progress bar
                  Row(
                    children: [
                      Icon(Icons.play_circle_outline, color: Colors.cyanAccent, size: 14.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'المدة الإجمالية',
                                  style: TextStyle(color: Colors.white70, fontSize: 11.sp),
                                ),
                                Text(
                                  '${estimate.totalDurationSeconds.toInt()}s',
                                  style: GoogleFonts.jetBrainsMono(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child: LinearProgressIndicator(
                                value: (estimate.totalDurationSeconds / 60).clamp(0.0, 1.0),
                                backgroundColor: Colors.white10,
                                color: Colors.cyanAccent,
                                minHeight: 6.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 12.h),
                  
                  // Mini cost items
                  _buildMiniCostRow('💡 Ideas + Script', 
                    estimate.breakdown.ideaGeneration + estimate.breakdown.scriptWriting,
                    estimate.apiStack.scriptProvider),
                  _buildMiniCostRow('🎨 Images (${widget.sceneCount})', 
                    estimate.breakdown.imageGeneration,
                    estimate.apiStack.imageProvider),
                  if (estimate.apiStack.videoProvider != null)
                    _buildMiniCostRow('🎬 Video Generation', 
                      estimate.breakdown.videoGeneration,
                      estimate.apiStack.videoProvider!),
                  _buildMiniCostRow('🔊 Voiceover', 
                    estimate.breakdown.audioGeneration,
                    'ElevenLabs'),
                    
                  // Tap hint
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app, color: Colors.white38, size: 12.sp),
                      SizedBox(width: 4.w),
                      Text(
                        'انقر لعرض التفاصيل الكاملة',
                        style: TextStyle(color: Colors.white38, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Optimization suggestions (if any)
            if (estimate.optimizationSuggestions.isNotEmpty)
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.yellow.withValues(alpha: 0.1),
                  border: Border(top: BorderSide(color: Colors.yellowAccent.withValues(alpha: 0.3))),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: Colors.yellowAccent, size: 14.sp),
                        SizedBox(width: 6.w),
                        Text(
                          'اقتراحات التوفير',
                          style: GoogleFonts.cairo(
                            color: Colors.yellowAccent,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    ...estimate.optimizationSuggestions.take(2).map((s) => Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        children: [
                          const Text('•', style: TextStyle(color: Colors.yellowAccent)),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              s,
                              style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
          ],
        ),
      ).animate().slideY(begin: 0.3, end: 0, duration: 400.ms, curve: Curves.easeOutQuart),
    );
  }

  Widget _buildMiniCostRow(String label, double cost, String provider) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.white70, fontSize: 11.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '\$${cost.toStringAsFixed(3)}',
            style: GoogleFonts.jetBrainsMono(
              color: Colors.white54,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailedBreakdown(BuildContext context, CostEstimate estimate) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CostBreakdownSheet(
        estimate: estimate,
        sceneCount: widget.sceneCount,
      ),
    );
  }

  Color _getStatusColor(double cost) {
    if (cost < 0.5) return Colors.greenAccent;
    if (cost < 2.0) return Colors.amberAccent;
    return Colors.redAccent;
  }

  Color _getModeColor(BudgetMode mode) {
    switch(mode) {
      case BudgetMode.economy: return Colors.green.withValues(alpha: 0.8);
      case BudgetMode.balanced: return Colors.amber.withValues(alpha: 0.8);
      case BudgetMode.premium: return Colors.red.withValues(alpha: 0.8);
      default: return Colors.grey.withValues(alpha: 0.8);
    }
  }
}
