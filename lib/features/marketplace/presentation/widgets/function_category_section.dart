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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                context.tr('marketplace_page.providers_count', args: [providers.length.toString()]),
                style: GoogleFonts.cairo(
                  fontSize: 12.sp,
                  color: Colors.white38,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 240.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            itemCount: providers.length,
            itemBuilder: (context, index) {
              return ProviderCard(provider: providers[index]);
            },
          ),
        ),
      ],
    );
  }
}
