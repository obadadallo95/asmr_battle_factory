import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/vault/data/repositories/vault_repository.dart';
import 'package:asmr_battle_factory/features/vault/data/models/saved_scenario.dart';
import 'package:asmr_battle_factory/features/vault/presentation/widgets/saved_scenario_card.dart';
import '../../../../config/di/injection.dart';

final vaultScenariosProvider = StreamProvider<List<SavedScenario>>((ref) {
  final repo = getIt<VaultRepository>();
  return repo.watchVault().map((_) => repo.getAllScenarios());
});

class IdeaVaultPage extends ConsumerWidget {
  const IdeaVaultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scenariosAsync = ref.watch(vaultScenariosProvider);

    return Padding(
      padding: EdgeInsets.all(30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 30.h),
          Expanded(
            child: scenariosAsync.when(
              data: (scenarios) => scenarios.isEmpty 
                ? _buildEmptyState(context) 
                : _buildVaultGrid(context, scenarios),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('common.error'.tr(args: ['$e']), style: const TextStyle(color: Colors.red))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'vault.title'.tr(),
              style: GoogleFonts.cairo(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              'vault.subtitle'.tr(),
              style: GoogleFonts.cairo(color: Colors.white38, fontSize: 14.sp),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 18),
          label: Text('vault.generate_5'.tr(), style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lightbulb_outline, size: 80.sp, color: Colors.white10),
          SizedBox(height: 20.h),
          Text(
            'vault.empty.title'.tr(),
            style: GoogleFonts.cairo(color: Colors.white38, fontSize: 18.sp),
          ),
          SizedBox(height: 10.h),
          Text(
            'vault.empty.desc'.tr(),
            style: GoogleFonts.cairo(color: Colors.white10, fontSize: 12.sp),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVaultGrid(BuildContext context, List<SavedScenario> scenarios) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
        childAspectRatio: 1.4,
      ),
      itemCount: scenarios.length,
      itemBuilder: (context, index) {
        return SavedScenarioCard(scenario: scenarios[index]);
      },
    );
  }
}
