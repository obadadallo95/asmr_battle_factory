import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
            DataColumn(label: Text('ميزة', style: GoogleFonts.cairo(color: Colors.white70))),
            ...providers.map((p) => DataColumn(
              label: Text(p.nameAr, style: GoogleFonts.cairo(color: p.brandColorValue, fontWeight: FontWeight.bold)),
            )),
          ],
          rows: [
            _buildRow('السعر', providers.map((p) => p.tierLabel).toList()),
            _buildRow('الجودة', providers.map((p) => '${p.qualityRating}/5').toList()),
            _buildRow('السرعة', providers.map((p) => '${p.speedRating}/5').toList()),
            _buildRow('التوفر (سوريا)', providers.map((p) => p.availableInSyria ? '✅' : '❌').toList()),
            _buildRow('يتطلب مفتاح', providers.map((p) => p.requiresKey ? '✅' : '🆓').toList()),
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
}
