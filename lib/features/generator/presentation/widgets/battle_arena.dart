import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import 'contestants_grid.dart';

class BattleArena extends StatelessWidget {
  final List<String> contestants;
  final bool isLoading;
  
  const BattleArena({
    this.contestants = const [],
    this.isLoading = false,
    super.key,
  });

  // Lines: 40/300
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.background, // Or a slightly lighter shade if needed
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (contestants.isEmpty)
             Icon(
              Icons.sports_mma_outlined,
              size: 80.w,
              color: AppColors.surface,
            )
          else
            ContestantsGrid(contestants: contestants),
        ],
      ),
    );
  }
}
