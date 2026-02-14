import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/configurator/presentation/widgets/contestant_grid.dart';
import 'package:asmr_battle_factory/features/configurator/presentation/widgets/selected_contestants_bar.dart';
import 'package:asmr_battle_factory/features/configurator/presentation/widgets/winner_selector_widget.dart';
import 'package:asmr_battle_factory/features/configurator/data/models/battle_config.dart';
import 'package:asmr_battle_factory/features/vault/domain/services/multi_scenario_generator.dart';
import 'package:asmr_battle_factory/features/vault/data/repositories/vault_repository.dart';
import 'package:asmr_battle_factory/features/configurator/presentation/widgets/scenario_picker_sheet.dart';
import '../../../../config/di/injection.dart';
import '../../../../core/widgets/guarded_scaffold.dart';
import '../../../../core/services/navigation_guard_service.dart';
import '../../../../core/widgets/breadcrumb_bar.dart';

final battleConfigProvider = StateProvider<BattleConfig>((ref) {
  return const BattleConfig(
    id: 'draft',
    selectedContestantIds: [],
  );
});

class BattleConfiguratorPage extends ConsumerWidget {
  const BattleConfiguratorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for unsaved changes
    ref.listen(battleConfigProvider, (prev, next) {
      // Logic to determine if changes are significant (e.g. not empty)
      final hasChanges = next.selectedContestantIds.isNotEmpty;
      ref.read(navigationGuardProvider.notifier).setUnsavedChanges(hasChanges);
    });

    return GuardedScaffold(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isVertical = constraints.maxWidth < 900;
          
          if (isVertical) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(15.w, 15.w, 15.w, 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   _buildHeader(),
                   SizedBox(height: 30.h),
                   const ContestantGrid(),
                   SizedBox(height: 30.h),
                   const SelectedContestantsBar(),
                   SizedBox(height: 30.h),
                   _buildStudioControls(context, ref),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms);
          }

          return Padding(
            padding: EdgeInsets.all(30.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      SizedBox(height: 20.h),
                      const Expanded(
                        child: SingleChildScrollView(
                          child: ContestantGrid()
                        )
                      ),
                      SizedBox(height: 20.h),
                      const SelectedContestantsBar(),
                    ],
                  ),
                ),
                SizedBox(width: 30.w),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: _buildStudioControls(context, ref)
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BreadcrumbBar(
          items: [
            BreadcrumbItem(label: 'navigation.home'.tr(), onTap: () => {}), // No-op or context.go('/app/home')
            BreadcrumbItem(label: 'navigation.studio'.tr(), isActive: true),
          ],
        ),
        SizedBox(height: 10.h),
        Text(
          'configurator.title'.tr(),
          style: GoogleFonts.cairo(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
        Text(
          'configurator.subtitle'.tr(),
          style: GoogleFonts.cairo(color: Colors.white38, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildStudioControls(BuildContext context, WidgetRef ref) {
    final config = ref.watch(battleConfigProvider);

    return Container(
      padding: EdgeInsets.all(25.w),
      decoration: BoxDecoration(
        color: const Color(0xFF161625),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'configurator.settings_title'.tr(),
            style: GoogleFonts.cairo(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30.h),
          const WinnerSelectorWidget(),
          const Divider(color: Colors.white10, height: 40),
          _buildBattleTypeSelector(ref, config),
          SizedBox(height: 30.h),
          _buildActionButtons(context, ref, config),
        ],
      ),
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }

  Widget _buildBattleTypeSelector(WidgetRef ref, BattleConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('configurator.battle_type.title'.tr(), style: GoogleFonts.cairo(color: Colors.white54, fontSize: 13.sp)),
        SizedBox(height: 15.h),
        _typeChip(ref, BattleType.tournament, 'configurator.battle_type.tournament'.tr(), config.battleType == BattleType.tournament),
        SizedBox(height: 10.h),
        _typeChip(ref, BattleType.battleRoyale, 'configurator.battle_type.royale'.tr(), config.battleType == BattleType.battleRoyale),
        SizedBox(height: 10.h),
        _typeChip(ref, BattleType.revengeSeries, 'configurator.battle_type.revenge'.tr(), config.battleType == BattleType.revengeSeries),
      ],
    );
  }

  Widget _typeChip(WidgetRef ref, BattleType type, String label, bool isSelected) {
    return InkWell(
      onTap: () => ref.read(battleConfigProvider.notifier).update((s) => s.copyWith(battleType: type)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purpleAccent.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: isSelected ? Colors.purpleAccent : Colors.white10),
        ),
        child: Text(
          label,
          style: GoogleFonts.cairo(color: isSelected ? Colors.white : Colors.white38, fontSize: 13.sp),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, BattleConfig config) {
    return Column(
      children: [
        _btn('configurator.actions.save_draft'.tr(), Colors.white.withValues(alpha: 0.05), Colors.white, () {}),
        SizedBox(height: 12.h),
        _btn('configurator.actions.generate'.tr(), Colors.purpleAccent, Colors.white, () => _handleGenerate(context, ref, config)),
      ],
    );
  }

  Future<void> _handleGenerate(BuildContext context, WidgetRef ref, BattleConfig config) async {
    if (config.selectedContestantIds.isEmpty) return;

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.purpleAccent)),
    );

    final scenarios = await getIt<MultiScenarioGenerator>().generateBatch(config.selectedContestantIds);
    
    if (context.mounted) Navigator.pop(context); // Close loading

    if (!context.mounted) return;
    if (scenarios.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => ScenarioPickerSheet(
          scenarios: scenarios,
          onSelected: (selected) async {
            await getIt<VaultRepository>().saveScenario(selected);
            if (context.mounted) Navigator.pop(context);
            // Optionally navigate to production page
          },
        ),
      );
    }
  }

  Widget _btn(String label, Color bg, Color text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: text,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: Text(label, style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
