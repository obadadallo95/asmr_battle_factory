import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class PlatformSelectorButton extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const PlatformSelectorButton({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: ['TikTok', 'Shorts', 'Reels'].map((platform) {
          final isSelected = selected == platform;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(platform),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.2) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  border: isSelected ? Border.all(color: AppColors.primary) : null,
                ),
                child: Center(
                  child: Text(
                    platform,
                    style: AppTextStyles.body.copyWith(
                      color: isSelected ? AppColors.primary : Colors.grey,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
