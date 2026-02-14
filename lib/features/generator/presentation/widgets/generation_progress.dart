// Lines: 80/100
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class GenerationProgress extends StatelessWidget {
  final int currentStep; // 0..3

  const GenerationProgress({required this.currentStep, super.key});

  @override
  Widget build(BuildContext context) {
    final steps = ['Script', 'Images', 'Videos', 'Final'];

    return SizedBox(
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          final isActive = index <= currentStep;
          final isCurrent = index == currentStep;
          
          return Expanded(
            child: Column(
              children: [
                // Icon / Dot
                AnimatedContainer(
                  duration: 300.ms,
                  width: isCurrent ? 24.w : 16.w,
                  height: isCurrent ? 24.w : 16.w,
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF8B5CF6) : Colors.white12,
                    shape: BoxShape.circle,
                    boxShadow: isActive ? [
                      BoxShadow(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ] : [],
                  ),
                  child: isActive ? Icon(Icons.check, size: 10.sp, color: Colors.white) : null,
                ),
                SizedBox(height: 8.h),
                // Text
                Text(
                  steps[index],
                  style: GoogleFonts.cairo(
                    color: isActive ? Colors.white : Colors.white30,
                    fontSize: 10.sp,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ).animate(target: isActive ? 1 : 0).scale(begin: const Offset(0.9, 0.9)),
          );
        }),
      ),
    );
  }
}
