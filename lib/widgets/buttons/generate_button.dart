import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class GenerateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;

  const GenerateButton({
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.h,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(20.r),
          child: Center(
            child: isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.white.withValues(alpha: 0.5),
                    highlightColor: Colors.white,
                    child: Text(
                      'PROCESSING...',
                      style: AppTextStyles.button.copyWith(fontSize: 18.sp),
                    ),
                  )
                : Text(
                    text.toUpperCase(),
                    style: AppTextStyles.button.copyWith(
                      fontSize: 18.sp,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
