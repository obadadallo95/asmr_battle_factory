import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation_guard_service.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  final WidgetRef ref;
  
  AppLifecycleObserver(this.ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App going to background
      final guardLevel = ref.read(navigationGuardProvider);
      if (guardLevel == ProtectionLevel.critical) {
        // Here we could trigger a local notification or log event
        debugPrint("⚠️ App paused during critical operation! Do not kill process.");
        // TODO: Implement Local Notifications to warn user
      }
    }
  }
}
