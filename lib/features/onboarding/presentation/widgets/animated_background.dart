// Lines: 70/100
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dark Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A0A0F), Color(0xFF1A1025)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        
        // Floating Particles
        ...List.generate(30, (index) {
          final random = Random(index);
          final size = random.nextDouble() * 3 + 1;
          final duration = random.nextInt(5) + 5;
          
          return Positioned(
            left: random.nextDouble() * MediaQuery.of(context).size.width,
            top: random.nextDouble() * MediaQuery.of(context).size.height,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: random.nextDouble() * 0.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.1),
                    blurRadius: 3,
                  )
                ],
              ),
            )
            .animate(onPlay: (c) => c.repeat())
            .moveY(
              begin: 0, 
              end: -50, 
              duration: duration.seconds, 
              curve: Curves.easeInOut,
            )
            .fadeIn(duration: 1.seconds)
            .then()
            .fadeOut(duration: 1.seconds, delay: (duration - 2).seconds),
          );
        }),
      ],
    );
  }
}
