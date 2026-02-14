import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/marketplace/presentation/providers/marketplace_provider.dart';
import 'package:asmr_battle_factory/config/di/injection.dart';
import 'package:asmr_battle_factory/core/services/security/biometric_vault.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';

// Provider to fetch configured providers asynchronously
final configuredProvidersProvider = FutureProvider<List<ProviderCatalogEntry>>((ref) async {
  final allProviders = ref.watch(marketplaceProvider).allProviders;
  final vault = getIt<BiometricVault>();
  final configured = <ProviderCatalogEntry>[];
  
  for (final provider in allProviders) {
    if (!provider.requiresKey) {
      // Always configured if no key needed (e.g. Pollinations)
      configured.add(provider); 
    } else {
      final hasKey = await vault.hasApiKey(provider.id);
      if (hasKey) {
        configured.add(provider);
      }
    }
  }
  return configured;
});

class MyApplicationsSection extends ConsumerWidget {
  const MyApplicationsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configuredAsync = ref.watch(configuredProvidersProvider);

    return configuredAsync.when(
      data: (providers) {
        if (providers.isEmpty) return const SizedBox.shrink();
        
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('marketplace_page.my_providers', args: [providers.length.toString()]),
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: providers.map((p) => _buildChip(context, p)).toList(),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildChip(BuildContext context, ProviderCatalogEntry provider) {
    final color = provider.brandColorValue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: provider.requiresKey ? Colors.greenAccent : Colors.blueAccent,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            context.locale.languageCode == 'ar' ? provider.nameAr : provider.name,
            style: GoogleFonts.cairo(
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 4.w),
          const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white30),
        ],
      ),
    );
  }
}
