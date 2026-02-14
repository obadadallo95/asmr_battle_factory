// Lines: 80/100
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'glass_card.dart';

class LegalDocumentViewer extends StatelessWidget {
  final String title;
  final String content;

  const LegalDocumentViewer({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(title, style: GoogleFonts.cairo()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              context.go('/app/settings');
            }
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0A0F), Color(0xFF1A1025)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: GlassCard(
              child: Markdown(
                data: content,
                shrinkWrap: false,
                styleSheet: MarkdownStyleSheet(
                  p: GoogleFonts.cairo(color: Colors.white.withValues(alpha: 0.9), fontSize: 14.sp),
                  h1: GoogleFonts.cairo(color: const Color(0xFF8B5CF6), fontSize: 24.sp, fontWeight: FontWeight.bold),
                  h2: GoogleFonts.cairo(color: const Color(0xFF06B6D4), fontSize: 20.sp, fontWeight: FontWeight.bold),
                  h3: GoogleFonts.cairo(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
                  listBullet: TextStyle(color: const Color(0xFF8B5CF6), fontSize: 16.sp),
                  blockSpacing: 16.h,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                selectable: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
