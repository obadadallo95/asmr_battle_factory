import 'package:flutter/material.dart';

class AppConfig {
  static const int maxScenes = 4;
  static const Size videoDimensions = Size(1080, 1920); // Portrait 9:16
  static const Duration defaultSceneDuration = Duration(seconds: 5);
  
  static const List<Locale> supportedLocales = [
    Locale('ar'),
    Locale('en'),
  ];
  
  static const String appTitle = 'ASMR Battle Factory';
}
