import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/glass_card.dart';
import '../../../../../core/widgets/cards/social_link_card.dart';
import '../../../../../core/widgets/animations/particle_background.dart';
import '../../../../../core/widgets/animations/staggered_list.dart';
import '../../../../../core/services/haptic_service.dart';
import '../../../../../config/di/injection.dart';

class AboutDeveloperPage extends StatelessWidget {
  const AboutDeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(context.tr('about_developer_title'), style: GoogleFonts.cairo(color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background
          const ParticleBackground(),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: StaggeredList(
                delay: 200.ms,
                children: [
                   // Avatar
                  Center(
                    child: Hero(
                      tag: 'developer_avatar',
                      child: Container(
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.5), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withValues(alpha: 0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/images/Obada.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  // Name and Bio
                  Center(
                    child: Column(
                      children: [
                        Text(
                          context.tr('developer_name'),
                          style: GoogleFonts.cairo(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ).animate(onPlay: (c) => c.repeat(reverse: true))
                         .shimmer(duration: 3.seconds, color: Colors.purpleAccent),
                         
                        SizedBox(height: 8.h),
                        
                        Text(
                          context.tr('developer_title'),
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: Colors.cyanAccent,
                            letterSpacing: 1.2,
                          ),
                        ).animate().fadeIn(duration: 1.seconds).slideX(begin: -0.1, end: 0),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Bio Card
                  GlassCard(
                    padding: EdgeInsets.all(20.w),
                    child: Text(
                      context.tr('developer_bio'),
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        height: 1.6,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Social Links Grid
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 1.1,
                    children: [
                      SocialLinkCard(
                        title: 'GitHub',
                        subtitle: context.tr('social_github'),
                        icon: FontAwesomeIcons.github,
                        url: 'https://github.com/obadadallo95',
                        accentColor: Colors.purpleAccent,
                      ),
                      SocialLinkCard(
                        title: 'LinkedIn',
                        subtitle: context.tr('social_linkedin'),
                        icon: FontAwesomeIcons.linkedin,
                        url: 'https://www.linkedin.com/in/obada-dallo-777a47a9/',
                        accentColor: Colors.blueAccent,
                      ),
                      SocialLinkCard(
                        title: 'Facebook',
                        subtitle: context.tr('social_facebook'),
                        icon: FontAwesomeIcons.facebook,
                        url: 'https://www.facebook.com/obada.dallo33',
                        accentColor: Colors.blue,
                      ),
                      SocialLinkCard(
                        title: 'Telegram',
                        subtitle: context.tr('social_telegram'),
                        icon: FontAwesomeIcons.telegram,
                        url: 'https://t.me/obada_dallo95',
                        accentColor: Colors.cyanAccent,
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),

                   // Contact Section
                  GlassCard(
                    child: Column(
                      children: [
                        Text(
                          context.tr('connect_with_me'),
                          style: GoogleFonts.cairo(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
                             Clipboard.setData(const ClipboardData(text: 'obada.dallo95@gmail.com'));
                             getIt<HapticService>().medium();
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                 content: Text(context.tr('email_copied_success')),
                                 backgroundColor: Colors.purple,
                                 behavior: SnackBarBehavior.floating,
                               ),
                             );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.email_outlined, color: Colors.white70),
                                SizedBox(width: 8.w),
                                Flexible(
                                  child: Text(
                                    'obada.dallo95@gmail.com',
                                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 13.sp), // Slightly smaller font
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                const Icon(Icons.copy, color: Colors.white30, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 40.h),
                  
                  // Footer
                  Center(
                    child: Text(
                      context.tr('made_with_love'),
                      style: GoogleFonts.cairo(color: Colors.white30, fontSize: 12.sp),
                    ),
                  ),
                   SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
