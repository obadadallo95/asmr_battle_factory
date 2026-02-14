import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:asmr_battle_factory/features/budget/domain/models/budget_mode.dart';

part 'battle_project.freezed.dart';
part 'battle_project.g.dart';

@freezed
class BattleProject with _$BattleProject {
  @HiveType(typeId: 10)
  const factory BattleProject({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String nameAr,
    @HiveField(3) required String description,
    @HiveField(4) required DateTime createdAt,
    @HiveField(5) required DateTime lastUsed,
    
    // Configuration
    @HiveField(6) required List<String> contestants,
    @HiveField(7) @Default('nature') String theme,
    
    // AI Mix (The Providers)
    @HiveField(8) required ProviderMix providerMix,
    
    // Settings
    @HiveField(9) required VideoSettings videoSettings,
    @HiveField(10) required BudgetMode budgetMode,
    
    // Stats
    @HiveField(11) @Default(0) int generationCount,
    @HiveField(12) @Default(0.0) double totalSpent,
    @HiveField(13) @Default(0.0) double averageQuality,
    @HiveField(14) String? thumbnailPath,
    @HiveField(15) @Default([]) List<String> tags,
  }) = _BattleProject;

  factory BattleProject.fromJson(Map<String, dynamic> json) =>
      _$BattleProjectFromJson(json);
}

@freezed
class ProviderMix with _$ProviderMix {
  @HiveType(typeId: 11)
  const factory ProviderMix({
    @HiveField(0) String? ideaProvider,
    @HiveField(1) String? scriptProvider,
    @HiveField(2) String? imageProvider,
    @HiveField(3) String? videoProvider,
    @HiveField(4) @Default(true) bool useSmartRouting,
  }) = _ProviderMix;

  factory ProviderMix.fromJson(Map<String, dynamic> json) =>
      _$ProviderMixFromJson(json);
}

@freezed
class VideoSettings with _$VideoSettings {
  @HiveType(typeId: 12)
  const factory VideoSettings({
    @HiveField(0) @Default('16:9') String aspectRatio,
    @HiveField(1) @Default('1080p') String resolution,
    @HiveField(2) @Default(24) int fps,
    @HiveField(3) @Default(false) bool slowMotion,
    @HiveField(4) @Default(true) bool includeVoiceover,
    @HiveField(5) @Default('cinematic') String style,
  }) = _VideoSettings;

  factory VideoSettings.fromJson(Map<String, dynamic> json) =>
      _$VideoSettingsFromJson(json);
}
