// Lines: 60/100
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/di/injection.dart';
import '../../../../core/services/settings_service.dart';

class OnboardingState {
  final int currentPage;
  final bool isLastPage;

  OnboardingState({required this.currentPage, required this.isLastPage});
}

class OnboardingController extends StateNotifier<OnboardingState> {
  final SettingsService _settingsService;

  OnboardingController(this._settingsService) 
      : super(OnboardingState(currentPage: 0, isLastPage: false));

  void onPageChanged(int index) {
    state = OnboardingState(
      currentPage: index,
      isLastPage: index == 3, // 4 pages total (0, 1, 2, 3)
    );
  }

  Future<void> completeOnboarding({String? apiKey}) async {
    await _settingsService.setHasSeenOnboarding(true);
    if (apiKey != null && apiKey.isNotEmpty) {
      await _settingsService.saveApiKey('gemini', apiKey);
    }
  }
}

final onboardingControllerProvider = 
    StateNotifierProvider<OnboardingController, OnboardingState>((ref) {
  return OnboardingController(getIt<SettingsService>());
});
