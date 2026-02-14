// Lines: 45/300
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../config/di/injection.dart';
import '../../../../core/services/settings_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final hasSeenOnboarding = getIt<SettingsService>().hasSeenOnboarding;
        if (hasSeenOnboarding) {
          context.go('/app/home');
        } else {
          context.go('/onboarding');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bolt, // Placeholder for Logo
              size: 80.sp,
              color: Theme.of(context).primaryColor,
            )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1200.ms, color: Colors.white)
            .scaleXY(end: 1.1, duration: 600.ms)
            .then()
            .scaleXY(end: 1.0, duration: 600.ms),
            
            SizedBox(height: 20.h),
            
            Text(
              context.tr('app_title').toUpperCase(),
              style: Theme.of(context).textTheme.displayLarge,
            ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }
}
