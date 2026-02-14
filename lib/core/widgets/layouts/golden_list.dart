import 'package:flutter/material.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';
import 'package:asmr_battle_factory/core/utils/responsive_extensions.dart';

/// Overflow-safe ListView wrapper with automatic spacing
/// Handles unbounded height by using LayoutBuilder and proper constraints
class GoldenList extends StatelessWidget {
  final List<Widget> children;
  final Factor spacing;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  
  const GoldenList({
    super.key,
    required this.children,
    this.spacing = Factor.xs,
    this.padding,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: physics ?? const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children.map((child) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: context.gSpacing(spacing),
                    ),
                    child: child,
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Overflow-safe Column wrapper with automatic spacing
/// Use when you don't need scrolling but want consistent spacing
class GoldenColumn extends StatelessWidget {
  final List<Widget> children;
  final Factor spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  
  const GoldenColumn({
    super.key,
    required this.children,
    this.spacing = Factor.xs,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children.map((child) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: context.gSpacing(spacing),
          ),
          child: child,
        );
      }).toList(),
    );
  }
}
