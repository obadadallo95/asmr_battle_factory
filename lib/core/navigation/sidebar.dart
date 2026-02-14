import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class Sidebar extends StatelessWidget {
  final int currentIndex;
  final bool isCollapsed;
  final Function(int) onTabSelected;
  final VoidCallback onToggle;

  const Sidebar({
    super.key,
    required this.currentIndex,
    required this.isCollapsed,
    required this.onTabSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      width: isCollapsed ? 80.w : 250.w,
      decoration: BoxDecoration(
        color: const Color(0xFF161625),
        border: Border(right: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Column(
        children: [
          _buildLogo(),
          const Divider(color: Colors.white10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              children: [
                _SidebarItem(
              icon: Icons.dashboard_outlined,
              labelKey: 'navigation.dashboard',
              isSelected: currentIndex == 0,
              isCollapsed: isCollapsed,
              onTap: () => onTabSelected(0),
            ),
            _SidebarItem(
              icon: Icons.folder_open_outlined,
              labelKey: 'navigation.projects',
              isSelected: currentIndex == 1,
              isCollapsed: isCollapsed,
              onTap: () => onTabSelected(1),
            ),
            _SidebarItem(
              icon: Icons.tune_outlined,
              labelKey: 'navigation.configurator',
              isSelected: currentIndex == 2,
              isCollapsed: isCollapsed,
              onTap: () => onTabSelected(2),
            ),
            _SidebarItem(
              icon: Icons.science_outlined,
              labelKey: 'navigation.ai_lab',
              isSelected: currentIndex == 3,
              isCollapsed: isCollapsed,
              onTap: () => onTabSelected(3),
            ),
            _SidebarItem(
              icon: Icons.lightbulb_outline,
              labelKey: 'navigation.idea_vault',
              isSelected: currentIndex == 4,
              isCollapsed: isCollapsed,
              onTap: () => onTabSelected(4),
            ),
            _SidebarItem(
              icon: Icons.shopping_basket_outlined,
              labelKey: 'navigation.marketplace',
              isSelected: currentIndex == 5,
              isCollapsed: isCollapsed,
              onTap: () => onTabSelected(5),
            ),
            _SidebarItem(
              icon: Icons.analytics_outlined,
              labelKey: 'navigation.analytics',
              isSelected: currentIndex == 6,
              isCollapsed: isCollapsed,
              onTap: () => onTabSelected(6),
            ),
            _SidebarItem(
              icon: Icons.info_outline,
              labelKey: 'navigation.about',
              isSelected: currentIndex == 7,
              isCollapsed: isCollapsed,
              onTap: () => onTabSelected(7),
            ),
              ],
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.purple, Colors.blue]),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(Icons.flash_on, color: Colors.white),
          ),
          if (!isCollapsed) ...[
            SizedBox(width: 12.w),
            Text(
              'navigation.sidebar_logo_title'.tr().isEmpty ? 'BATTLE FACTORY' : 'navigation.sidebar_logo_title'.tr(),
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                letterSpacing: 1,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const Divider(color: Colors.white10),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          leading: Icon(
            isCollapsed ? Icons.chevron_right : Icons.chevron_left,
            color: Colors.white38,
          ),
          title: isCollapsed ? null : Text('navigation.collapse'.tr(), style: GoogleFonts.cairo(color: Colors.white38, fontSize: 12.sp)),
          onTap: onToggle,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String labelKey;
  final bool isSelected;
  final bool isCollapsed;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.labelKey,
    required this.isSelected,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: isCollapsed ? 0 : 12.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.purpleAccent : Colors.white54,
              size: 24.sp,
            ),
            if (!isCollapsed) ...[
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    labelKey.tr(),
                    style: GoogleFonts.cairo(
                      color: isSelected ? Colors.white : Colors.white54,
                      fontSize: 13.sp,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (context.locale.languageCode == 'ar')
                    Text(
                      labelKey.tr(), // Simplified translation
                      style: TextStyle(
                        color: isSelected ? Colors.white24 : Colors.white10,
                        fontSize: 9.sp,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
