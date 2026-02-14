// Lines: 90/300
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/animations/animated_glass_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive measurements
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05; // 5% of width
    final verticalSpacing = screenHeight * 0.03; // 3% of height

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0F0F), Color(0xFF1A103C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: verticalSpacing),
                
                // Welcome Text
                Text(
                  context.tr('app_title'),
                  style: TextStyle(
                    fontSize: screenWidth * 0.08, // 8% of width
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                
                SizedBox(height: screenHeight * 0.01),
                
                Text(
                  context.tr('home'),
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // 4% of width
                    color: Colors.white54,
                  ),
                ).animate().fadeIn(delay: 200.ms),
                
                SizedBox(height: verticalSpacing * 1.5),
                
                // Recent Battles Card
                AnimatedGlassCard(
                  width: double.infinity,
                  height: screenHeight * 0.25, // 25% of height
                  onTap: () {
                     // Navigate to history details (future feature)
                  },
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.history_rounded,
                              color: const Color(0xFF6C63FF),
                              size: screenWidth * 0.06,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              context.tr('marketplace_page.recent_battles'),
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: screenWidth * 0.15,
                                  color: Colors.white24,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  context.tr('marketplace_page.no_battles'),
                                  style: TextStyle(
                                    color: Colors.white30,
                                    fontSize: screenWidth * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
                
                // Fixed spacing instead of Spacer inside scroll view
                SizedBox(height: verticalSpacing * 2),
                
                // Generate Button
                PrimaryButton(
                  text: context.tr('generate'),
                  onPressed: () {
                    // Switch to generator tab (index 1)
                    context.go('/app/generator');
                  },
                ).animate().shimmer(delay: 1.seconds, duration: 2.seconds),
                
                SizedBox(height: verticalSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
