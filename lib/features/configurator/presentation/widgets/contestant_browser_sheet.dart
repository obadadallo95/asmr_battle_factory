import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/golden_ratio.dart';
import '../../../../core/utils/responsive_extensions.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../generator/domain/entities/contestant.dart';
import '../providers/contestant_browser_providers.dart';
import '../providers/battle_config_provider.dart';

class ContestantBrowserSheet extends ConsumerWidget {
  const ContestantBrowserSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredAsync = ref.watch(filteredContestantsProvider);
    final selected = ref.watch(battleConfigProvider).contestants;
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Container(
      height: ScreenUtil().screenHeight * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(GoldenRatio.spacing(null, factor: Factor.md)),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 1.g),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          
          Padding(
            padding: context.gPadding(Factor.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'contestant_browser.title'.tr(),
                  style: GoogleFonts.cairo(
                    fontSize: 3.t,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 1.g),
                
                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'search_contestant'.tr(),
                    prefixIcon: Icon(Icons.search, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    border: OutlineInputBorder(
                      borderRadius: context.gBorderRadius(Factor.sm),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 1.g,
                      vertical: 1.g,
                    ),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 2.t),
                  onChanged: (query) {
                    ref.read(contestantSearchProvider.notifier).state = query;
                  },
                ),
                SizedBox(height: 1.g),
                
                // Category filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ContestantCategory.values.map((category) {
                      final isSelected = selectedCategory == category;
                      return Padding(
                        padding: EdgeInsets.only(right: 0.g),
                        child: FilterChip(
                          label: Text('category.${category.name}'.tr()),
                          selected: isSelected,
                          onSelected: (selected) {
                            ref.read(selectedCategoryProvider.notifier).state =
                                selected ? category : null;
                          },
                          selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                          backgroundColor: Colors.white10,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.white70,
                            fontSize: 1.t,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          
          // Grid
          Expanded(
            child: filteredAsync.when(
              data: (contestants) {
                if (contestants.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, size: 5.t, color: Colors.white24),
                        SizedBox(height: 1.g),
                        Text(
                          'no_contestants_found'.tr(),
                          style: TextStyle(color: Colors.white54, fontSize: 2.t),
                        ),
                      ],
                    ),
                  );
                }
                
                return GridView.builder(
                  padding: context.gPadding(Factor.sm),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ScreenUtil().screenWidth > 600 ? 4 : 3,
                    childAspectRatio: 1 / GoldenRatio.phi,
                    crossAxisSpacing: 1.g,
                    mainAxisSpacing: 1.g,
                  ),
                  itemCount: contestants.length,
                  itemBuilder: (context, index) {
                    final contestant =contestants[index];
                    final isSelected = selected.any((c) => c.id == contestant.id);
                    
                    return _ContestantGridCard(
                      contestant: contestant,
                      isSelected: isSelected,
                      onTap: () {
                        if (isSelected) {
                          ref.read(battleConfigProvider.notifier).removeContestant(contestant.id);
                        } else if (selected.length < 8) {
                          ref.read(battleConfigProvider.notifier).addContestant(contestant);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('max_contestants_reached'.tr(args: ['8'])),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Text(
                  'error_loading_contestants'.tr(),
                  style: TextStyle(color: Colors.red, fontSize: 2.t),
                ),
              ),
            ),
          ),
          
          // Footer
          Container(
            padding: context.gPadding(Factor.sm),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(GoldenRatio.spacing(null, factor: Factor.md)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'selected_count'.tr(args: ['${selected.length}', '8']),
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 2.t,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PrimaryButton(
                  text: 'confirm_selection'.tr(),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContestantGridCard extends StatelessWidget {
  final Contestant contestant;
  final bool isSelected;
  final VoidCallback onTap;

  const _ContestantGridCard({
    required this.contestant,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: context.gBorderRadius(Factor.sm),
        child: Container(
          padding: EdgeInsets.all(0.g),
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  )
                : null,
            borderRadius: context.gBorderRadius(Factor.sm),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon/Emoji
              Text(
                contestant.iconAsset,
                style: TextStyle(fontSize: 4.t),
              ),
              SizedBox(height: 0.g),
              
              // Name
              Text(
                context.locale.languageCode == 'ar'
                    ? contestant.nameAr
                    : contestant.nameEn,
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 1.t,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              
              // Power level
              SizedBox(height: 0.g),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bolt,
                    size: 1.t,
                    color: _getPowerColor(contestant.powerLevel),
                  ),
                  Text(
                    '${contestant.powerLevel.toInt()}',
                    style: TextStyle(
                      color: _getPowerColor(contestant.powerLevel),
                      fontSize: 0.t,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              // Selected checkmark
              if (isSelected) ...[
                SizedBox(height: 0.g),
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                  size: 2.t,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  Color _getPowerColor(double power) {
    if (power >= 8) return Colors.red;
    if (power >= 5) return Colors.orange;
    return Colors.green;
  }
}
