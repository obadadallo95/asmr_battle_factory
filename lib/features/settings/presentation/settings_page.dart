import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/golden_ratio.dart';
import '../../../../core/utils/responsive_extensions.dart';
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'settings.control_hub'.tr(),
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 3.t),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => const SettingsSearchDialog(),
            ),
          ),
          SizedBox(width: 1.g),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: context.gPadding(Factor.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // System Connectivity Status
                const SystemStatusHeader(),
                SizedBox(height: 2.g),
                
                // Main Control Hub Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: ScreenUtil().screenWidth > 900 ? 4 : 2,
                  mainAxisSpacing: 1.g,
                  crossAxisSpacing: 1.g,
                  childAspectRatio: 1.1, // Relaxed ratio for more height
                  children: const [
                    AIControlCard(),
                    DisplayControlCard(),
                    SecurityControlCard(),
                    LanguageControlCard(),
                  ],
                ),
                SizedBox(height: 2.g),
                
                // Danger Zone Section
                Text(
                  'settings.danger_zone.title'.tr(),
                  style: GoogleFonts.cairo(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 2.t,
                  ),
                ),
                SizedBox(height: 1.g),
                GlassCard(
                  padding: context.gPadding(Factor.sm),
                  borderColor: Colors.redAccent.withValues(alpha: 0.2),
                  child: Column(
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
                      SizedBox(height: 1.g),
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
                SizedBox(height: 2.g),
                
                // Info Section
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
                
                SizedBox(height: 4.g),
                Center(
                  child: Text(
                    '${'settings_page.version'.tr()} 1.0.0',
                    style: TextStyle(color: Colors.white24, fontSize: 1.t),
                  ),
                ),
                SizedBox(height: 2.g),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, String title, IconData icon, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.purpleAccent, size: 2.t),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white24),
      onTap: () => context.push(route),
    );
  }
}

