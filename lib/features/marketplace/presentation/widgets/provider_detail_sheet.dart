import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';
import 'package:asmr_battle_factory/features/marketplace/presentation/providers/marketplace_provider.dart';
import 'package:asmr_battle_factory/core/utils/responsive_extensions.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';
import 'package:asmr_battle_factory/core/widgets/glass_card.dart';
import 'package:asmr_battle_factory/core/widgets/primary_button.dart';
import 'package:asmr_battle_factory/core/utils/url_launcher_helper.dart';
import 'cost_calculator_widget.dart';
import 'setup_stepper.dart';

class ProviderDetailSheet extends ConsumerWidget {
  final ProviderCatalogEntry provider;

  const ProviderDetailSheet({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasKey = ref.watch(providerKeyExistsProvider(provider.id));

    return Container(
      height: 0.85.sh,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Column(
        children: [
          // Drag handle
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: context.gPadding(Factor.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(context),
                  SizedBox(height: 2.g),
                  
                  // Status Card
                  _buildStatusCard(context, ref, hasKey),
                  SizedBox(height: 2.g),
                  
                  // Quick Links
                  _buildActionButtons(context),
                  SizedBox(height: 2.g),
                  
                  // Cost Calculator
                  CostCalculator(provider: provider),
                  SizedBox(height: 2.g),
                  
                  // Setup Guide (Accordion-like)
                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        context.tr('marketplace.setup_guide'),
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      children: [
                        SetupStepper(provider: provider),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 4.g),
                  
                  // Set as Default Action
                  if (hasKey)
                    PrimaryButton(
                      text: context.tr('marketplace.set_default'),
                      onPressed: () {
                        ref.read(defaultProvidersProvider.notifier).setDefault(
                          provider.function,
                          provider.id,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(context.tr('marketplace.default_set', args: [provider.nameAr])),
                            backgroundColor: provider.brandColorValue,
                          ),
                        );
                      },
                    ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: provider.brandColorValue.withValues(alpha: 0.1),
            borderRadius: context.gBorderRadius(Factor.sm),
            border: Border.all(color: provider.brandColorValue.withValues(alpha: 0.3)),
          ),
          child: Center(
            child: provider.logoAsset != null 
              ? Image.asset(provider.logoAsset!, width: 40.w)
              : Text(
                  provider.name.substring(0, 1),
                  style: GoogleFonts.cairo(
                    fontSize: 32.sp,
                    color: provider.brandColorValue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ),
        SizedBox(width: 1.g),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                provider.nameAr,
                style: GoogleFonts.cairo(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                provider.name,
                style: GoogleFonts.cairo(
                  fontSize: 14.sp,
                  color: Colors.white54,
                ),
              ),
              SizedBox(height: 8.h),
              _buildBadges(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBadges(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        if (provider.tier == ProviderTier.free)
          _Badge(
            label: context.tr('marketplace_page.cost_free'),
            color: Colors.green,
          ),
        if (!provider.availableInSyria)
          _Badge(
            label: context.tr('marketplace_page.vpn_required'),
            color: Colors.orange,
          ),
        _Badge(
          label: '⭐ ${provider.qualityRating}',
          color: Colors.amber,
        ),
      ],
    );
  }

  Widget _buildStatusCard(BuildContext context, WidgetRef ref, bool hasKey) {
    return GlassCard(
      color: hasKey ? Colors.green.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
      borderColor: hasKey ? Colors.green.withValues(alpha: 0.2) : null,
      child: Row(
        children: [
          Icon(
            hasKey ? Icons.check_circle : Icons.radio_button_unchecked,
            color: hasKey ? Colors.green : Colors.white24,
            size: 28.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasKey ? context.tr('marketplace.configured') : context.tr('marketplace.not_configured'),
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: hasKey ? Colors.green : Colors.white,
                  ),
                ),
                if (hasKey)
                  Text(
                    context.tr('marketplace.ready_to_use'),
                    style: GoogleFonts.cairo(fontSize: 12.sp, color: Colors.white54),
                  ),
              ],
            ),
          ),
          if (hasKey)
            TextButton(
              onPressed: () => _testConnection(context, ref),
              child: Text(
                context.tr('marketplace.test'),
                style: const TextStyle(color: Colors.blueAccent),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('marketplace.quick_links'),
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            _ActionChip(
              icon: Icons.language,
              label: context.tr('marketplace.website'),
              onPressed: () => UrlLauncherHelper.launch(
                provider.websiteUrl,
                context: context,
              ),
            ),
            _ActionChip(
              icon: Icons.person_add,
              label: context.tr('marketplace.signup'),
              isProminent: true,
              brandColor: provider.brandColorValue,
              onPressed: () => UrlLauncherHelper.launch(
                provider.signupUrl,
                context: context,
              ),
            ),
            _ActionChip(
              icon: Icons.menu_book,
              label: context.tr('marketplace.docs'),
              onPressed: () => UrlLauncherHelper.launch(
                provider.docsUrl,
                context: context,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _testConnection(BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text(context.tr('marketplace.testing'), style: const TextStyle(color: Colors.white)),
        content: Row(
          children: [
            const CircularProgressIndicator(),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                context.tr('marketplace.testing_desc'),
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
    
    final success = await ref.read(marketplaceRepositoryProvider).testProviderConnection(provider.id);
    
    if (context.mounted) {
       Navigator.pop(context); // Close loading dialog
       
       showDialog(
         context: context,
         builder: (_) => AlertDialog(
           backgroundColor: const Color(0xFF1A1A2E),
           title: Text(
             success ? context.tr('common.success') : context.tr('common.error', args: ['']),
             style: TextStyle(color: success ? Colors.green : Colors.red),
           ),
           content: Text(
             success ? context.tr('marketplace.connection_success') : 'Connection failed',
             style: const TextStyle(color: Colors.white),
           ),
           actions: [
             TextButton(
               onPressed: () => Navigator.pop(context),
               child: Text(context.tr('common.confirm')),
             ),
           ],
         ),
       );
    }
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;

  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10.sp, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isProminent;
  final Color? brandColor;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isProminent = false,
    this.brandColor,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 16.sp, color: isProminent ? Colors.white : Colors.white70),
      label: Text(label),
      labelStyle: GoogleFonts.cairo(
        fontSize: 12.sp,
        color: isProminent ? Colors.white : Colors.white70,
        fontWeight: isProminent ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: isProminent 
        ? (brandColor ?? Colors.blueAccent) 
        : Colors.white.withValues(alpha: 0.05),
      side: BorderSide(
        color: isProminent 
          ? Colors.transparent 
          : Colors.white.withValues(alpha: 0.1),
      ),
      onPressed: onPressed,
    );
  }
}
