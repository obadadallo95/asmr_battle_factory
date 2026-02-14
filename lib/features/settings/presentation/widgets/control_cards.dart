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
      onTap: () => context.push('/settings/conductor'),
      padding: context.gPadding(Factor.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Icon(Icons.psychology, size: 2.5.t, color: Colors.purpleAccent)),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: connectedCount > 0 ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '$connectedCount/5',
                    style: TextStyle(fontSize: 0.8.t, color: Colors.white, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Expanded(
            flex: 0,
            child: Text(
              'settings.ai.title'.tr(),
              style: GoogleFonts.cairo(fontSize: 1.t, fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 0,
            child: Text(
              'settings.ai.subtitle'.tr(args: ['$connectedCount']),
              style: TextStyle(fontSize: 0.9.t, color: Colors.white54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
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
      padding: context.gPadding(Factor.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  size: 2.5.t,
                  color: isDark ? Colors.indigoAccent : Colors.orangeAccent,
                ),
              ),
              Flexible(
                child: Transform.scale(
                  scale: 0.7, // Slighting smaller for ultra-narrow screens
                  child: Switch.adaptive(
                    value: isDark,
                    activeThumbColor: Colors.purpleAccent,
                    onChanged: (value) {
                      ref.read(settingsProvider.notifier).setThemeMode(
                        value ? ThemeMode.dark : ThemeMode.light,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Expanded(
            flex: 0,
            child: Text(
              'settings.display.title'.tr(),
              style: GoogleFonts.cairo(fontSize: 1.t, fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 0,
            child: Text(
              isDark ? 'settings.display.dark'.tr() : 'settings.display.light'.tr(),
              style: TextStyle(fontSize: 0.9.t, color: Colors.white54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
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
      padding: context.gPadding(Factor.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isLocked ? Icons.lock : Icons.lock_open,
            size: 2.5.t,
            color: isLocked ? Colors.greenAccent : Colors.orangeAccent,
          ),
          const Spacer(),
          Expanded(
            flex: 0,
            child: Text(
              'settings.security.title'.tr(),
              style: GoogleFonts.cairo(fontSize: 1.t, fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 0,
            child: Text(
              isLocked ? 'settings.security.locked'.tr() : 'settings.security.unlocked'.tr(),
              style: TextStyle(fontSize: 0.9.t, color: Colors.white54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
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
      },
      padding: context.gPadding(Factor.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? '🇸🇦' : '🇬🇧',
            style: TextStyle(fontSize: 2.5.t),
          ),
          const Spacer(),
          Expanded(
            flex: 0,
            child: Text(
              'settings.language.title'.tr(),
              style: GoogleFonts.cairo(fontSize: 1.t, fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 0,
            child: Text(
              isArabic ? 'العربية' : 'English',
              style: TextStyle(fontSize: 0.9.t, color: Colors.white54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
