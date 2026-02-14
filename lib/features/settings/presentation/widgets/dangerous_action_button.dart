import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/golden_ratio.dart';
import '../../../../core/utils/responsive_extensions.dart';

class DangerousActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String sublabel;
  final Color color;
  final Duration holdDuration;
  final VoidCallback onHoldComplete;

  const DangerousActionButton({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.color,
    this.holdDuration = const Duration(seconds: 2),
    required this.onHoldComplete,
    super.key,
  });

  @override
  State<DangerousActionButton> createState() => _DangerousActionButtonState();
}

class _DangerousActionButtonState extends State<DangerousActionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHolding = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.holdDuration,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onHoldComplete();
        _cancelHold();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startHold() {
    setState(() => _isHolding = true);
    _controller.forward();
  }

  void _cancelHold() {
    if (_controller.isAnimating || _controller.isCompleted) {
      _controller.reverse();
    }
    setState(() => _isHolding = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _startHold(),
      onTapUp: (_) => _cancelHold(),
      onTapCancel: () => _cancelHold(),
      child: ClipRRect(
        borderRadius: context.gBorderRadius(Factor.sm),
        child: Stack(
          children: [
            // Background
            Container(
              padding: context.gPadding(Factor.sm),
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.1),
                border: Border.all(color: widget.color.withValues(alpha: 0.2)),
                borderRadius: context.gBorderRadius(Factor.sm),
              ),
              child: Row(
                children: [
                  Icon(widget.icon, color: widget.color, size: 3.t),
                  SizedBox(width: 1.g),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label,
                          style: TextStyle(
                            fontSize: 2.t,
                            color: widget.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.sublabel,
                          style: TextStyle(
                            fontSize: 1.t,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _isHolding
                      ? SizedBox(
                          width: 2.t,
                          height: 2.t,
                          child: CircularProgressIndicator(
                            value: _controller.value,
                            color: widget.color,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'hold_to_confirm'.tr(),
                          style: TextStyle(
                            fontSize: 1.t,
                            color: widget.color.withValues(alpha: 0.7),
                          ),
                        ),
                ],
              ),
            ),
            
            // Progress overlay
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return FractionallySizedBox(
                      alignment: context.locale.languageCode == 'ar' 
                          ? Alignment.centerRight 
                          : Alignment.centerLeft,
                      widthFactor: _controller.value,
                      child: Container(
                        color: widget.color.withValues(alpha: 0.2),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
