// Lines: 220/250
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/onboarding_controller.dart';
import '../widgets/animated_background.dart';
import '../widgets/onboarding_step.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/glass_card.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  final TextEditingController _apiKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final notifier = ref.read(onboardingControllerProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const AnimatedBackground(),
          
          PageView(
            controller: _pageController,
            onPageChanged: notifier.onPageChanged,
            children: [
              OnboardingStep(
                imagePath: 'assets/images/onboarding/step1_arena.png',
                title: context.tr('onboarding_step1_title'),
                description: context.tr('onboarding_step1_desc'),
              ),
              OnboardingStep(
                imagePath: 'assets/images/onboarding/step2_four_forces.png',
                title: context.tr('onboarding_step2_title'),
                description: context.tr('onboarding_step2_desc'),
              ),
              OnboardingStep(
                imagePath: 'assets/images/onboarding/step3_timeline.png',
                title: context.tr('onboarding_step3_title'),
                description: context.tr('onboarding_step3_desc'),
              ),
              // Final Step with API Key Input
              OnboardingStep(
                imagePath: 'assets/images/onboarding/step4_director.png',
                title: context.tr('onboarding_step4_title'),
                description: context.tr('onboarding_step4_desc'),
                trailing: Column(
                  children: [
                    GlassCard(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                      child: TextField(
                        controller: _apiKeyController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: context.tr('onboarding_apiKey_hint'),
                          hintStyle: const TextStyle(color: Colors.white30),
                          prefixIcon: const Icon(Icons.key, color: Colors.purpleAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                      PrimaryButton(
                        text: context.tr('onboarding_start'),
                        onPressed: () {
                          notifier.completeOnboarding(apiKey: _apiKeyController.text);
                          context.go('/app/home');
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          notifier.completeOnboarding();
                          context.go('/app/home');
                        },
                      child: Text(
                        context.tr('onboarding_skip'),
                        style: GoogleFonts.cairo(color: Colors.white54),
                      ),
                    ),
                  ],
                ).animate().fadeIn().slideY(begin: 0.2),
              ),
            ],
          ),

          // Indicators & Skip (only for first 3 pages)
          if (!state.isLastPage)
            Positioned(
              bottom: 40.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isActive = index == state.currentPage;
                  return AnimatedContainer(
                    duration: 300.ms,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: isActive ? 24.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFF8B5CF6) : Colors.white24,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  );
                }),
              ),
            ),
            
          if (!state.isLastPage)
            Positioned(
              top: 50.h,
              right: 20.w,
              child: TextButton(
                onPressed: () => _pageController.jumpToPage(3),
                child: Text(
                  context.tr('onboarding_skip'), 
                  style: GoogleFonts.cairo(color: Colors.white54),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
