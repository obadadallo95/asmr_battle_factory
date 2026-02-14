import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

// Pages
import '../../../features/home/presentation/home_page.dart';
import '../../../features/configurator/presentation/pages/battle_configurator_page.dart';
import '../../../features/projects/presentation/pages/projects_page.dart';
import '../../../features/marketplace/presentation/pages/api_marketplace_page.dart';
import '../../../features/settings/presentation/settings_page.dart';
import '../../../features/generator/presentation/generator_page.dart'; // Still needed for context

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/navigation_guard_service.dart';

class AppShell extends ConsumerStatefulWidget {
  final Widget child; // Kept for GoRouter compatibility, but we use IndexedStack
  
  const AppShell({super.key, required this.child});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/app/home')) return 0;
    if (location.startsWith('/app/generator')) return 1;
    if (location.startsWith('/app/projects')) return 2;
    if (location.startsWith('/app/marketplace')) return 3;
    if (location.startsWith('/app/settings')) return 4;
    return 0;
  }

  Future<void> _onItemTapped(int index, BuildContext context) async {
    final canExit = await ref.read(navigationGuardProvider.notifier).canPop(context);
    if (!canExit) return;

    switch (index) {
      case 0:
        if (context.mounted) context.go('/app/home');
        break;
      case 1:
        if (context.mounted) context.go('/app/generator');
        break;
      case 2:
        if (context.mounted) context.go('/app/projects');
        break;
      case 3:
        if (context.mounted) context.go('/app/marketplace');
        break;
      case 4:
        if (context.mounted) context.go('/app/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 600;
    final int selectedIndex = _calculateSelectedIndex(context);

    // Main content with State Preservation
    final Widget body = IndexedStack(
      index: selectedIndex,
      children: const [
        HomePage(),
        BattleConfiguratorPage(), 
        ProjectsPage(),
        APIMarketplacePage(),
        SettingsPage(),
      ],
    );

    if (isDesktop) {
       return Scaffold(
         body: Row(
           children: [
             NavigationRail(
               selectedIndex: selectedIndex,
               onDestinationSelected: (int index) => _onItemTapped(index, context),
               backgroundColor: const Color(0xFF1E1E2C),
               labelType: NavigationRailLabelType.all,
               selectedLabelTextStyle: GoogleFonts.cairo(color: Colors.purpleAccent, fontSize: 12.sp),
               unselectedLabelTextStyle: GoogleFonts.cairo(color: Colors.white54, fontSize: 10.sp),
               destinations: _buildDestinations(context).map((d) => NavigationRailDestination(
                 icon: d.icon,
                 selectedIcon: d.activeIcon,
                 label: Text(d.label!),
               )).toList(),
             ),
             const VerticalDivider(thickness: 1, width: 1, color: Colors.white10),
             Expanded(child: body),
           ],
         ),
       );
    }
    
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return GoogleFonts.cairo(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.purpleAccent);
            }
            return GoogleFonts.cairo(fontSize: 10.sp, color: Colors.white54);
          }),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) => _onItemTapped(index, context),
          backgroundColor: const Color(0xFF1E1E2C),
          indicatorColor: Colors.purpleAccent.withValues(alpha: 0.2),
          destinations: _buildDestinations(context).map((d) => NavigationDestination(
            icon: d.icon,
            selectedIcon: d.activeIcon,
            label: d.label!,
          )).toList(),
        ),
      ),
    );
  }

  List<_NavDestination> _buildDestinations(BuildContext context) {
    return [
      _NavDestination(
        icon: const Icon(Icons.dashboard_outlined),
        activeIcon: const Icon(Icons.dashboard, color: Colors.purpleAccent),
        label: context.tr('navigation.home')
      ),
      _NavDestination(
        icon: const Icon(Icons.movie_creation_outlined),
        activeIcon: const Icon(Icons.movie_creation, color: Colors.purpleAccent),
        label: context.tr('navigation.studio')
      ),
      _NavDestination(
        icon: const Icon(Icons.folder_open_outlined),
        activeIcon: const Icon(Icons.folder, color: Colors.purpleAccent),
        label: context.tr('navigation.projects')
      ),
      _NavDestination(
        icon: const Icon(Icons.store_outlined),
        activeIcon: const Icon(Icons.store, color: Colors.purpleAccent),
        label: context.tr('navigation.marketplace')
      ),
      _NavDestination(
        icon: const Icon(Icons.settings_outlined),
        activeIcon: const Icon(Icons.settings, color: Colors.purpleAccent),
        label: context.tr('navigation.settings')
      ),
    ];
  }
}

class _NavDestination {
  final Widget icon;
  final Widget activeIcon;
  final String? label;

  _NavDestination({required this.icon, required this.activeIcon, this.label});
}
