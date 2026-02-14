import 'package:injectable/injectable.dart';
import '../../data/models/duration_estimate.dart';

@singleton
class DurationCalculator {
  
  DurationEstimate calculate({
    required int sceneCount,
    bool isSlowMotion = false,
  }) {
    // Base timing logic
    const int introDuration = 2;
    const int outroDuration = 2;
    final int battleDuration = isSlowMotion ? 5 : 4;
    
    // Calculate total duration
    // Assumption: 1 Intro, (sceneCount) Battles, 1 Finale/Outro logic
    // But usually sceneCount IS the battle rounds.
    // Let's assume sceneCount includes everything or is just the battles.
    // The user prompt says: "4 contestants = 4 scenes minimum... Intro: 3s, Battle 1: 4s, Battle 2: 4s, Finale: 5s, Outro: 2s = 18s total"
    
    // Replicating user logic:
    // Fixed structure: Intro + Outro + (SceneCount * BattleDuration)
    
    final int totalSeconds = introDuration + (sceneCount * battleDuration) + outroDuration;
    
    // Platform optimization tips
    String recommendation;
    if (totalSeconds < 15) {
      recommendation = "Perfect for YouTube Shorts (Fast & Punchy)";
    } else if (totalSeconds < 30) {
      recommendation = "Golden Length for TikTok (High Retention)";
    } else if (totalSeconds < 60) {
      recommendation = "Good for Reels, but check retention";
    } else {
      recommendation = "Long form? Consider splitting into parts.";
    }
    
    // File size estimation: ~1.5MB per 10s at 1080p (variable bitrate)
    final double estimatedSize = totalSeconds * 0.15; 

    return DurationEstimate(
      totalSeconds: totalSeconds,
      sceneDurations: {
        'intro': introDuration,
        'battles': sceneCount * battleDuration,
        'outro': outroDuration,
      },
      formattedDuration: '${totalSeconds}s',
      platformRecommendation: recommendation,
      estimatedFileSizeMB: estimatedSize,
    );
  }
}
