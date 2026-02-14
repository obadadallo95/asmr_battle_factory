import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/golden_ratio.dart';
import '../../../../core/utils/responsive_extensions.dart';
import '../../../../core/widgets/glass_card.dart';
import '../providers/settings_provider.dart';

class AIControlCard extends ConsumerWidget {
  const AIControlCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectedCount = ref.watch(connectedProvidersCountProvider);
    
    return GlassCard(
      onTap: () => context.go('/settings/conductor'),
      padding: context.gPadding(Factor.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.psychology, size: 3.t, color: Colors.purpleAccent),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0.g, vertical: 2),
                decoration: BoxDecoration(
                  color: connectedCount > 0 ? Colors.green : Colors.orange,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '$connectedCount/5',
                    style: TextStyle(fontSize: 1.t, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'settings.ai.title'.tr(),
            style: GoogleFonts.cairo(fontSize: 1.t, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'settings.ai.subtitle'.tr(args: ['$connectedCount']),
            style: TextStyle(fontSize: 1.t, color: Colors.white54),
          ),
        ],
      ),
    );
  }
}

class DisplayControlCard extends ConsumerWidget {
  const DisplayControlCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingsProvider.select((s) => s.themeMode));
    final isDark = themeMode == ThemeMode.dark;
    
    return GlassCard(
      padding: context.gPadding(Factor.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                size: 3.t,
                color: isDark ? Colors.indigoAccent : Colors.orangeAccent,
              ),
              Switch.adaptive(
                value: isDark,
                activeColor: Colors.purpleAccent,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).setThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
              ),
            ],
          ),
          const Spacer(),
          Text(
            'settings.display.title'.tr(),
            style: GoogleFonts.cairo(fontSize: 1.t, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            isDark ? 'settings.display.dark'.tr() : 'settings.display.light'.tr(),
            style: TextStyle(fontSize: 1.t, color: Colors.white54),
          ),
        ],
      ),
    );
  }
}

class SecurityControlCard extends ConsumerWidget {
  const SecurityControlCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLocked = ref.watch(settingsProvider.select((s) => s.biometricLockEnabled));
    
    return GlassCard(
      onTap: () => ref.read(settingsProvider.notifier).toggleBiometricLock(),
      padding: context.gPadding(Factor.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isLocked ? Icons.lock : Icons.lock_open,
            size: 3.t,
            color: isLocked ? Colors.greenAccent : Colors.orangeAccent,
          ),
          const Spacer(),
          Text(
            'settings.security.title'.tr(),
            style: GoogleFonts.cairo(fontSize: 1.t, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            isLocked ? 'settings.security.locked'.tr() : 'settings.security.unlocked'.tr(),
            style: TextStyle(fontSize: 1.t, color: Colors.white54),
          ),
        ],
      ),
    );
  }
}

class LanguageControlCard extends ConsumerWidget {
  const LanguageControlCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = context.locale.languageCode == 'ar';
    
    return GlassCard(
      onTap: () {
        final newLocale = isArabic ? const Locale('en') : const Locale('ar');
        context.setLocale(newLocale);
        // Also update service via notifier if needed
      },
      padding: context.gPadding(Factor.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? '🇸🇦' : '🇬🇧',
            style: TextStyle(fontSize: 3.t),
          ),
          const Spacer(),
          Text(
            'settings.language.title'.tr(),
            style: GoogleFonts.cairo(fontSize: 1.t, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            isArabic ? 'العربية' : 'English',
            style: TextStyle(fontSize: 1.t, color: Colors.white54),
          ),
        ],
      ),
    );
  }
}
