import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';
import 'package:asmr_battle_factory/core/utils/responsive_extensions.dart';

/// Golden Ratio Card with glassmorphism and safe sizing
/// Automatically handles min/max constraints to prevent overflow
class GoldenCard extends StatelessWidget {
  final Widget child;
  final Factor padding;
  final Factor borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Gradient? gradient;
  final double? width;
  final double? height;
  final ComponentSize? minHeightSize;
  final ComponentSize? maxHeightSize;
  final VoidCallback? onTap;
  
  const GoldenCard({
    super.key,
    required this.child,
    this.padding = Factor.sm,
    this.borderRadius = Factor.sm,
    this.backgroundColor,
    this.borderColor,
    this.gradient,
    this.width,
    this.height,
    this.minHeightSize,
    this.maxHeightSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardChild = Container(
      width: width ?? double.infinity,
      height: height,
      constraints: BoxConstraints(
        minHeight: minHeightSize != null 
            ? context.gComponentSize(minHeightSize!)
            : context.gComponentSize(ComponentSize.sm),
        maxHeight: maxHeightSize != null
            ? context.gComponentSize(maxHeightSize!)
            : ScreenUtil().screenHeight * 0.4, // Max 40% of screen
      ),
      padding: context.gPadding(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white.withValues(alpha: 0.05),
        gradient: gradient,
        borderRadius: context.gBorderRadius(borderRadius),
        border: borderColor != null
            ? Border.all(color: borderColor!)
            : Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: context.gBorderRadius(borderRadius),
        child: cardChild,
      );
    }

    return cardChild;
  }
}

/// Glassmorphism Card with blur effect
class GlassmorphicGoldenCard extends StatelessWidget {
  final Widget child;
  final Factor padding;
  final Factor borderRadius;
  final Color? tintColor;
  final double opacity;
  final VoidCallback? onTap;
  
  const GlassmorphicGoldenCard({
    super.key,
    required this.child,
    this.padding = Factor.sm,
    this.borderRadius = Factor.sm,
    this.tintColor,
    this.opacity = 0.1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GoldenCard(
      padding: padding,
      borderRadius: borderRadius,
      onTap: onTap,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          (tintColor ?? Colors.white).withValues(alpha: opacity),
          Colors.black.withValues(alpha: 0.4),
        ],
      ),
      borderColor: (tintColor ?? Colors.white).withValues(alpha: 0.3),
      child: child,
    );
  }
}
