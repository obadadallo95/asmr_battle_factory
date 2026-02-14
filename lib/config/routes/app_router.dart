// Lines: 65/300
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:animations/animations.dart';
import '../../core/navigation/widgets/app_shell.dart';
import '../../features/splash/presentation/splash_page.dart';
import '../../features/settings/presentation/pages/about_developer_page.dart';
import '../../features/settings/presentation/pages/legal/about_page.dart';
import '../../features/settings/presentation/pages/legal/privacy_policy_page.dart';
import '../../features/settings/presentation/pages/legal/terms_of_service_page.dart';
import '../../features/settings/presentation/pages/legal/ip_rights_page.dart';
import '../../features/settings/presentation/pages/ai_conductor_page.dart';
import '../../features/settings/presentation/pages/api_keys_page.dart';
import '../../features/preview/presentation/preview_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/marketplace/presentation/pages/api_marketplace_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) => _buildSharedAxisTransition(
          context, 
          state, 
          const OnboardingPage(),
          SharedAxisTransitionType.horizontal,
        ),
      ),
      
      // Main app shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/app/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SizedBox.shrink(), // Handled by IndexedStack in AppShell
            ),
          ),
          GoRoute(
            path: '/app/generator',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SizedBox.shrink(), // Handled by IndexedStack in AppShell
            ),
          ),
          GoRoute(
            path: '/app/projects',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SizedBox.shrink(), // Handled by IndexedStack in AppShell
            ),
          ),
          GoRoute(
            path: '/app/marketplace',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SizedBox.shrink(), // Handled by IndexedStack in AppShell
            ),
          ),
          GoRoute(
            path: '/app/settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SizedBox.shrink(), // Handled by IndexedStack in AppShell
            ),
          ),
        ],
      ),
      
      // Settings sub-routes (full screen)
      GoRoute(
        path: '/settings/about',
        pageBuilder: (context, state) => _buildFadeThroughTransition(context, state, const AboutPage()),
        routes: [
          GoRoute(
            path: 'developer',
            pageBuilder: (context, state) => _buildSharedAxisTransition(
              context, 
              state, 
              const AboutDeveloperPage(),
              SharedAxisTransitionType.horizontal,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/settings/privacy',
        pageBuilder: (context, state) => _buildFadeThroughTransition(context, state, const PrivacyPolicyPage()),
      ),
      GoRoute(
        path: '/settings/terms',
        pageBuilder: (context, state) => _buildFadeThroughTransition(context, state, const TermsOfServicePage()),
      ),
      GoRoute(
        path: '/settings/ip',
        pageBuilder: (context, state) => _buildFadeThroughTransition(context, state, const IntellectualPropertyPage()),
      ),
      GoRoute(
        path: '/settings/conductor',
        pageBuilder: (context, state) => _buildSharedAxisTransition(context, state, const AIConductorPage(), SharedAxisTransitionType.scaled),
      ),
      GoRoute(
        path: '/settings/api-keys',
        pageBuilder: (context, state) => _buildSharedAxisTransition(context, state, const APIKeysPage(), SharedAxisTransitionType.scaled),
      ),
      GoRoute(
        path: '/marketplace',
        pageBuilder: (context, state) => _buildSharedAxisTransition(
          context, 
          state, 
          const APIMarketplacePage(),
          SharedAxisTransitionType.horizontal,
        ),
      ),
      GoRoute(
        path: '/preview',
        pageBuilder: (context, state) => _buildSharedAxisTransition(
          context, 
          state, 
          const PreviewPage(),
          SharedAxisTransitionType.scaled,
        ),
      ),
    ],
  );
});

CustomTransitionPage _buildSharedAxisTransition(
  BuildContext context, 
  GoRouterState state, 
  Widget child,
  SharedAxisTransitionType type,
) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: type,
        fillColor: Colors.transparent, // Fix for transparency issue
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}

CustomTransitionPage _buildFadeThroughTransition(
  BuildContext context, 
  GoRouterState state, 
  Widget child,
) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        fillColor: Colors.transparent,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}
