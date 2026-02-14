import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';
import 'package:asmr_battle_factory/core/utils/responsive_extensions.dart';

import 'providers/generator_provider.dart';
import 'widgets/particle_background.dart';
import 'widgets/contestant_selector.dart';
import 'widgets/generator_states.dart';
import 'widgets/generator_dialogs.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../budget/presentation/widgets/budget_mode_selector.dart';
import '../../budget/presentation/widgets/cost_estimator_card.dart';
import '../../budget/presentation/providers/budget_provider.dart';
import '../../marketplace/presentation/widgets/recommendation_chip.dart';
// Config
import '../../configurator/presentation/providers/battle_config_provider.dart';
import '../../configurator/domain/entities/battle_config.dart';
import '../../configurator/presentation/widgets/configuration_panel.dart';
import '../../configurator/presentation/widgets/idea_generator_dialog.dart';

class GeneratorPage extends ConsumerWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generatorProvider);
    final generatorNotifier = ref.read(generatorProvider.notifier);
    
    // Config State
    final battleConfig = ref.watch(battleConfigProvider);
    final configNotifier = ref.read(battleConfigProvider.notifier);
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const ParticleBackground(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05.gw),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _buildBody(
                    context, 
                    state, 
                    generatorNotifier, 
                    battleConfig, 
                    configNotifier, 
                    ref
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, 
      GeneratorState state, 
      GeneratorNotifier generatorNotifier,
      BattleConfig config,
      BattleConfigNotifier configNotifier,
      WidgetRef ref) {
      
    if (state is GeneratorInitial) {
      return SingleChildScrollView(
        key: const ValueKey('Input'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 0.g),
            Text(
              "generator.assemble_title".tr(),
              textAlign: TextAlign.center,
              style: GoogleFonts.jetBrainsMono(
                color: Colors.white,
                fontSize: 2.t,
                letterSpacing: 2,
              ),
            ).animate().fadeIn().slideY(begin: -0.5),
            
            SizedBox(height: 0.g),
            const BudgetModeSelector(),
            SizedBox(height: 0.g),
            
            // Remove Expanded when inside SingleChildScrollView
            ContestantSelector(
              contestants: config.contestants,
              onReorder: configNotifier.reorderContestants,
              onUpdate: configNotifier.updateContestant,
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
            
            SizedBox(height: 1.g),
            const ConfigurationPanel(),
            SizedBox(height: 0.g),
            const RecommendationChip(),
            SizedBox(height: 0.g),
            CostEstimatorCard(sceneCount: config.contestants.length),
            SizedBox(height: 1.g),
            
            // Ideas Generator Button
            TextButton.icon(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => const IdeaGeneratorDialog(),
              ),
              icon: const Icon(Icons.auto_awesome, color: Colors.amber),
              label: Text(
                'idea_generator.button'.tr(),
                style: GoogleFonts.cairo(color: Colors.amber, fontSize: 1.t),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber.withValues(alpha: 0.1),
                padding: context.gSymmetricPadding(horizontal: Factor.sm, vertical: Factor.xs),
              ),
            ).animate().fadeIn(delay: 600.ms).shimmer(delay: 800.ms, duration: 1.seconds),
            SizedBox(height: 1.g),
            
            PrimaryButton(
              text: "generator.initiate_btn".tr(),
              onPressed: () {
                 final estimate = ref.read(costEstimateProvider(config.contestants.length));
                 if (estimate.totalCostUSD > 2.0) {
                   GeneratorDialogs.showCostWarningDialog(context, estimate, () {
                      generatorNotifier.generateBattle(config);
                   });
                 } else {
                   generatorNotifier.generateBattle(config);
                 }
              },
            ).animate(onPlay: (c) => c.repeat(reverse: true))
             .boxShadow(begin: const BoxShadow(color: Colors.purple, blurRadius: 10), end: const BoxShadow(color: Colors.purple, blurRadius: 20))
             .animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),
            
            SizedBox(height: 1.g),
  
            // Domino Mode Button
            Center(
              child: TextButton.icon(
                onPressed: () => GeneratorDialogs.showDominoDialog(context, generatorNotifier),
                icon: const Icon(Icons.copy_all, color: Colors.cyanAccent),
                label: Text(
                  "generator.domino.btn".tr(),
                  style: GoogleFonts.jetBrainsMono(color: Colors.cyanAccent, letterSpacing: 1),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.cyanAccent.withValues(alpha: 0.1),
                  padding: context.gSymmetricPadding(horizontal: Factor.sm, vertical: Factor.xs),
                ),
              ),
            ).animate().fadeIn(delay: 1000.ms),
            
            SizedBox(height: 1.g),
          ],
        ),
      );
    }
 // ... rest of states (Loading, Success, etc.)
    else if (state is GeneratorLoading) {
      return GeneratorLoadingView(state: state);
    } else if (state is GeneratorDominoRunning) {
       return GeneratorDominoRunningView(state: state);
    } else if (state is GeneratorDominoSuccess) {
      return GeneratorDominoSuccessView(state: state, onReset: generatorNotifier.reset);
    } else if (state is GeneratorSuccess) {
      return GeneratorSuccessView(state: state, onReset: generatorNotifier.reset);
    } else if (state is GeneratorError) {
      return Center(
        child: ErrorView(
          message: state.message,
          onRetry: generatorNotifier.reset,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
