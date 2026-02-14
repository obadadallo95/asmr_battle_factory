import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:asmr_battle_factory/core/services/security/api_key_service.dart';
import 'package:asmr_battle_factory/features/marketplace/data/provider_database.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';
import 'package:asmr_battle_factory/core/widgets/glass_card.dart';
import 'package:asmr_battle_factory/config/di/injection.dart';

final configuredProvidersProvider = FutureProvider<List<ProviderCatalogEntry>>((ref) async {
  final keyService = getIt<APIKeyService>();
  final db = getIt<ProviderDatabase>();
  await db.initialize();
  
  final ids = await keyService.getConfiguredProviders();
  return ids.map((id) => db.getById(id)).whereType<ProviderCatalogEntry>().toList();
});

class MyAPIPortfolioPage extends ConsumerWidget {
  const MyAPIPortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configuredAsync = ref.watch(configuredProvidersProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'محفظة الـ APIs الخاصة بك',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          // Background components...
          SafeArea(
            child: configuredAsync.when(
              data: (providers) => _buildContent(context, providers, ref),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('common.error'.tr(args: [err.toString()]))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<ProviderCatalogEntry> providers, WidgetRef ref) {
    if (providers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet_outlined, color: Colors.white24, size: 60.sp),
            SizedBox(height: 16.h),
            Text(
              'لا توجد مفاتيح API مفعلة بعد',
              style: GoogleFonts.cairo(color: Colors.white38),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('navigation.marketplace_explore'.tr()),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.all(20.w),
      children: [
        Text(
          'الخدمات المفعلة',
          style: GoogleFonts.cairo(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        ...providers.map((p) => _buildProviderListItem(context, p, ref)),
        SizedBox(height: 30.h),
        _buildStatsCard(),
      ],
    ).animate().fadeIn();
  }

  Widget _buildProviderListItem(BuildContext context, ProviderCatalogEntry p, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: GlassCard(
        child: ListTile(
          leading: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: p.brandColorValue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(p.tierIcon, color: p.brandColorValue, size: 20.sp),
          ),
          title: Text(p.nameAr, style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text('Status: Active', style: TextStyle(color: Colors.greenAccent, fontSize: 10.sp)),
          trailing: IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.redAccent, size: 20.sp),
            onPressed: () async {
              // Confirmation logic...
              await getIt<APIKeyService>().removeKey(p.id);
              ref.invalidate(configuredProvidersProvider);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return GlassCard(
      color: Colors.blue.withValues(alpha: 0.05),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ملخص الاستهلاك',
              style: GoogleFonts.cairo(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _stat('إجمالي الطلبات', '450'),
                _stat('التكلفة التقريبية', '\$2.45'),
                _stat('توفير الميزانية', '15%'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, String val) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.white38, fontSize: 10.sp)),
        Text(val, style: GoogleFonts.jetBrainsMono(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
