import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle get headline => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        height: 1.3,
      );
  
  static TextStyle get body => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );
      
  static TextStyle get button => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );
}
