import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/configurator/presentation/pages/battle_configurator_page.dart';
import 'package:asmr_battle_factory/features/generator/domain/entities/contestant.dart'; // New location
import 'package:asmr_battle_factory/features/contestants/presentation/providers/contestants_provider.dart';
import 'package:asmr_battle_factory/features/contestants/domain/services/battle_suggester.dart';
import 'package:asmr_battle_factory/config/di/injection.dart';

final categoryFilterProvider = StateProvider<ContestantCategory?>((ref) => null);
final moodFilterProvider = StateProvider<String?>((ref) => null);

class ContestantGrid extends ConsumerWidget {
  const ContestantGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryFilterProvider);
    final selectedMood = ref.watch(moodFilterProvider);
    final config = ref.watch(battleConfigProvider);
    
    final contestantsAsync = ref.watch(contestantsProvider);

    return contestantsAsync.when(
      loading: () => Container(
        height: 200.h,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.purpleAccent),
      ),
      error: (err, stack) => Container(
        height: 150.h,
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.w),
        child: Text(
          'Error loading contestants: $err',
          style: GoogleFonts.cairo(color: Colors.redAccent),
          textAlign: TextAlign.center,
        ),
      ),
      data: (allContestants) {
        if (allContestants.isEmpty) {
          return Container(
            height: 150.h,
            alignment: Alignment.center,
            child: Text(
              'No contestants found',
              style: GoogleFonts.cairo(color: Colors.white38),
            ),
          );
        }

        List<Contestant> contestants;
        if (selectedMood != null) {
          contestants = allContestants.take(10).toList();
        } else {
          contestants = allContestants.where((c) {
            if (selectedCategory == null) return true;
            return c.category == selectedCategory;
          }).toList();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTopBar(ref, selectedCategory, selectedMood),
            SizedBox(height: 20.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ScreenUtil().screenWidth > 600 ? 5 : 3, // Responsive columns
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                childAspectRatio: 0.85,
              ),
              itemCount: contestants.length,
              itemBuilder: (context, index) {
                final contestant = contestants[index];
                final isSelected = config.selectedContestantIds.contains(contestant.id);
                return _ContestantCard(
                  contestant: contestant,
                  isSelected: isSelected,
                  onTap: () => _toggleSelection(ref, contestant.id),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTopBar(WidgetRef ref, ContestantCategory? selected, String? mood) {
    return Row(
      children: [
        Expanded(child: _buildCategoryFilter(ref, selected, mood)),
        SizedBox(width: 15.w),
        _buildLuckButton(ref),
      ],
    );
  }

  Widget _buildCategoryFilter(WidgetRef ref, ContestantCategory? selected, String? mood) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _filterChip(ref, null, 'configurator.library.filter_all'.tr(), selected == null && mood == null, isCategory: true),
          ...ContestantCategory.values.map((cat) => Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: _filterChip(ref, cat, _getCategoryName(cat), selected == cat, isCategory: true),
          )),
          const VerticalDivider(color: Colors.white10),
          _filterChip(ref, 'epic', 'configurator.library.mood_epic'.tr(), mood == 'epic'),
          SizedBox(width: 8.w),
          _filterChip(ref, 'funny', 'configurator.library.mood_funny'.tr(), mood == 'funny'),
          SizedBox(width: 8.w),
          _filterChip(ref, 'scary', 'configurator.library.mood_scary'.tr(), mood == 'scary'),
        ],
      ),
    );
  }

  Widget _filterChip(WidgetRef ref, dynamic value, String label, bool isActive, {bool isCategory = false}) {
    return ChoiceChip(
      label: Text(label, style: GoogleFonts.cairo(fontSize: 12.sp)),
      selected: isActive,
      onSelected: (_) {
        if (isCategory) {
          ref.read(categoryFilterProvider.notifier).state = value;
          ref.read(moodFilterProvider.notifier).state = null;
        } else {
          ref.read(moodFilterProvider.notifier).state = value;
          ref.read(categoryFilterProvider.notifier).state = null;
        }
      },
      backgroundColor: Colors.white.withValues(alpha: 0.05),
      selectedColor: Colors.purpleAccent,
      labelStyle: TextStyle(color: isActive ? Colors.white : Colors.white38),
    );
  }

  Widget _buildLuckButton(WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () async {
        final suggestion = await getIt<BattleSuggester>().suggestRandomBattle();
        ref.read(battleConfigProvider.notifier).state = suggestion;
      },
      icon: const Icon(Icons.casino, size: 18),
      label: Text('configurator.library.luck_btn'.tr(), style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber.withValues(alpha: 0.1),
        foregroundColor: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        side: const BorderSide(color: Colors.amber, width: 0.5),
      ),
    );
  }

  void _toggleSelection(WidgetRef ref, String id) {
    ref.read(battleConfigProvider.notifier).update((state) {
      final current = List<String>.from(state.selectedContestantIds);
      if (current.contains(id)) {
        current.remove(id);
      } else if (current.length < 8) {
        current.add(id);
      }
      return state.copyWith(selectedContestantIds: current);
    });
  }

  String _getCategoryName(ContestantCategory cat) {
    switch (cat) {
      case ContestantCategory.all: return 'categories.all'.tr();
      case ContestantCategory.insects: return 'categories.insects'.tr();
      case ContestantCategory.wildAnimals: return 'categories.wild_animals'.tr();
      case ContestantCategory.marineLife: return 'categories.marine_life'.tr();
      case ContestantCategory.metals: return 'categories.metals'.tr();
      case ContestantCategory.elements: return 'categories.elements'.tr();
      case ContestantCategory.stationery: return 'categories.stationery'.tr();
      case ContestantCategory.food: return 'categories.food'.tr();
      case ContestantCategory.mythical: return 'categories.mythical'.tr();
      case ContestantCategory.tech: return 'categories.tech'.tr();
    }
  }
}

class _ContestantCard extends StatelessWidget {
  final Contestant contestant;
  final bool isSelected;
  final VoidCallback onTap;

  const _ContestantCard({
    required this.contestant,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.purpleAccent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? Colors.purpleAccent : Colors.white.withValues(alpha: 0.05),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(contestant.iconAsset, style: TextStyle(fontSize: 32.sp)),
            SizedBox(height: 10.h),
            Text(
              contestant.nameAr,
              style: GoogleFonts.cairo(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              'configurator.library.power_level'.tr(args: [contestant.powerLevel.toString()]),
              style: TextStyle(color: Colors.white24, fontSize: 10.sp),
            ),
          ],
        ),
      ),
    );
  }
}
