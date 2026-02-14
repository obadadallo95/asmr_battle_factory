import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/glass_card.dart';
import 'widgets/system_status_header.dart';
import 'widgets/control_cards.dart';
import 'widgets/dangerous_action_button.dart';
import 'widgets/settings_search_dialog.dart';
import 'providers/settings_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width < 420 ? 14.0 : 20.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'settings.control_hub'.tr(),
          style: GoogleFonts.cairo(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => const SettingsSearchDialog(),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B1020), Color(0xFF1A1F38), Color(0xFF0F172A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          color: Color(0xFF0B1020),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildHeroPanel(context),
                        const SizedBox(height: 14),
                        const SystemStatusHeader(),
                        const SizedBox(height: 18),
                        _buildSectionTitle(context, 'settings.sections.control'.tr()),
                        const SizedBox(height: 10),
                        _buildControlGrid(context),
                        const SizedBox(height: 18),
                        _buildSectionTitle(context, 'settings.sections.legal'.tr()),
                        const SizedBox(height: 10),
                        GlassCard(
                          width: double.infinity,
                          child: Column(
                            children: [
                              _buildInfoTile(context, 'settings_page.about_app'.tr(), Icons.info_outline, '/settings/about'),
                              const Divider(color: Colors.white10, height: 1),
                              _buildInfoTile(context, 'settings_page.privacy_policy'.tr(), Icons.privacy_tip_outlined, '/settings/privacy'),
                              const Divider(color: Colors.white10, height: 1),
                              _buildInfoTile(context, 'settings_page.terms_of_service'.tr(), Icons.gavel_outlined, '/settings/terms'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        _buildDangerZone(context, ref),
                        const SizedBox(height: 18),
                        Center(
                          child: Text(
                            '${'settings_page.version'.tr()} 1.0.0',
                            style: const TextStyle(color: Colors.white38, fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroPanel(BuildContext context) {
    return GlassCard(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'settings.control_hub'.tr(),
            style: GoogleFonts.cairo(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'settings.hero_subtitle'.tr(),
            style: GoogleFonts.cairo(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              FilledButton.icon(
                onPressed: () => context.go('/settings/api-keys'),
                icon: const Icon(Icons.psychology),
                label: Text('settings_page.ai_brains'.tr()),
              ),
              OutlinedButton.icon(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const SettingsSearchDialog(),
                ),
                icon: const Icon(Icons.search),
                label: Text('settings.search.hint'.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 17,
      ),
    );
  }

  Widget _buildControlGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 380;
        final maxExtent = isSmall ? constraints.maxWidth : 250.0;
        final mainExtent = isSmall ? 120.0 : 130.0;

        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxExtent,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: mainExtent,
          ),
          children: const [
            AIControlCard(),
            DisplayControlCard(),
            SecurityControlCard(),
            LanguageControlCard(),
          ],
        );
      },
    );
  }

  Widget _buildDangerZone(BuildContext context, WidgetRef ref) {
    return GlassCard(
      width: double.infinity,
      borderColor: Colors.redAccent.withValues(alpha: 0.25),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 8),
          childrenPadding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
          leading: const Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
          collapsedIconColor: Colors.white54,
          iconColor: Colors.white,
          title: Text(
            'settings.danger_zone.title'.tr(),
            style: GoogleFonts.cairo(
              color: Colors.redAccent,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            'settings.danger_zone.subtitle'.tr(),
            style: GoogleFonts.cairo(color: Colors.white54, fontSize: 12),
          ),
          children: [
            DangerousActionButton(
              icon: Icons.delete_sweep,
              label: 'settings.clear_cache'.tr(),
              sublabel: 'settings.clear_cache_desc'.tr(),
              color: Colors.orangeAccent,
              onHoldComplete: () async {
                await ref.read(settingsProvider.notifier).clearCache();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('common.cache_cleared'.tr())),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            DangerousActionButton(
              icon: Icons.restore,
              label: 'settings.reset_all'.tr(),
              sublabel: 'settings.reset_all_desc'.tr(),
              color: Colors.redAccent,
              holdDuration: const Duration(seconds: 3),
              onHoldComplete: () async {
                await ref.read(settingsProvider.notifier).resetToDefaults();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('common.reset_complete'.tr())),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, String title, IconData icon, String route) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      leading: Icon(icon, color: Colors.purpleAccent, size: 22),
      title: Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white24),
      onTap: () => context.go(route),
    );
  }
}
