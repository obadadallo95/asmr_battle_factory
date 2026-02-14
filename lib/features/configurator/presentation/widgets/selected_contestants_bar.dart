import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/configurator/presentation/pages/battle_configurator_page.dart';
import 'package:asmr_battle_factory/features/contestants/presentation/providers/contestants_provider.dart';

class SelectedContestantsBar extends ConsumerWidget {
  const SelectedContestantsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(battleConfigProvider);
    final selectedIds = config.selectedContestantIds;

    return Container(
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          _buildCountBadge(selectedIds.length),
          SizedBox(width: 20.w),
          Expanded(
            child: ref.watch(contestantsProvider).when(
              data: (allContestants) => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedIds.length,
                itemBuilder: (context, index) {
                  final id = selectedIds[index];
                  final contestant = allContestants.firstWhere(
                    (c) => c.id == id,
                    orElse: () => allContestants.first, // Safe fallback
                  );
                  return _SelectedContestantItem(
                    icon: contestant.iconAsset,
                    onRemove: () => _remove(ref, id),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox(),
            ),
          ),
          if (selectedIds.isNotEmpty) ...[
            SizedBox(width: 10.w),
            TextButton(
              onPressed: () => ref.read(battleConfigProvider.notifier).update((s) => s.copyWith(selectedContestantIds: [])),
              child: Text('configurator.selected.clear_all'.tr(), style: GoogleFonts.cairo(color: Colors.redAccent, fontSize: 12.sp)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCountBadge(int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'configurator.selected.count'.tr(args: ['$count', '8']),
          style: GoogleFonts.jetBrainsMono(color: Colors.purpleAccent, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        Text('configurator.selected.label'.tr(), style: GoogleFonts.cairo(color: Colors.white38, fontSize: 10.sp)),
      ],
    );
  }

  void _remove(WidgetRef ref, String id) {
    ref.read(battleConfigProvider.notifier).update((state) {
      final current = List<String>.from(state.selectedContestantIds);
      current.remove(id);
      return state.copyWith(selectedContestantIds: current);
    });
  }
}

class _SelectedContestantItem extends StatelessWidget {
  final String icon;
  final VoidCallback onRemove;

  const _SelectedContestantItem({required this.icon, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
      width: 60.w,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Stack(
        children: [
          Center(child: Text(icon, style: TextStyle(fontSize: 24.sp))),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: onRemove,
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                child: const Icon(Icons.close, color: Colors.white, size: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
