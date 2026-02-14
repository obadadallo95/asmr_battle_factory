import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../glass_card.dart';
import '../../services/haptic_service.dart';
import '../../../../config/di/injection.dart';

class SocialLinkCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String url;
  final Color accentColor;
  final VoidCallback? onTap;

  const SocialLinkCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.url,
    required this.accentColor,
    this.onTap,
    super.key,
  });

  @override
  State<SocialLinkCard> createState() => _SocialLinkCardState();
}

class _SocialLinkCardState extends State<SocialLinkCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $uri';
      }
      getIt<HapticService>().medium();
    } catch (e) {
      getIt<HapticService>().error();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('common.launch_error'.tr(args: [widget.url]))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _launchUrl();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : (_isHovered ? 1.02 : 1.0),
          duration: 200.ms,
          child: GlassCard(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: widget.accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.accentColor.withValues(alpha: 0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.accentColor,
                    size: 24.sp,
                  ),
                ).animate(target: _isHovered ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
                
                SizedBox(height: 8.h),
                
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      widget.title,
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                ),
                
                SizedBox(height: 2.h),
                
                Flexible(
                  child: Text(
                    widget.subtitle,
                    style: GoogleFonts.cairo(
                      color: Colors.white70,
                      fontSize: 10.sp,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
