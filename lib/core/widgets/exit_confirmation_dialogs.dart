import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui';

class ExitConfirmationDialogs {
  
  static Future<bool> showCriticalExitDialog(BuildContext context, {String? operationName, double? cost}) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: const Color(0xFF1E1E2C).withValues(alpha: 0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: const BorderSide(color: Colors.redAccent, width: 2),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent, size: 28),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  // "⚠️ Critical Operation in Progress"
                  "safety.critical_title".tr(), 
                  style: GoogleFonts.cairo(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // "Generating video worth $4.50..."
                 "safety.critical_desc".tr(args: [operationName ?? '', cost?.toStringAsFixed(2) ?? '0.0']), // Add keys later
                style: GoogleFonts.cairo(color: Colors.white70, fontSize: 14.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                // "Exiting now may result in losing money and failure."
                "safety.critical_warning".tr(),
                style: GoogleFonts.cairo(color: Colors.redAccent, fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Stay
              child: Text("safety.stay_btn".tr(), style: GoogleFonts.cairo(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.of(context).pop(true), // Exit
              child: Text("safety.exit_btn".tr(), style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    ) ?? false;
  }

  static Future<bool> showUnsavedChangesDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(
          children: [
             const Icon(Icons.lightbulb_outline, color: Colors.yellowAccent),
             SizedBox(width: 10.w),
             Text("safety.unsaved_title".tr(), style: GoogleFonts.cairo(color: Colors.white)),
          ],
        ),
        content: Text(
          "safety.unsaved_desc".tr(),
          style: GoogleFonts.cairo(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Stay
            child: Text("safety.cancel_btn".tr(), style: GoogleFonts.cairo(color: Colors.white54)),
          ),
          TextButton(
             onPressed: () => Navigator.of(context).pop(true), // Discard & Exit
             child: Text("safety.discard_btn".tr(), style: GoogleFonts.cairo(color: Colors.redAccent)),
          ),
          // Save option could be added here if callback provided
        ],
      ),
    ) ?? false;
  }
}
