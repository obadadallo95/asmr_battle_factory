import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Golden Ratio Design System
/// Provides mathematically harmonious, proportional sizing using φ = 1.618
class GoldenRatio {
  GoldenRatio._();
  
  /// The Golden Ratio constant (φ)
  static const double phi = 1.618033988749;
  
  /// Calculate size based on screen width using golden ratio divisions
  /// divisions = 1 → width/φ, divisions = 2 → width/φ², etc.
  static double ofWidth(double screenWidth, {int divisions = 1}) {
    return screenWidth / math.pow(phi, divisions);
  }
  
  /// Calculate size based on screen height using golden ratio divisions
  static double ofHeight(double screenHeight, {int divisions = 1}) {
    return screenHeight / math.pow(phi, divisions);
  }
  
  /// Get proportional padding/margin based on spacing factor
  /// Uses golden ratio to create harmonious spacing scale
  static double spacing(BuildContext? context, {required Factor factor}) {
    final base = ScreenUtil().screenWidth / (phi * 10); // Base unit
    switch(factor) {
      case Factor.xs:
        return base;
      case Factor.sm:
        return base * phi;
      case Factor.md:
        return base * phi * phi;
      case Factor.lg:
        return base * phi * phi * phi;
      case Factor.xl:
        return base * math.pow(phi, 4);
      case Factor.xxl:
        return base * math.pow(phi, 5);
    }
  }
  
  /// Text sizes following golden ratio scale
  /// Creates harmonious typography hierarchy
  static double textSize(BuildContext? context, TextScale scale) {
    final base = 10.0.sp; // Base font size
    switch(scale) {
      case TextScale.xs:
        return base;
      case TextScale.sm:
        return base * 1.2;
      case TextScale.base:
        return base * phi; // ~16.18sp
      case TextScale.lg:
        return base * phi * 1.2;
      case TextScale.xl:
        return base * math.pow(phi, 2);
      case TextScale.xxl:
        return base * math.pow(phi, 2) * 1.2;
      case TextScale.xxxl:
        return base * math.pow(phi, 3);
    }
  }
  
  /// Widget sizes (cards, buttons, etc.) based on screen width
  /// Uses golden ratio divisions for proportional component sizing
  static double componentSize(BuildContext? context, ComponentSize size) {
    final width = ScreenUtil().screenWidth;
    switch(size) {
      case ComponentSize.xs:
        return width / (phi * 6);
      case ComponentSize.sm:
        return width / (phi * 4);
      case ComponentSize.md:
        return width / (phi * 3);
      case ComponentSize.lg:
        return width / (phi * 2);
      case ComponentSize.xl:
        return width / phi;
      case ComponentSize.full:
        return width;
    }
  }
  
  /// Get proportional border radius
  static double radius(Factor factor) {
    return spacing(null, factor: factor);
  }
}

/// Spacing/padding size factors
enum Factor { 
  xs,   // Tiny spacing
  sm,   // Small spacing
  md,   // Medium spacing
  lg,   // Large spacing
  xl,   // Extra large spacing
  xxl   // Huge spacing
}

/// Text size scale
enum TextScale { 
  xs,    // Tiny text
  sm,    // Small text
  base,  // Base/body text
  lg,    // Large text
  xl,    // Extra large text
  xxl,   // Huge text
  xxxl   // Massive text
}

/// Component size scale
enum ComponentSize { 
  xs,   // Tiny component
  sm,   // Small component
  md,   // Medium component
  lg,   // Large component
  xl,   // Extra large component
  full  // Full width
}
