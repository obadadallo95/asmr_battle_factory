import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('preview.title'.tr()),
        backgroundColor: AppColors.surface,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library_outlined,
              size: 80.w,
              color: AppColors.secondary,
            ),
            SizedBox(height: 16.h),
            Text(
              'preview.coming_soon'.tr(),
              style: AppTextStyles.headline.copyWith(fontSize: 18.sp),
            ),
          ],
        ),
      ),
    );
  }
}
