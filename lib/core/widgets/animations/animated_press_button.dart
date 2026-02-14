// Lines: 65/200
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../config/di/injection.dart';
import '../../services/haptic_service.dart';

class AnimatedPressButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  const AnimatedPressButton({
    required this.child,
    this.onPressed,
    this.onLongPress,
    super.key,
  });

  @override
  State<AnimatedPressButton> createState() => _AnimatedPressButtonState();
}

class _AnimatedPressButtonState extends State<AnimatedPressButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = true);
    getIt<HapticService>().light();
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      onLongPress: () {
        widget.onLongPress?.call();
        getIt<HapticService>().medium();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: 100.ms,
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}
