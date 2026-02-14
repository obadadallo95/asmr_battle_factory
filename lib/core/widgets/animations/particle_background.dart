import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ParticleBackground extends StatelessWidget {
  const ParticleBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F0F0F), Color(0xFF1A103C)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ...List.generate(20, (index) => _buildParticle(context, index)),
        ],
      ),
    );
  }

  Widget _buildParticle(BuildContext context, int index) {
    final random = Random(index);
    final size = random.nextDouble() * 4 + 2;
    final left = random.nextDouble() * MediaQuery.of(context).size.width;
    final top = random.nextDouble() * MediaQuery.of(context).size.height;
    final duration = random.nextInt(3000) + 3000;

    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: random.nextDouble() * 0.2 + 0.1),
          shape: BoxShape.circle,
        ),
      )
      .animate(onPlay: (controller) => controller.repeat(reverse: true))
      .moveY(begin: 0, end: -100, duration: duration.ms)
      .fadeIn(duration: 1000.ms)
      .fadeOut(delay: (duration - 1000).ms, duration: 1000.ms),
    );
  }
}
