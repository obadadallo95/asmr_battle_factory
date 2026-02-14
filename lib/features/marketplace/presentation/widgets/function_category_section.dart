import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';
import 'provider_card.dart';

class FunctionCategorySection extends StatelessWidget {
  final String title;
  final ProviderFunction function;
  final List<ProviderCatalogEntry> providers;

  const FunctionCategorySection({
    super.key,
    required this.title,
    required this.function,
    required this.providers,
  });

  @override
  Widget build(BuildContext context) {
    if (providers.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 420;
        final cardWidth = (constraints.maxWidth * (isCompact ? 0.74 : 0.48)).clamp(190.0, 270.0);
        final cardHeight = isCompact ? 176.0 : 184.0;

        return Padding(
          padding: EdgeInsets.only(bottom: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Text(
                        context.tr('marketplace_page.providers_count', args: [providers.length.toString()]),
                        style: GoogleFonts.cairo(
                          fontSize: 11.sp,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: cardHeight,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: providers.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: cardWidth,
                      child: ProviderCard(provider: providers[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
