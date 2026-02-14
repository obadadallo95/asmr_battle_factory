import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';
import 'package:asmr_battle_factory/core/widgets/animations/animated_glass_card.dart';
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
    final displayName = context.locale.languageCode == 'ar' ? provider.nameAr : provider.name;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: AnimatedGlassCard(
        padding: EdgeInsets.zero,
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ProviderDetailSheet(provider: provider),
          );
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final veryShort = constraints.maxHeight < 126;
            final compact = constraints.maxWidth < 210 || constraints.maxHeight < 178;

            return Container(
              padding: EdgeInsets.all(veryShort ? 8 : (compact ? 10 : 12)),
              decoration: BoxDecoration(
                border: Border.all(color: brandColor.withValues(alpha: 0.28)),
                borderRadius: BorderRadius.circular(14.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    brandColor.withValues(alpha: 0.12),
                    const Color(0xFF121728).withValues(alpha: 0.95),
                  ],
                ),
              ),
              child: veryShort
                  ? _buildUltraCompactContent(
                      context: context,
                      brandColor: brandColor,
                      hasKey: hasKey,
                      displayName: displayName,
                    )
                  : _buildStandardContent(
                      context: context,
                      brandColor: brandColor,
                      hasKey: hasKey,
                      displayName: displayName,
                      compact: compact,
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStandardContent({
    required BuildContext context,
    required Color brandColor,
    required bool hasKey,
    required String displayName,
    required bool compact,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: hasKey ? Colors.greenAccent : Colors.white24,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                provider.id.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white38,
                  letterSpacing: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              provider.availableInSyria ? Icons.public : Icons.vpn_lock,
              size: 14.sp,
              color: provider.availableInSyria ? Colors.greenAccent : Colors.orangeAccent,
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          displayName,
          style: GoogleFonts.cairo(
            fontSize: compact ? 13.sp : 14.sp,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.15,
          ),
          maxLines: compact ? 1 : 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 7.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: [
            _buildMiniTag(
              icon: provider.tierIcon,
              text: _tierLabel(context, provider.tier),
              color: provider.tier == ProviderTier.free ? Colors.greenAccent : Colors.amberAccent,
            ),
            _buildMiniTag(
              icon: Icons.star_rounded,
              text: '${provider.qualityRating}',
              color: Colors.orangeAccent,
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(9.r),
                  border: Border.all(color: Colors.white10),
                ),
                child: Text(
                  provider.tier == ProviderTier.free
                      ? context.tr('marketplace_page.cost_free')
                      : (provider.paidPricing ?? context.tr('marketplace_page.cost_paid')),
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10.sp,
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: brandColor.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(9.r),
                border: Border.all(color: brandColor.withValues(alpha: 0.35)),
              ),
              child: Icon(Icons.tune_rounded, size: 14.sp, color: brandColor),
            ),
          ],
        ),
      ],
    );
  }

  String _tierLabel(BuildContext context, ProviderTier tier) {
    switch (tier) {
      case ProviderTier.free:
        return context.tr('marketplace_page.cost_free');
      case ProviderTier.freemium:
        return context.tr('marketplace_page.cost_freemium');
      case ProviderTier.paid:
        return context.tr('marketplace_page.cost_paid');
      case ProviderTier.openSource:
        return context.tr('marketplace_page.cost_open_source');
    }
  }

  Widget _buildUltraCompactContent({
    required BuildContext context,
    required Color brandColor,
    required bool hasKey,
    required String displayName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 7.w,
              height: 7.w,
              decoration: BoxDecoration(
                color: hasKey ? Colors.greenAccent : Colors.white24,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Text(
                provider.id.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white38,
                  letterSpacing: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              provider.availableInSyria ? Icons.public : Icons.vpn_lock,
              size: 12.sp,
              color: provider.availableInSyria ? Colors.greenAccent : Colors.orangeAccent,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              displayName,
              style: GoogleFonts.cairo(
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                provider.tier == ProviderTier.free
                    ? context.tr('marketplace_page.cost_free')
                    : (provider.paidPricing ?? context.tr('marketplace_page.cost_paid')),
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 9.sp,
                  color: Colors.white70,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.tune_rounded, size: 13.sp, color: brandColor),
          ],
        ),
      ],
    );
  }

  Widget _buildMiniTag({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            text,
            style: GoogleFonts.cairo(
              fontSize: 10.sp,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
