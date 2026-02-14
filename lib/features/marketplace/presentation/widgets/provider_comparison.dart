import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../domain/entities/provider_catalog_entry.dart';
import '../../../../core/widgets/glass_card.dart';

class ProviderComparison extends StatelessWidget {
  final List<ProviderCatalogEntry> providers;

  const ProviderComparison({super.key, required this.providers});

  @override
  Widget build(BuildContext context) {
    if (providers.length < 2) return const SizedBox.shrink();

    return GlassCard(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(Colors.white.withValues(alpha: 0.05)),
          columns: [
            DataColumn(label: Text('marketplace_page.compare_feature'.tr(), style: GoogleFonts.cairo(color: Colors.white70))),
            ...providers.map((p) => DataColumn(
              label: Text(context.locale.languageCode == 'ar' ? p.nameAr : p.name, style: GoogleFonts.cairo(color: p.brandColorValue, fontWeight: FontWeight.bold)),
            )),
          ],
          rows: [
            _buildRow('marketplace_page.compare_price'.tr(), providers.map((p) => _tierLabel(context, p.tier)).toList()),
            _buildRow('marketplace_page.compare_quality'.tr(), providers.map((p) => '${p.qualityRating}/5').toList()),
            _buildRow('marketplace_page.compare_speed'.tr(), providers.map((p) => '${p.speedRating}/5').toList()),
            _buildRow('marketplace_page.compare_availability'.tr(), providers.map((p) => p.availableInSyria ? '✅' : '❌').toList()),
            _buildRow('marketplace_page.compare_requires_key'.tr(), providers.map((p) => p.requiresKey ? '✅' : '🆓').toList()),
          ],
        ),
      ),
    );
  }

  DataRow _buildRow(String label, List<String> values) {
    return DataRow(cells: [
      DataCell(Text(label, style: GoogleFonts.cairo(color: Colors.white54, fontSize: 12.sp))),
      ...values.map((v) => DataCell(Text(v, style: TextStyle(color: Colors.white, fontSize: 12.sp)))),
    ]);
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
}
