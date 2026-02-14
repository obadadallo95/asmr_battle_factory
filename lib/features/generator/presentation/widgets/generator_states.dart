import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/generator_provider.dart';
import 'generation_progress.dart';
import 'director_view.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/primary_button.dart';

class GeneratorLoadingView extends StatelessWidget {
  final GeneratorLoading state;

  const GeneratorLoadingView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('Loading'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GenerationProgress(currentStep: state.currentStep),
        SizedBox(height: 40.h),
        DirectorView(logs: state.logs),
        SizedBox(height: 40.h),
        Text(
          "generator.loading_label".tr(),
          style: GoogleFonts.jetBrainsMono(color: Colors.white70),
        ).animate(onPlay: (c) => c.repeat()).shimmer(),
      ],
    );
  }
}

class GeneratorDominoRunningView extends StatelessWidget {
  final GeneratorDominoRunning state;

  const GeneratorDominoRunningView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('DominoRunning'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "generator.domino.active".tr(),
          style: GoogleFonts.jetBrainsMono(color: Colors.cyanAccent, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ).animate(onPlay: (c) => c.repeat()).shimmer(),
        SizedBox(height: 20.h),
        LinearProgressIndicator(
          value: state.current / state.total,
          backgroundColor: Colors.white12,
          color: Colors.cyanAccent,
          minHeight: 10.h,
          borderRadius: BorderRadius.circular(5.r),
        ),
        SizedBox(height: 10.h),
        Text(
          "generator.domino.progress".tr(args: [state.current.toString(), state.total.toString()]),
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
        SizedBox(height: 30.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.white10),
          ),
          child: Text(
            state.log,
            style: GoogleFonts.sourceCodePro(color: Colors.greenAccent, fontSize: 12.sp),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20.h),
        Expanded(
          child: ListView.builder(
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              final script = state.results[index];
              return ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green, size: 16.sp),
                title: Text(script.title, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                dense: true,
              );
            },
          ),
        ),
      ],
    );
  }
}

class GeneratorDominoSuccessView extends StatelessWidget {
  final GeneratorDominoSuccess state;
  final VoidCallback onReset;

  const GeneratorDominoSuccessView({super.key, required this.state, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('DominoSuccess'),
      children: [
        SizedBox(height: 20.h),
        Text(
          "generator.domino.report".tr(),
          style: GoogleFonts.jetBrainsMono(color: Colors.greenAccent, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        Text(
          "generator.domino.battles_count".tr(args: [state.results.length.toString()]),
          style: const TextStyle(color: Colors.white70),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.8,
            ),
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              final script = state.results[index];
              return GlassCard(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.movie_creation_outlined, color: Colors.purpleAccent, size: 30.sp),
                    SizedBox(height: 10.h),
                    Text(
                      script.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "generator.domino.scenes_count".tr(args: [script.scenes.length.toString()]),
                      style: TextStyle(color: Colors.white54, fontSize: 10.sp),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        PrimaryButton(text: "common.back_to_studio".tr(), onPressed: onReset),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class GeneratorSuccessView extends StatelessWidget {
  final GeneratorSuccess state;
  final VoidCallback onReset;

  const GeneratorSuccessView({super.key, required this.state, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const ValueKey('Success'),
      child: GlassCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.greenAccent, size: 60.sp)
                .animate().scale(duration: 400.ms),
            SizedBox(height: 20.h),
            Text(
              state.script.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                itemCount: state.script.scenes.length,
                itemBuilder: (context, index) {
                  final scene = state.script.scenes[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scene.title.isNotEmpty ? scene.title : 'generator.success.scene_label'.tr(args: [(index + 1).toString()]),
                          style: GoogleFonts.cairo(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          scene.description,
                          style: GoogleFonts.cairo(
                            fontSize: 16.sp,
                            color: Colors.white,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Divider(color: Colors.white12, height: 24.h),
                        if (scene.audioCue.isNotEmpty) ...[
                          Row(
                            children: [
                              Icon(Icons.audiotrack, size: 12.sp, color: Colors.pinkAccent),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  'generator.success.audio_cue'.tr(args: [scene.audioCue]),
                                  style: TextStyle(fontSize: 12.sp, color: Colors.pinkAccent.withValues(alpha: 0.7)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                        ],
                        Text(
                          '🎥 ${scene.motionDescription}',
                          style: TextStyle(fontSize: 12.sp, color: Colors.white30),
                        ),
                        Text(
                          '⏱️ ${scene.duration}s',
                          style: TextStyle(fontSize: 12.sp, color: Colors.white30),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              text: "generator.success.another_btn".tr(),
              onPressed: onReset,
            ),
          ],
        ),
      ),
    );
  }
}
