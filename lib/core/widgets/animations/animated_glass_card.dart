// Lines: 65/200
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../glass_card.dart';

class AnimatedGlassCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const AnimatedGlassCard({
    required this.child,
    this.width,
    this.height,
    this.onTap,
    super.key,
  });

  @override
  State<AnimatedGlassCard> createState() => _AnimatedGlassCardState();
}

class _AnimatedGlassCardState extends State<AnimatedGlassCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: 200.ms,
        child: GlassCard(
          width: widget.width,
          height: widget.height,
          child: widget.child,
        )
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .moveY(begin: 0, end: -5, duration: 3.seconds, curve: Curves.easeInOut),
      ),
    );
  }
}
