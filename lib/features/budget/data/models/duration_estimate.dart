import 'package:freezed_annotation/freezed_annotation.dart';

part 'duration_estimate.freezed.dart';

@freezed
class DurationEstimate with _$DurationEstimate {
  const factory DurationEstimate({
    required int totalSeconds,
    required Map<String, int> sceneDurations, // "intro": 3, "battle": 4...
    required String formattedDuration, // "0:18"
    required String platformRecommendation, // "Perfect for TikTok"
    required double estimatedFileSizeMB,
  }) = _DurationEstimate;
}
