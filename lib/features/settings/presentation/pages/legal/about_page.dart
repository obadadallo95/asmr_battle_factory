// Lines: 120/150
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/widgets/glass_card.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _version = '${info.version} (${info.buildNumber})');
  }

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      context.go('/app/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          ),
          onPressed: () => _handleBack(context),
        ),
        title: Text(
          context.tr('navigation.about'),
          style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0A0A0F), Color(0xFF14141F)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Glow decorations
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.withValues(alpha: 0.1),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Section
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 140.w,
                          height: 140.w,
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.05),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                            boxShadow: [
                              BoxShadow(color: Colors.purpleAccent.withValues(alpha: 0.1), blurRadius: 40),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset('assets/images/icon_app.png'),
                          ),
                        ).animate().scale(duration: 800.ms, curve: Curves.elasticOut).shimmer(delay: 2.seconds),
                        SizedBox(height: 24.h),
                        Text(
                          'app_title'.tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'v$_version',
                          style: GoogleFonts.jetBrainsMono(color: Colors.white38, fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 50.h),

                  // Mission
                  _buildSectionHeader('about.mission.title'.tr(), Icons.auto_awesome),
                  SizedBox(height: 16.h),
                  GlassCard(
                    padding: EdgeInsets.all(20.w),
                    child: Text(
                      'about.mission.desc'.tr(),
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 15.sp,
                        height: 1.6,
                      ),
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0, delay: 200.ms),

                  SizedBox(height: 40.h),

                  // Features Grid
                  _buildSectionHeader('about.features.title'.tr(), Icons.grid_view_rounded),
                  SizedBox(height: 16.h),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 1,
                    mainAxisSpacing: 15.h,
                    childAspectRatio: 2.8,
                    children: [
                      _buildFeatureItem(
                        'about.features.ai_gen'.tr(),
                        'about.features.ai_gen_desc'.tr(),
                        Icons.psychology_rounded,
                        Colors.purpleAccent,
                      ),
                      _buildFeatureItem(
                        'about.features.vault'.tr(),
                        'about.features.vault_desc'.tr(),
                        Icons.auto_stories_rounded,
                        Colors.blueAccent,
                      ),
                      _buildFeatureItem(
                        'about.features.market'.tr(),
                        'about.features.market_desc'.tr(),
                        Icons.hub_rounded,
                        Colors.orangeAccent,
                      ),
                    ],
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0, delay: 400.ms),

                  SizedBox(height: 40.h),

                  // Technical Foundation
                  _buildSectionHeader('about.tech.title'.tr(), Icons.code_rounded),
                  SizedBox(height: 16.h),
                  GlassCard(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'about.tech.stack'.tr(),
                          style: GoogleFonts.cairo(
                            color: Colors.white70,
                            fontSize: 14.sp,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Wrap(
                          spacing: 12.w,
                          runSpacing: 12.h,
                          children: [
                            _techTag('Flutter', Colors.blue),
                            _techTag('Riverpod', Colors.cyan),
                            _techTag('Gemini', Colors.white),
                            _techTag('Groq', Colors.orange),
                            _techTag('Hive', Colors.yellow),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0, delay: 600.ms),

                  SizedBox(height: 40.h),

                  // Developer
                  _buildSectionHeader('about_developer_title'.tr(), Icons.person_pin_rounded),
                  SizedBox(height: 16.h),
                  GlassCard(
                    onTap: () => context.go('/settings/about/developer'),
                    padding: EdgeInsets.all(12.w),
                    child: ListTile(
                      leading: Hero(
                        tag: 'developer_avatar',
                        child: Container(
                          width: 54.w,
                          height: 54.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white10),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/Obada.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        'developer_name'.tr(),
                        style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'about.developer.role'.tr(),
                        style: GoogleFonts.cairo(color: Colors.white38, fontSize: 12.sp),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white10, size: 16),
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0, delay: 800.ms),

                  SizedBox(height: 60.h),

                  // Social / Community
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'about.community.title'.tr(),
                          style: GoogleFonts.cairo(color: Colors.white54, fontSize: 14.sp),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'about.community.desc'.tr(),
                          style: GoogleFonts.cairo(color: Colors.white24, fontSize: 12.sp),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialIcon(Icons.code, () {}),
                            SizedBox(width: 20.w),
                            _socialIcon(Icons.link, () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.purpleAccent, size: 18.sp),
        SizedBox(width: 10.w),
        Text(
          title.toUpperCase(),
          style: GoogleFonts.cairo(
            color: Colors.white38,
            fontSize: 12.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String title, String desc, IconData icon, Color color) {
    return GlassCard(
      padding: EdgeInsets.all(15.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
                Text(
                  desc,
                  style: GoogleFonts.cairo(color: Colors.white38, fontSize: 11.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _techTag(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(color: color, fontSize: 11.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _socialIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Icon(icon, color: Colors.white54, size: 20.sp),
      ),
    );
  }
}
