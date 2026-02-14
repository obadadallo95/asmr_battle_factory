// Lines: 200/300
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../domain/entities/contestant.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/theme/golden_ratio.dart';
import '../../../../core/utils/responsive_extensions.dart';
import '../../../configurator/presentation/widgets/contestant_browser_sheet.dart';


class ContestantSelector extends ConsumerWidget {
  final List<Contestant> contestants;
  final Function(int oldIndex, int newIndex) onReorder;
  final Function(int index, Contestant updated) onUpdate;

  const ContestantSelector({
    required this.contestants,
    required this.onReorder,
    required this.onUpdate,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ReorderableListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: contestants.length,
          onReorder: onReorder,
          proxyDecorator: (child, index, animation) {
            return Material(
              color: Colors.transparent,
              child: child,
            );
          },
          itemBuilder: (context, index) {
            final contestant = contestants[index];
            return Padding(
              key: ValueKey(contestant.id),
              padding: EdgeInsets.only(bottom: 12.h),
              child: _ContestantCard(
                contestant: contestant,
                index: index,
                onUpdate: (updated) => onUpdate(index, updated),
              ),
            );
          },
        ),
        
        // Add Contestant Button
        if (contestants.length < 8) ...[
          SizedBox(height: 1.g),
          GlassCard(
            child: InkWell(
              onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const ContestantBrowserSheet(),
              ),
              borderRadius: context.gBorderRadius(Factor.sm),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2.g),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 4.t,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 0.g),
                    Text(
                      'add_contestant'.tr(),
                      style: GoogleFonts.cairo(
                        color: Theme.of(context).primaryColor,
                        fontSize: 2.t,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.8, 0.8)),
        ],
      ],
    );
  }
}

class _ContestantCard extends StatefulWidget {
  final Contestant contestant;
  final int index;
  final ValueChanged<Contestant> onUpdate;

  const _ContestantCard({
    required this.contestant,
    required this.index,
    required this.onUpdate,
  });

  @override
  State<_ContestantCard> createState() => _ContestantCardState();
}

class _ContestantCardState extends State<_ContestantCard> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contestant.nameEn);
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          // Drag Handle
          Icon(Icons.drag_indicator, color: Colors.white24, size: 20.sp),
          SizedBox(width: 12.w),
          
          // Icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(50),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.bug_report, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          
          // Inputs
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  onChanged: (val) => widget.onUpdate(widget.contestant.copyWith(nameEn: val)),
                  decoration: const InputDecoration(
                    hintText: 'Name (e.g. Mecha Ant)',
                    hintStyle: TextStyle(color: Colors.white30),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      'STR: ${(widget.contestant.powerLevel * 10).toInt()}',
                      style: TextStyle(color: Colors.white54, fontSize: 10.sp),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
                          overlayShape: SliderComponentShape.noOverlay,
                          trackHeight: 2.h,
                        ),
                        child: Slider(
                          value: widget.contestant.powerLevel,
                          min: 1,
                          max: 10,
                          activeColor: Theme.of(context).primaryColor,
                          inactiveColor: Colors.white10,
                          onChanged: (val) => widget.onUpdate(widget.contestant.copyWith(powerLevel: val)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (widget.index * 100).ms, duration: 400.ms).slideX(begin: -0.2, end: 0);
  }
}
