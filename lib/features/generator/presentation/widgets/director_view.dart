// Lines: 60/100
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/widgets/glass_card.dart';

class DirectorView extends StatelessWidget {
  final List<String> logs;

  const DirectorView({required this.logs, super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.movie_creation, color: Colors.redAccent, size: 20.sp)
                  .animate(onPlay: (c) => c.repeat())
                  .fadeIn(duration: 1.seconds)
                  .then()
                  .fadeOut(duration: 1.seconds),
              SizedBox(width: 8.w),
              Text(
                "DIRECTOR'S VIEW",
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          Divider(color: Colors.white12, height: 24.h),
          SizedBox(
            height: 150.h,
            child: ListView.builder(
              reverse: true, // Show latest at bottom (visually top if we reverse list)
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[logs.length - 1 - index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    "> $log",
                    style: GoogleFonts.jetBrainsMono(
                      color: Colors.greenAccent,
                      fontSize: 12.sp,
                    ),
                  ).animate().fadeIn().slideX(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
