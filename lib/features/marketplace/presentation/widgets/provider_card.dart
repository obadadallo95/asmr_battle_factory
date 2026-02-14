import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';
import 'package:asmr_battle_factory/core/widgets/animations/animated_glass_card.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';
import 'package:asmr_battle_factory/core/utils/responsive_extensions.dart';
import 'provider_detail_sheet.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:asmr_battle_factory/features/marketplace/presentation/providers/marketplace_provider.dart';

class ProviderCard extends ConsumerWidget {
  final ProviderCatalogEntry provider;

  const ProviderCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandColor = provider.brandColorValue;
    final hasKey = ref.watch(providerKeyExistsProvider(provider.id));
    
    return Container(
      width: 160.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      child: AnimatedGlassCard(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ProviderDetailSheet(provider: provider),
          );
        },
        child: Container(
          padding: context.gPadding(Factor.xs),
          decoration: BoxDecoration(
            border: Border.all(color: brandColor.withValues(alpha: 0.3)),
            borderRadius: context.gBorderRadius(Factor.sm),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                brandColor.withValues(alpha: 0.1),
                Colors.black.withValues(alpha: 0.4),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: hasKey ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                      boxShadow: hasKey ? [
                        BoxShadow(color: Colors.green.withValues(alpha: 0.5), blurRadius: 6),
                      ] : null,
                    ),
                  ),
                  if (provider.availableInSyria)
                    Icon(Icons.check_circle, size: 14.sp, color: Colors.green)
                  else
                    Icon(Icons.vpn_lock, size: 14.sp, color: Colors.orangeAccent),
                ],
              ),
              SizedBox(height: 10.h),
              
              // Name
              Text(
                provider.id.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 1.t,
                  fontWeight: FontWeight.w900,
                  color: Colors.white24,
                ),
              ),
              if (provider.nameAr != provider.name)
                Text(
                  context.locale.languageCode == 'ar' ? provider.nameAr : provider.name,
                  style: GoogleFonts.cairo(
                    fontSize: 2.t,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              
              SizedBox(height: 8.h),
              
              _buildFeatureTag(provider.tierLabel, provider.tierIcon, 
                provider.tier == ProviderTier.free ? Colors.greenAccent : Colors.amberAccent
              ),
              SizedBox(height: 4.h),
              
              if (provider.speedRating >= 4.5)
                _buildFeatureTag('فائق السرعة', Icons.flash_on, Colors.blueAccent)
              else if (provider.qualityRating >= 4.5)
                _buildFeatureTag('جودة عالية', Icons.star, Colors.purpleAccent),
                
              const Spacer(),
              
              // Price
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: context.gBorderRadius(Factor.xs),
                ),
                child: Center(
                  child: Text(
                    provider.tier == ProviderTier.free ? 'مجاني 100%' : (provider.paidPricing ?? 'مدفوع'),
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 0.t,
                      color: Colors.white70,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              
              SizedBox(height: 6.h),
              
              // Setup Button
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 6.h),
                decoration: BoxDecoration(
                  color: brandColor.withValues(alpha: 0.2),
                  borderRadius: context.gBorderRadius(Factor.xs),
                  border: Border.all(color: brandColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, size: 1.t, color: brandColor),
                    SizedBox(width: 4.w),
                    Text(
                      context.tr('marketplace_page.setup_btn'),
                      style: GoogleFonts.cairo(
                        fontSize: 0.t,
                        color: brandColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureTag(String text, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, size: 0.t, color: color),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.cairo(
              fontSize: 0.t,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
