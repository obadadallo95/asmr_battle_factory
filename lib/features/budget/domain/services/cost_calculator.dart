import 'package:injectable/injectable.dart';
import '../../data/models/cost_estimate.dart';
import '../../domain/models/budget_mode.dart';
import 'duration_calculator.dart';
import '../../../marketplace/domain/repositories/provider_repository.dart';
import '../../../marketplace/domain/entities/provider_catalog_entry.dart';

@singleton
class CostCalculator {
  final DurationCalculator _durationCalculator;
  final IProviderRepository _db;

  CostCalculator(this._durationCalculator, this._db);

  CostEstimate calculate({
    required BudgetMode mode,
    required int sceneCount,
    bool includeVoiceover = true,
    bool isSlowMotion = false,
  }) {
    // 1. Duration & Stack
    final duration = _durationCalculator.calculate(
      sceneCount: sceneCount,
      isSlowMotion: isSlowMotion,
    );
    final stack = mode.recommendedStack;

    // Helper to calculate cost from dynamic entry
    double getComponentCost(String? id, {int count = 1, bool isToken = false, int inTokens = 1000, int outTokens = 1000}) {
      if (id == null) return 0.0;
      final entry = _db.getById(id);
      if (entry == null) return 0.0;
      if (entry.tier == ProviderTier.free) return 0.0;

      final costIn = entry.costPerInputUnit ?? 0.0;
      final costOut = entry.costPerOutputUnit ?? 0.0;
      final unit = entry.unitQuantity;

      if (isToken) {
        return (inTokens / unit * costIn) + (outTokens / unit * costOut);
      }
      
      // For images/video seconds
      return count * costIn;
    }

    // 2. Calculate Components
    
    // A. Text (Idea + Script)
    final ideaCost = getComponentCost(stack.ideaProvider, isToken: true, inTokens: 500, outTokens: 100);
    final scriptCost = getComponentCost(stack.scriptProvider, isToken: true, inTokens: 1000, outTokens: 1000);

    // B. Images
    final imageCost = getComponentCost(stack.imageProvider, count: sceneCount);

    // C. Video
    final videoCost = getComponentCost(stack.videoProvider, count: duration.totalSeconds.toInt());

    // D. Audio
    double audioCost = 0.0;
    if (includeVoiceover) {
      // ElevenLabs is currently hardcoded in suggestions, let's use catalog
      audioCost = getComponentCost('elevenlabs', count: sceneCount * 150); // 150 chars per scene
    }

    final total = ideaCost + scriptCost + imageCost + videoCost + audioCost;

    // 3. Risk Analysis
    String risk = 'Low';
    if (total > 5.0) {
      risk = 'High';
    } else if (total > 2.0) {
      risk = 'Medium';
    }

    // 4. Optimization Suggestions
    List<String> suggestions = [];
    if (ideaCost > 0.01 && stack.ideaProvider == 'openai') {
       suggestions.add("استخدم Groq لتوليد الأفكار (وفر \$${ideaCost.toStringAsFixed(3)})");
    }
    if (videoCost > 2.0) {
       suggestions.add("انتقل إلى الوضع الاقتصادي (صور فقط) لتوفير \$${videoCost.toStringAsFixed(2)}");
    }

    return CostEstimate(
      totalCostUSD: total,
      totalDurationSeconds: duration.totalSeconds.toDouble(),
      breakdown: CostBreakdown(
        ideaGeneration: ideaCost,
        scriptWriting: scriptCost,
        imageGeneration: imageCost,
        videoGeneration: videoCost,
        audioGeneration: audioCost,
      ),
      apiStack: stack,
      riskLevel: risk,
      mode: mode,
      optimizationSuggestions: suggestions,
    );
  }
}
