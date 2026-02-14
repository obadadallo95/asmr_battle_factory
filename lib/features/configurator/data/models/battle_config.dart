import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'battle_config.freezed.dart';
part 'battle_config.g.dart';

@HiveType(typeId: 22)
enum WinnerMode {
  @HiveField(0) aiDecided,
  @HiveField(1) random,
  @HiveField(2) userSelected,
  @HiveField(3) scriptBased,
}

@HiveType(typeId: 23)
enum BattleType {
  @HiveField(0) tournament,      // 4 -> 2 -> 1
  @HiveField(1) battleRoyale,    // All vs All
  @HiveField(2) revengeSeries,   // Loser comes back
}

@freezed
class BattleConfig with _$BattleConfig {
  @HiveType(typeId: 24)
  const factory BattleConfig({
    @HiveField(0) required String id,
    @HiveField(1) required List<String> selectedContestantIds,
    @HiveField(2) @Default(WinnerMode.aiDecided) WinnerMode winnerMode,
    @HiveField(3) String? userSelectedWinnerId,
    @HiveField(4) @Default(BattleType.battleRoyale) BattleType battleType,
    @HiveField(5) @Default(0.5) double chaosLevel, // 0.0 - 1.0
    @HiveField(6) DateTime? createdAt,
  }) = _BattleConfig;

  factory BattleConfig.fromJson(Map<String, dynamic> json) => _$BattleConfigFromJson(json);
}
