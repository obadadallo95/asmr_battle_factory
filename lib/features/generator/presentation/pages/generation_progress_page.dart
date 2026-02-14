import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GenerationProgressPage extends StatelessWidget {
  const GenerationProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
              child: Column(
                children: [
                  _buildHeader(),
                  const Spacer(),
                  _buildProgressVisualizer(),
                  const Spacer(),
                  _buildLiveCostRow(),
                  SizedBox(height: 40.h),
                  _buildCancelButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.5,
          colors: [
            Colors.purple.withValues(alpha: 0.1),
            const Color(0xFF0F0F1A),
          ],
        ),
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
     .shimmer(duration: 3.seconds, color: Colors.purple.withValues(alpha: 0.05));
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'جاري إنتاج الملحمة...',
          style: GoogleFonts.cairo(color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.bold),
        ),
        Text(
          'Creating the "Ant vs Bee" Epic Battle',
          style: GoogleFonts.montserrat(color: Colors.white38, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildProgressVisualizer() {
    return Column(
      children: [
        _buildStageItem('توليد السيناريو والأفكار', 'Script & Ideas', true, true),
        _buildConnector(true),
        _buildStageItem('توليد المشاهد البصرية', 'Visual Scenes (2/4)', true, false),
        _buildConnector(false),
        _buildStageItem('تحريك الفيديو والإنتاج', 'Video Rendering', false, false),
      ],
    );
  }

  Widget _buildStageItem(String labelAr, String labelEn, bool isStarted, bool isDone) {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: isDone ? Colors.greenAccent : (isStarted ? Colors.purpleAccent : Colors.white10),
            shape: BoxShape.circle,
            boxShadow: isStarted && !isDone ? [const BoxShadow(color: Colors.purpleAccent, blurRadius: 10)] : null,
          ),
          child: isDone ? const Icon(Icons.check, color: Colors.black, size: 14) : null,
        ).animate(onPlay: isStarted && !isDone ? (c) => c.repeat(reverse: true) : null)
         .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 800.ms),
        SizedBox(width: 20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelAr, style: GoogleFonts.cairo(
              color: isStarted ? Colors.white : Colors.white24, 
              fontSize: 16.sp, 
              fontWeight: isStarted ? FontWeight.bold : FontWeight.normal,
            )),
            Text(labelEn, style: TextStyle(color: isStarted ? Colors.white38 : Colors.white10, fontSize: 12.sp)),
          ],
        ),
        const Spacer(),
        if (isStarted && !isDone) const CircularProgressIndicator(strokeWidth: 2, color: Colors.purpleAccent),
      ],
    );
  }

  Widget _buildConnector(bool isDone) => Container(
    margin: EdgeInsets.only(left: 11.w),
    height: 40.h,
    width: 2,
    color: isDone ? Colors.greenAccent : Colors.white10,
  );

  Widget _buildLiveCostRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('التكلفة الحقيقية الآن', style: GoogleFonts.cairo(color: Colors.white38, fontSize: 12.sp)),
              Text('\$0.22', style: GoogleFonts.jetBrainsMono(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(color: Colors.greenAccent.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.trending_up, color: Colors.greenAccent),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(
        'إلغاء العملية (استرداد التكلفة المتبقية)',
        style: GoogleFonts.cairo(color: Colors.redAccent, fontSize: 14.sp),
      ),
    );
  }
}
