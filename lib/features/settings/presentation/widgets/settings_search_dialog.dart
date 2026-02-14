import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/golden_ratio.dart';
import '../../../../core/utils/responsive_extensions.dart';

class SettingsSearchDialog extends ConsumerWidget {
  const SettingsSearchDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is a simplified search that lists common setting routes
    final List<_SettingItem> items = [
      _SettingItem(
        title: 'settings_page.ai_brains'.tr(),
        icon: Icons.psychology,
        route: '/settings/conductor',
      ),
      _SettingItem(
        title: 'settings_page.about_app'.tr(),
        icon: Icons.info_outline,
        route: '/settings/about',
      ),
      _SettingItem(
        title: 'settings_page.privacy_policy'.tr(),
        icon: Icons.privacy_tip_outlined,
        route: '/settings/privacy',
      ),
      _SettingItem(
        title: 'settings_page.terms_of_service'.tr(),
        icon: Icons.gavel_outlined,
        route: '/settings/terms',
      ),
      _SettingItem(
        title: 'settings_page.language'.tr(),
        icon: Icons.language,
        route: '', // Anchor scrolling or just highlights
      ),
    ];

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: context.gPadding(Factor.md),
      child: Container(
        width: double.infinity,
        height: ScreenUtil().screenHeight * 0.6,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2C).withValues(alpha: 0.9),
          borderRadius: context.gBorderRadius(Factor.md),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Padding(
              padding: context.gPadding(Factor.sm),
              child: TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'settings.search.hint'.tr(),
                  hintStyle: const TextStyle(color: Colors.white30),
                  prefixIcon: const Icon(Icons.search, color: Colors.purpleAccent),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(
                    borderRadius: context.gBorderRadius(Factor.sm),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (query) {
                  // In a more complex app, this would filter a provider
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: context.gPadding(Factor.sm),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    leading: Icon(item.icon, color: Colors.purpleAccent),
                    title: Text(item.title, style: const TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white30),
                    onTap: () {
                      Navigator.pop(context);
                      if (item.route.isNotEmpty) {
                        context.go(item.route);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingItem {
  final String title;
  final IconData icon;
  final String route;

  _SettingItem({required this.title, required this.icon, required this.route});
}
