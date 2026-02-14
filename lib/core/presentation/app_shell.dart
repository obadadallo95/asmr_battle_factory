import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/generator/presentation/generator_page.dart';
import '../../features/projects/presentation/pages/projects_hub_page.dart';
import '../../features/settings/presentation/settings_page.dart';

final appShellIndexProvider = StateProvider<int>((ref) => 0);

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(appShellIndexProvider);
    
    // Get screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;

    // Pages for each tab
    final pages = [
      const HomePage(),
      const GeneratorPage(),
      const ProjectsHubPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF1A1A2E).withValues(alpha: 0.95),
              const Color(0xFF16213E).withValues(alpha: 0.98),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: screenHeight * 0.065, // 6.5% of screen height (was 7%, still had 13px overflow)
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                ref.read(appShellIndexProvider.notifier).state = index;
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: const Color(0xFF6C63FF),
              unselectedItemColor: Colors.white54,
              selectedFontSize: MediaQuery.of(context).size.width * 0.032, // 3.2% of width
              unselectedFontSize: MediaQuery.of(context).size.width * 0.028, // 2.8% of width
              iconSize: MediaQuery.of(context).size.width * 0.065, // 6.5% of width
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_rounded),
                  activeIcon: Container(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.home_rounded),
                  ),
                  label: context.tr('home'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.auto_awesome_rounded),
                  activeIcon: Container(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.auto_awesome_rounded),
                  ),
                  label: context.tr('generate'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.folder_rounded),
                  activeIcon: Container(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.folder_rounded),
                  ),
                  label: context.tr('projects'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings_rounded),
                  activeIcon: Container(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.settings_rounded),
                  ),
                  label: context.tr('settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
