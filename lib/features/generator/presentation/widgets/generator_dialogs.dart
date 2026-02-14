import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/generator_provider.dart';

class GeneratorDialogs {
  static void showDominoDialog(BuildContext context, GeneratorNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2C),
        title: Text("generator.domino.dialog_title".tr(), style: GoogleFonts.cairo(color: Colors.white)),
        content: Text(
          "generator.domino.dialog_desc".tr(),
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            child: Text("generator.domino.battles_option".tr(args: ['5'])),
            onPressed: () {
              Navigator.pop(context);
              notifier.startDominoMode(5);
            },
          ),
          TextButton(
            child: Text("generator.domino.battles_option".tr(args: ['10'])),
            onPressed: () {
              Navigator.pop(context);
              notifier.startDominoMode(10);
            },
          ),
        ],
      ),
    );
  }

  static void showCostWarningDialog(BuildContext context, dynamic estimate, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r), side: const BorderSide(color: Colors.redAccent, width: 2)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
            SizedBox(width: 10.w),
            Text("generator.cost_warning.title".tr(), style: GoogleFonts.cairo(color: Colors.white)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "generator.cost_warning.desc".tr(),
              style: const TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 10.h),
            Text(
              "\$${estimate.totalCostUSD.toStringAsFixed(2)}",
              style: GoogleFonts.jetBrainsMono(color: Colors.redAccent, fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Text(
              "generator.cost_warning.provider_note".tr(args: [estimate.apiStack.videoProvider ?? 'Video']),
              style: TextStyle(color: Colors.white54, fontSize: 12.sp),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("generator.cost_warning.edit_btn".tr(), style: const TextStyle(color: Colors.white70)),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: Text("generator.cost_warning.confirm_btn".tr(), style: const TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
          ),
        ],
      ),
    );
  }
}
