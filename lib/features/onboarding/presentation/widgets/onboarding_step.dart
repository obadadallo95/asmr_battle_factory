// Lines: 120/100
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingStep extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Widget? trailing; // For input field/buttons in last step

  const OnboardingStep({
    required this.imagePath,
    required this.title,
    required this.description,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  // Image / Illustration
                  SizedBox(
                    height: 300.h,
                    child: Center(
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                      ).animate(onPlay: (c) => c.repeat(reverse: true))
                       .moveY(begin: 0, end: -10, duration: 3.seconds, curve: Curves.easeInOut),
                    ),
                  ),
                  
                  SizedBox(height: 32.h),

                  // Text Content
                  Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
                      
                      SizedBox(height: 16.h),
                      
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          color: Colors.white70,
                          fontSize: 16.sp,
                          height: 1.5,
                        ),
                      ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

                      if (trailing != null) ...[
                        SizedBox(height: 32.h),
                        trailing!,
                      ]
                    ],
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
