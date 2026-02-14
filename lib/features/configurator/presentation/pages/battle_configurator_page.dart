import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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

final _studioStepProvider = StateProvider<int>((ref) => 0);

class BattleConfiguratorPage extends ConsumerWidget {
  const BattleConfiguratorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(battleConfigProvider, (prev, next) {
      final hasChanges = next.selectedContestantIds.isNotEmpty;
      ref.read(navigationGuardProvider.notifier).setUnsavedChanges(hasChanges);
    });

    return GuardedScaffold(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0F1A), Color(0xFF15172A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 110.h),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildHeader(context),
                        SizedBox(height: 12.h),
                        _buildFocusSummary(context, ref),
                        SizedBox(height: 12.h),
                        _buildStepTabs(context, ref),
                        SizedBox(height: 12.h),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 240),
                          child: _buildFocusedStep(context, ref),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BreadcrumbBar(
          items: [
            BreadcrumbItem(label: 'navigation.home'.tr(), onTap: () => {}),
            BreadcrumbItem(label: 'navigation.studio'.tr(), isActive: true),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          context.tr('configurator.title'),
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          context.tr('configurator.studio.subtitle'),
          style: GoogleFonts.cairo(color: Colors.white54, fontSize: 13.sp),
        ),
      ],
    );
  }

  Widget _buildFocusSummary(BuildContext context, WidgetRef ref) {
    final config = ref.watch(battleConfigProvider);
    final count = config.selectedContestantIds.length;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: [
          _metaChip(Icons.groups_2_outlined, context.tr('configurator.studio.meta.selected', args: ['$count', '8'])),
          _metaChip(Icons.emoji_events_outlined, context.tr('configurator.studio.meta.winner', args: [context.tr('winner_mode.${config.winnerMode.name}')])),
          _metaChip(Icons.auto_awesome_motion, context.tr('configurator.studio.meta.mode', args: [context.tr('battle_type.${config.battleType.name}')])),
        ],
      ),
    );
  }

  Widget _metaChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white54, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            text,
            style: GoogleFonts.cairo(
              color: Colors.white70,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepTabs(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(_studioStepProvider);
    final items = [
      _StepItem(
        title: context.tr('configurator.studio.steps.contestants'),
        icon: Icons.grid_view_rounded,
      ),
      _StepItem(
        title: context.tr('configurator.studio.steps.selected'),
        icon: Icons.groups_2_rounded,
      ),
      _StepItem(
        title: context.tr('configurator.studio.steps.configure'),
        icon: Icons.tune_rounded,
      ),
    ];

    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Wrap(
        spacing: 6.w,
        runSpacing: 6.h,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isActive = currentStep == index;

          return InkWell(
            onTap: () => ref.read(_studioStepProvider.notifier).state = index,
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isActive ? Colors.purpleAccent.withValues(alpha: 0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: isActive ? Colors.purpleAccent : Colors.white12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, size: 14.sp, color: isActive ? Colors.white : Colors.white60),
                  SizedBox(width: 4.w),
                  Text(
                    item.title,
                    style: GoogleFonts.cairo(
                      color: isActive ? Colors.white : Colors.white60,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFocusedStep(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(_studioStepProvider);

    if (currentStep == 0) {
      return _sectionCard(
        key: const ValueKey('step_0'),
        title: context.tr('configurator.studio.sections.pick_title'),
        subtitle: context.tr('configurator.subtitle'),
        child: const ContestantGrid(),
      );
    }

    if (currentStep == 1) {
      return _sectionCard(
        key: const ValueKey('step_1'),
        title: context.tr('configurator.studio.sections.review_title'),
        subtitle: context.tr('configurator.studio.sections.review_subtitle'),
        child: const SelectedContestantsBar(),
      );
    }

    return _sectionCard(
      key: const ValueKey('step_2'),
      title: context.tr('configurator.studio.sections.settings_title'),
      subtitle: context.tr('configurator.settings_title'),
      child: _buildStudioControls(context, ref),
    );
  }

  Widget _sectionCard({required Key key, required String title, required String subtitle, required Widget child}) {
    return Container(
      key: key,
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF161625),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.cairo(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: GoogleFonts.cairo(color: Colors.white38, fontSize: 12.sp),
          ),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }

  Widget _buildStudioControls(BuildContext context, WidgetRef ref) {
    final config = ref.watch(battleConfigProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WinnerSelectorWidget(),
        const Divider(color: Colors.white10, height: 24),
        _buildBattleTypeSelector(ref, config),
        SizedBox(height: 14.h),
        _buildActionButtons(context, ref, config),
      ],
    );
  }

  Widget _buildBattleTypeSelector(WidgetRef ref, BattleConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'configurator.battle_type.title'.tr(),
          style: GoogleFonts.cairo(color: Colors.white54, fontSize: 12.sp),
        ),
        SizedBox(height: 8.h),
        _typeChip(ref, BattleType.tournament, 'configurator.battle_type.tournament'.tr(), config.battleType == BattleType.tournament),
        SizedBox(height: 8.h),
        _typeChip(ref, BattleType.battleRoyale, 'configurator.battle_type.royale'.tr(), config.battleType == BattleType.battleRoyale),
        SizedBox(height: 8.h),
        _typeChip(ref, BattleType.revengeSeries, 'configurator.battle_type.revenge'.tr(), config.battleType == BattleType.revengeSeries),
      ],
    );
  }

  Widget _typeChip(WidgetRef ref, BattleType type, String label, bool isSelected) {
    return InkWell(
      onTap: () => ref.read(battleConfigProvider.notifier).update((s) => s.copyWith(battleType: type)),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purpleAccent.withValues(alpha: 0.16) : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: isSelected ? Colors.purpleAccent : Colors.white10),
        ),
        child: Text(
          label,
          style: GoogleFonts.cairo(color: isSelected ? Colors.white : Colors.white54, fontSize: 12.sp),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, BattleConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _btn(
          'configurator.actions.generate'.tr(),
          Colors.purpleAccent,
          Colors.white,
          () => _handleGenerate(context, config),
          primary: true,
        ),
        SizedBox(height: 8.h),
        _btn(
          'configurator.actions.save_draft'.tr(),
          Colors.white.withValues(alpha: 0.06),
          Colors.white70,
          () {},
        ),
      ],
    );
  }

  Future<void> _handleGenerate(BuildContext context, BattleConfig config) async {
    if (config.selectedContestantIds.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.purpleAccent)),
    );

    final scenarios = await getIt<MultiScenarioGenerator>().generateBatch(config.selectedContestantIds);

    if (context.mounted) Navigator.pop(context);

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
          },
        ),
      );
    }
  }

  Widget _btn(String label, Color bg, Color text, VoidCallback onTap, {bool primary = false}) {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: text,
          elevation: primary ? 1 : 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: Text(
          label,
          style: GoogleFonts.cairo(fontWeight: FontWeight.w800, fontSize: 13.sp),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _StepItem {
  final String title;
  final IconData icon;

  const _StepItem({required this.title, required this.icon});
}
