import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';


import '../../../../core/theme/golden_ratio.dart';
import '../../../../core/utils/responsive_extensions.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../generator/data/repositories/generator_repository_impl.dart';
import '../../../generator/domain/repositories/generator_repository.dart';
import '../../../../config/di/injection.dart';
import '../providers/battle_config_provider.dart';

class IdeaGeneratorDialog extends ConsumerStatefulWidget {
  const IdeaGeneratorDialog({super.key});

  @override
  ConsumerState<IdeaGeneratorDialog> createState() => _IdeaGeneratorDialogState();
}

class _IdeaGeneratorDialogState extends ConsumerState<IdeaGeneratorDialog> {
  bool isLoading = false;
  List<String>? ideas;
  String? error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: context.gBorderRadius(Factor.md),
      ),
      title: Row(
        children: [
          Icon(Icons.auto_awesome, color: Colors.amber, size: 3.t),
          SizedBox(width: 1.g),
          Text(
            'idea_generator.title'.tr(),
            style: GoogleFonts.cairo(
              fontSize: 3.t,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: ScreenUtil().screenWidth * 0.8,
        height: ScreenUtil().screenHeight * 0.5,
        child: isLoading
            ? _buildLoadingState()
            : ideas == null
                ? _buildInitialState()
                : _buildIdeasList(),
      ),
      actions: error != null
          ? [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('close'.tr()),
              ),
            ]
          : null,
    );
  }

  Widget _buildInitialState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lightbulb,
          size: 8.t,
          color: Colors.amber,
        ).animate().shimmer(duration: 2.seconds).then().shimmer(duration: 2.seconds, delay: 1.seconds),
        
        SizedBox(height: 2.g),
        
        Text(
          'idea_generator.desc'.tr(),
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 2.t,
            color: Colors.white70,
          ),
        ),
        
        SizedBox(height: 1.g),
        
        Container(
          padding: context.gPadding(Factor.sm),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.1),
            borderRadius: context.gBorderRadius(Factor.sm),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.attach_money, color: Colors.amber, size: 2.t),
              Text(
                'idea_generator.cost'.tr(namedArgs: {'cost': '0.001'}),
                style: TextStyle(
                  fontSize: 1.t,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: 3.g),
        
        PrimaryButton(
          text: 'idea_generator.generate'.tr(),
          onPressed: _generateIdeas,
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
        ),
        SizedBox(height: 2.g),
        Text(
          'idea_generator.loading'.tr(),
          style: GoogleFonts.cairo(
            fontSize: 2.t,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildIdeasList() {
    if (ideas == null || ideas!.isEmpty) {
      return Center(
        child: Text(
          error ?? 'idea_generator.no_ideas'.tr(),
          style: TextStyle(color: Colors.red, fontSize: 2.t),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: ideas!.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(bottom: 1.g),
                color: Colors.white.withValues(alpha: 0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: context.gBorderRadius(Factor.sm),
                  side: BorderSide(color: Colors.white12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber.withValues(alpha: 0.2),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 2.t,
                      ),
                    ),
                  ),
                  title: Text(
                    ideas![index],
                    style: GoogleFonts.cairo(
                      fontSize: 2.t,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 1.t,
                    color: Colors.white38,
                  ),
                  onTap: () => _applyIdea(ideas![index]),
                ),
              ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: -0.2, end: 0);
            },
          ),
        ),
        
        SizedBox(height: 1.g),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: _generateIdeas,
              icon: Icon(Icons.refresh, color: Colors.amber),
              label: Text(
                'idea_generator.regenerate'.tr(),
                style: TextStyle(color: Colors.amber, fontSize: 1.t),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'close'.tr(),
                style: TextStyle(fontSize: 1.t),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _generateIdeas() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final repository = getIt<GeneratorRepository>();
      final result = await repository.generateBattleIdeas();

      result.fold(
        (failure) {
          setState(() {
            isLoading = false;
            error = failure.message;
          });
        },
        (generatedIdeas) {
          setState(() {
            isLoading = false;
            ideas = generatedIdeas;
          });
        },
      );
    } catch (e) {
      setState(() {
        isLoading = false;
        error = e.toString();
      });
    }
  }

  Future<void> _applyIdea(String idea) async {
    try {
      await ref.read(battleConfigProvider.notifier).applyIdea(idea);
      
      if (!mounted) return;
      
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('idea_applied'.tr()),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('error_applying_idea'.tr()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
