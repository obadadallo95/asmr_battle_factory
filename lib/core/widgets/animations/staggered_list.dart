import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'app_animations.dart';

class StaggeredList extends StatelessWidget {
  final List<Widget> children;
  final Duration itemDuration;
  final Duration delay;
  final bool isVertical;

  const StaggeredList({
    required this.children,
    this.itemDuration = const Duration(milliseconds: 300),
    this.delay = const Duration(milliseconds: 100),
    this.isVertical = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children
          .map((child) => child)
          .toList()
          .animate(interval: delay)
          .fadeIn(duration: itemDuration, curve: AppAnimations.entranceCurve)
          .slide(
            begin: isVertical ? const Offset(0, 0.2) : const Offset(0.2, 0),
            end: Offset.zero,
            duration: itemDuration,
            curve: AppAnimations.entranceCurve,
          ),
    );
  }
}
