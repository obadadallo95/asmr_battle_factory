import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/glass_card.dart';
import '../providers/settings_provider.dart';

class AIControlCard extends ConsumerWidget {
  const AIControlCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectedCount = ref.watch(connectedProvidersCountProvider).value ?? 0;

    return _ControlCardFrame(
      onTap: () => context.go('/settings/api-keys'),
      builder: (compact) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.psychology, size: compact ? 18 : 22, color: Colors.purpleAccent),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: connectedCount > 0 ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '$connectedCount/5',
                    style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'settings.ai.title'.tr(),
              style: GoogleFonts.cairo(fontSize: compact ? 12 : 13, fontWeight: FontWeight.w800, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (!compact) ...[
              const SizedBox(height: 2),
              Text(
                'settings.ai.subtitle'.tr(args: ['$connectedCount']),
                style: const TextStyle(fontSize: 11, color: Colors.white60),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        );
      },
    );
  }
}

class DisplayControlCard extends ConsumerWidget {
  const DisplayControlCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingsProvider.select((s) => s.themeMode));
    final isDark = themeMode == ThemeMode.dark;

    return _ControlCardFrame(
      builder: (compact) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  size: compact ? 18 : 22,
                  color: isDark ? Colors.indigoAccent : Colors.orangeAccent,
                ),
                Transform.scale(
                  scale: compact ? 0.55 : 0.65,
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
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'settings.display.title'.tr(),
              style: GoogleFonts.cairo(fontSize: compact ? 12 : 13, fontWeight: FontWeight.w800, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (!compact) ...[
              const SizedBox(height: 2),
              Text(
                isDark ? 'settings.display.dark'.tr() : 'settings.display.light'.tr(),
                style: const TextStyle(fontSize: 11, color: Colors.white60),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        );
      },
    );
  }
}

class SecurityControlCard extends ConsumerWidget {
  const SecurityControlCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLocked = ref.watch(settingsProvider.select((s) => s.biometricLockEnabled));

    return _ControlCardFrame(
      onTap: () => ref.read(settingsProvider.notifier).toggleBiometricLock(),
      builder: (compact) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isLocked ? Icons.lock : Icons.lock_open,
              size: compact ? 18 : 22,
              color: isLocked ? Colors.greenAccent : Colors.orangeAccent,
            ),
            const SizedBox(height: 6),
            Text(
              'settings.security.title'.tr(),
              style: GoogleFonts.cairo(fontSize: compact ? 12 : 13, fontWeight: FontWeight.w800, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (!compact) ...[
              const SizedBox(height: 2),
              Text(
                isLocked ? 'settings.security.locked'.tr() : 'settings.security.unlocked'.tr(),
                style: const TextStyle(fontSize: 11, color: Colors.white60),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        );
      },
    );
  }
}

class LanguageControlCard extends ConsumerWidget {
  const LanguageControlCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = context.locale.languageCode == 'ar';

    return _ControlCardFrame(
      onTap: () {
        final newLocale = isArabic ? const Locale('en') : const Locale('ar');
        context.setLocale(newLocale);
      },
      builder: (compact) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isArabic ? '🇸🇦' : '🇬🇧',
              style: TextStyle(fontSize: compact ? 18 : 22),
            ),
            const SizedBox(height: 6),
            Text(
              'settings.language.title'.tr(),
              style: GoogleFonts.cairo(fontSize: compact ? 12 : 13, fontWeight: FontWeight.w800, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (!compact) ...[
              const SizedBox(height: 2),
              Text(
                isArabic ? 'settings.language.arabic'.tr() : 'settings.language.english'.tr(),
                style: const TextStyle(fontSize: 11, color: Colors.white60),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _ControlCardFrame extends StatelessWidget {
  final Widget Function(bool compact) builder;
  final VoidCallback? onTap;

  const _ControlCardFrame({
    required this.builder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxHeight < 96 || constraints.maxWidth < 150;
          return builder(compact);
        },
      ),
    );
  }
}
