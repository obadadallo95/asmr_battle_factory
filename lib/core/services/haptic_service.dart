import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class HapticService {
  Future<void> light() async => await HapticFeedback.lightImpact();
  Future<void> medium() async => await HapticFeedback.mediumImpact();
  Future<void> heavy() async => await HapticFeedback.heavyImpact();
  Future<void> selection() async => await HapticFeedback.selectionClick();
  Future<void> error() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }
}
