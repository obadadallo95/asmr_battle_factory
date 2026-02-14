import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Let shell handle bg
      body: SingleChildScrollView(
        padding: EdgeInsets.all(40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(context),
            SizedBox(height: 60.h),
            _buildPhilosophySection(),
            SizedBox(height: 60.h),
            _buildTechStats(),
            SizedBox(height: 60.h),
            _buildDeveloperCard(),
            SizedBox(height: 100.h), // Extra padding at bottom
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                image: const DecorationImage(image: AssetImage('assets/images/icon_app.png')),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ).animate().shimmer(duration: 2.seconds).scale(),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'app_title'.tr(),
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'v1.0.0 (Production Build)',
                  style: GoogleFonts.jetBrainsMono(
                    color: Colors.purpleAccent,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 30.h),
        Text(
          'about.studio_title'.tr(),
          style: GoogleFonts.cairo(
            color: Colors.white60,
            fontSize: 18.sp,
            letterSpacing: 1.2,
          ),
        ).animate().fadeIn(delay: 400.ms).slideX(),
      ],
    );
  }

  Widget _buildPhilosophySection() {
    return Container(
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.amber),
              SizedBox(width: 10.w),
              Text(
                'about.philosophy.title'.tr(),
                style: GoogleFonts.cairo(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            'about.philosophy.desc_ar'.tr(),
            style: GoogleFonts.cairo(color: Colors.white70, fontSize: 15.sp, height: 1.6),
          ),
          SizedBox(height: 15.h),
          Text(
            'about.philosophy.desc_en'.tr(),
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 14.sp, height: 1.6),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTechStats() {
    return Wrap(
      spacing: 20.w,
      runSpacing: 20.h,
      children: [
        _statCard('3000+', 'about.stats.code'.tr(), Icons.code),
        _statCard('50+', 'about.stats.contestants'.tr(), Icons.groups),
        _statCard('100%', 'about.stats.architecture'.tr(), Icons.architecture),
        _statCard('Reactive', 'about.stats.state'.tr(), Icons.bolt),
      ],
    );
  }

  Widget _statCard(String val, String label, IconData icon) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF161625),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.purpleAccent, size: 24.sp),
          SizedBox(height: 10.h),
          Text(val, style: GoogleFonts.jetBrainsMono(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
          Text(label, style: GoogleFonts.cairo(color: Colors.white30, fontSize: 10.sp)),
        ],
      ),
    );
  }

  Widget _buildDeveloperCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(40.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purpleAccent.withValues(alpha: 0.05), Colors.blueAccent.withValues(alpha: 0.05)],
        ),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage('assets/images/Obada.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.purpleAccent, width: 2),
            ),
          ).animate().scale(delay: 800.ms),
          SizedBox(height: 20.h),
          Text(
            'Obada Dallo',
            style: GoogleFonts.cairo(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            'about.developer.role'.tr(),
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 14.sp),
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialBtn(Icons.language, 'https://obadadallo.com'),
              SizedBox(width: 20.w),
              _socialBtn(Icons.code, 'https://github.com/obadadallo'),
              SizedBox(width: 20.w),
              _socialBtn(Icons.contact_mail, 'mailto:obada.dallo@gmail.com'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialBtn(IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }
}
