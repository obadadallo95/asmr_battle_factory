import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../projects/presentation/providers/projects_provider.dart';
import '../../../projects/data/models/battle_project.dart';
import 'generation_progress_page.dart';

final wizardStepProvider = StateProvider<int>((ref) => 0);
final selectedProjectForGenProvider = StateProvider<BattleProject?>((ref) => null);

class GenerationWizard extends ConsumerWidget {
  const GenerationWizard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = ref.watch(wizardStepProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      appBar: _buildAppBar(context, ref, step),
      body: Column(
        children: [
          _buildStepIndicator(step),
          Expanded(
            child: _buildStepContent(step, ref),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, WidgetRef ref, int step) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'معالج الإنتاج الذكي',
        style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          if (step > 0) {
            ref.read(wizardStepProvider.notifier).state = step - 1;
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget _buildStepIndicator(int currentStep) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
      child: Row(
        children: List.generate(3, (index) => Expanded(
          child: Row(
            children: [
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: index <= currentStep ? Colors.purpleAccent : Colors.white10,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: index < currentStep 
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : Text('${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              if (index < 2) Expanded(
                child: Container(
                  height: 2,
                  color: index < currentStep ? Colors.purpleAccent : Colors.white10,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildStepContent(int step, WidgetRef ref) {
    switch (step) {
      case 0: return _buildStep1(ref);
      case 1: return _buildStep2(ref);
      case 2: return _buildStep3(ref);
      default: return _buildStep1(ref);
    }
  }

  Widget _buildStep1(WidgetRef ref) {
    final projects = ref.watch(projectsProvider);
    return Padding(
      padding: EdgeInsets.all(30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اختر مشروعاً للبدء',
            style: GoogleFonts.cairo(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                childAspectRatio: 1.2,
              ),
              itemCount: projects.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return _buildNewGenCard(ref);
                final project = projects[index - 1];
                return _buildProjectOption(ref, project);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewGenCard(WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(selectedProjectForGenProvider.notifier).state = null;
        ref.read(wizardStepProvider.notifier).state = 1;
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.3), width: 2),
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.purpleAccent.withValues(alpha: 0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline, color: Colors.purpleAccent, size: 40),
            SizedBox(height: 10.h),
            Text('توليد جديد', style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectOption(WidgetRef ref, BattleProject project) {
    return InkWell(
      onTap: () {
        ref.read(selectedProjectForGenProvider.notifier).state = project;
        ref.read(wizardStepProvider.notifier).state = 1;
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_filter_outlined, color: Colors.white38, size: 30.sp),
            SizedBox(height: 10.h),
            Text(project.nameAr, style: GoogleFonts.cairo(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2(WidgetRef ref) {
    final project = ref.watch(selectedProjectForGenProvider);
    return Padding(
      padding: EdgeInsets.all(40.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30.w),
            decoration: BoxDecoration(
              color: const Color(0xFF161625),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              children: [
                Text('تأكيد تفاصيل الإنتاج', style: GoogleFonts.cairo(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 30.h),
                _summaryRow('المشروع', project?.nameAr ?? 'توليد مخصص'),
                _summaryRow('المتنافسون', project?.contestants.join(' vs ') ?? 'نمل vs نحل'),
                _summaryRow('وضع الميزانية', project?.budgetMode.name.toUpperCase() ?? 'ECONOMY'),
                const Divider(color: Colors.white10, height: 40),
                _summaryRow('التكلفة التقديرية', '\$3.82', isBold: true, color: Colors.greenAccent),
                _summaryRow('الجودة المتوقعة', 'Cinematic High', isBold: true, color: Colors.purpleAccent),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 60.h,
            child: ElevatedButton(
              onPressed: () => ref.read(wizardStepProvider.notifier).state = 2,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              ),
              child: Text('بدأ الإنتاج الآن ⚡', style: GoogleFonts.cairo(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ).animate().fadeIn(),
    );
  }

  Widget _summaryRow(String label, String val, {bool isBold = false, Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.cairo(color: Colors.white38, fontSize: 14.sp)),
          Text(val, style: GoogleFonts.cairo(
            color: color ?? Colors.white, 
            fontSize: 14.sp, 
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          )),
        ],
      ),
    );
  }

  Widget _buildStep3(WidgetRef ref) {
    return const GenerationProgressPage();
  }
}
