import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';

class ProviderComparisonSheet extends StatelessWidget {
  final List<ProviderCatalogEntry> providers;

  const ProviderComparisonSheet({super.key, required this.providers});

  @override
  Widget build(BuildContext context) {
    if (providers.isEmpty) return const SizedBox();

    return Container(
      height: 0.7.sh,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Text(
            context.tr('marketplace_page.compare_title'),
            style: GoogleFonts.cairo(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 20.w,
                  headingRowColor: WidgetStateProperty.all(Colors.white10),
                  dataRowColor: WidgetStateProperty.all(Colors.transparent),
                  columns: [
                    const DataColumn(label: Text('', style: TextStyle(color: Colors.white))),
                    ...providers.map((p) => DataColumn(
                      label: Container(
                        constraints: BoxConstraints(maxWidth: 100.w),
                        child: Text(
                          context.locale.languageCode == 'ar' ? p.nameAr : p.name,
                          style: GoogleFonts.cairo(
                            color: p.brandColorValue,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )),
                  ],
                  rows: [
                    _buildRow(context.tr('marketplace_page.price'), providers.map((p) => p.tierLabel).toList()), // Need keys for attributes?
                    _buildRow(context.tr('marketplace_page.quality'), providers.map((p) => '⭐ ${p.qualityRating}').toList()),
                    _buildRow(context.tr('marketplace_page.speed'), providers.map((p) => '⚡ ${p.speedRating}').toList()),
                    _buildRow(context.tr('marketplace_page.visa_required'), providers.map((p) => p.requiresCreditCard ? '✅' : '❌').toList()),
                    _buildRow(context.tr('marketplace_page.syria_support'), providers.map((p) => p.availableInSyria ? '✅' : '❌').toList()),
                    _buildRow(context.tr('marketplace_page.key_required'), providers.map((p) => p.requiresKey ? '✅' : '❌').toList()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String label, List<String> values) {
    return DataRow(
      cells: [
        DataCell(Text(label, style: GoogleFonts.cairo(color: Colors.white70, fontWeight: FontWeight.bold))),
        ...values.map((v) => DataCell(Text(v, style: GoogleFonts.cairo(color: Colors.white)))),
      ],
    );
  }
}
