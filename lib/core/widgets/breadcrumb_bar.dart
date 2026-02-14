import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;
  final bool isActive;

  BreadcrumbItem({required this.label, this.onTap, this.isActive = false});
}

class BreadcrumbBar extends StatelessWidget {
  final List<BreadcrumbItem> items;

  const BreadcrumbBar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: items.length,
        separatorBuilder: (context, index) => Icon(
          Icons.chevron_right, 
          color: Colors.white24, 
          size: 16.sp
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: item.onTap,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
              child: Text(
                item.label,
                style: GoogleFonts.cairo(
                  color: item.isActive || item.onTap == null 
                      ? Colors.white 
                      : Colors.white54,
                  fontWeight: item.isActive ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
