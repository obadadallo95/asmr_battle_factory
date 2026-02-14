// Lines: 45/100
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;

  const GlassCard({
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.onTap,
    this.color,
    this.borderColor,
    this.borderWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            padding: padding ?? EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: color ?? Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: borderColor ?? Colors.white.withValues(alpha: 0.1),
                width: borderWidth ?? 1.w,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
