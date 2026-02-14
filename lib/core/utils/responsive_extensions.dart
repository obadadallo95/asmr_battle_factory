import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';

/// Responsive extensions using Golden Ratio for proportional sizing

extension ResponsiveDouble on double {
  /// Golden ratio proportional width
  /// Usage: 1.0.gw (screen width / φ)
  double get gw => GoldenRatio.ofWidth(ScreenUtil().screenWidth, divisions: toInt());
  
  /// Golden ratio proportional height
  /// Usage: 1.0.gh (screen height / φ)
  double get gh => GoldenRatio.ofHeight(ScreenUtil().screenHeight, divisions: toInt());

  /// Golden ratio spacing
  double get g => GoldenRatio.spacing(null, factor: Factor.values[toInt().clamp(0, Factor.values.length - 1)]);

  /// Golden ratio text size
  double get t => GoldenRatio.textSize(null, TextScale.values[toInt().clamp(0, TextScale.values.length - 1)]);
}

extension ResponsiveInt on int {
  /// Safe spacing using golden ratio: 0.g, 1.g, 2.g, etc.
  /// Maps to Factor enum values
  double get g {
    if (this < 0 || this >= Factor.values.length) {
      return GoldenRatio.spacing(null, factor: Factor.sm);
    }
    return GoldenRatio.spacing(null, factor: Factor.values[this]);
  }
  
  /// Text scale: 0.t, 1.t, 2.t, etc.
  /// Maps to TextScale enum values
  double get t {
    if (this < 0 || this >= TextScale.values.length) {
      return GoldenRatio.textSize(null, TextScale.base);
    }
    return GoldenRatio.textSize(null, TextScale.values[this]);
  }
  
  /// Component size: 0.c, 1.c, 2.c, etc.
  /// Maps to ComponentSize enum values
  double get c {
    if (this < 0 || this >= ComponentSize.values.length) {
      return GoldenRatio.componentSize(null, ComponentSize.md);
    }
    return GoldenRatio.componentSize(null, ComponentSize.values[this]);
  }
}

extension ResponsiveBuildContext on BuildContext {
  /// Get proportional padding: context.gPadding(Factor.md)
  EdgeInsets gPadding(Factor factor) {
    final value = GoldenRatio.spacing(this, factor: factor);
    return EdgeInsets.all(value);
  }
  
  /// Get symmetric padding with different horizontal/vertical factors
  EdgeInsets gSymmetricPadding({
    Factor horizontal = Factor.sm, 
    Factor vertical = Factor.xs
  }) {
    return EdgeInsets.symmetric(
      horizontal: GoldenRatio.spacing(this, factor: horizontal),
      vertical: GoldenRatio.spacing(this, factor: vertical),
    );
  }
  
  /// Get directional padding
  EdgeInsets gDirectionalPadding({
    Factor? start,
    Factor? top,
    Factor? end,
    Factor? bottom,
  }) {
    return EdgeInsets.only(
      left: start != null ? GoldenRatio.spacing(this, factor: start) : 0,
      top: top != null ? GoldenRatio.spacing(this, factor: top) : 0,
      right: end != null ? GoldenRatio.spacing(this, factor: end) : 0,
      bottom: bottom != null ? GoldenRatio.spacing(this, factor: bottom) : 0,
    );
  }
  
  /// Safe area with golden ratio padding
  EdgeInsets gSafePadding() {
    final base = GoldenRatio.spacing(this, factor: Factor.sm);
    return EdgeInsets.only(
      top: base + MediaQuery.of(this).padding.top,
      bottom: base + MediaQuery.of(this).padding.bottom,
      left: base,
      right: base,
    );
  }
  
  /// Get golden ratio spacing value directly
  double gSpacing(Factor factor) {
    return GoldenRatio.spacing(this, factor: factor);
  }
  
  /// Get golden ratio text size directly
  double gTextSize(TextScale scale) {
    return GoldenRatio.textSize(this, scale);
  }
  
  /// Get golden ratio component size directly
  double gComponentSize(ComponentSize size) {
    return GoldenRatio.componentSize(this, size);
  }
  
  /// Get golden ratio border radius
  BorderRadius gBorderRadius(Factor factor) {
    return BorderRadius.circular(GoldenRatio.radius(factor));
  }
}
