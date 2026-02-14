// Lines: 60/100
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ParticleBackground extends StatelessWidget {
  const ParticleBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dark Gradient Base
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF050505), Color(0xFF1a1025)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // Floating Particles
        ...List.generate(20, (index) {
          final random = Random(index);
          final size = random.nextDouble() * 4 + 2;
          final speed = random.nextDouble() * 20 + 10;
          
          return Positioned(
            left: random.nextDouble() * MediaQuery.of(context).size.width,
            top: random.nextDouble() * MediaQuery.of(context).size.height,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: random.nextDouble() * 0.3),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.2),
                    blurRadius: 4,
                    spreadRadius: 1,
                  )
                ],
              ),
            )
            .animate(onPlay: (controller) => controller.repeat())
            .moveY(
              begin: 0, 
              end: -100, 
              duration: speed.seconds, 
              curve: Curves.linear,
            )
            .fadeOut(duration: speed.seconds),
          );
        }),
      ],
    );
  }
}
