import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/budget/presentation/providers/budget_provider.dart';

class TopBar extends ConsumerWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetStats = ref.watch(budgetStatsProvider);

    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: const BoxDecoration(
        color: Color(0xFF0F0F1A),
        border: Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        children: [
          _buildSearch(context),
          const Spacer(),
          _buildStatCard(
            'navigation.spent_today',
            '\$${budgetStats.asData?.value.totalSpentToday.toStringAsFixed(2) ?? "0.00"}',
            Icons.account_balance_wallet_outlined,
            Colors.greenAccent,
          ),
          SizedBox(width: 20.w),
          _buildNotificationBell(),
          SizedBox(width: 20.w),
          _buildUserAvatar(),
        ],
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Container(
      width: 400.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white10),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'navigation.search_hint'.tr(),
          hintStyle: GoogleFonts.cairo(color: Colors.white38, fontSize: 13.sp),
          prefixIcon: const Icon(Icons.search, color: Colors.white38),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        ),
      ),
    );
  }

  Widget _buildStatCard(String labelKey, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                labelKey.tr(),
                style: GoogleFonts.cairo(color: color, fontSize: 10.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: GoogleFonts.jetBrainsMono(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBell() {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.notifications_none, color: Colors.white70),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 45.w,
      height: 45.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.purple, Colors.pink]),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Text(
          'O',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
      ),
    );
  }
}
