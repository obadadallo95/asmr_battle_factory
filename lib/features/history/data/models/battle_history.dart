import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'battle_history.freezed.dart';
part 'battle_history.g.dart';

@freezed
class BattleHistory with _$BattleHistory {
  @HiveType(typeId: 15)
  const factory BattleHistory({
    @HiveField(0) required String id,
    @HiveField(1) required DateTime timestamp,
    @HiveField(2) required List<String> contestantNames,
    @HiveField(3) required String winner,
    @HiveField(4) required double actualCost,
    @HiveField(5) required String scriptTitle,
    @HiveField(6) @Default(false) bool wasSavedToVault,
    @HiveField(7) String? videoPath,
    @HiveField(8) @Default('cinematic') String style,
  }) = _BattleHistory;

  factory BattleHistory.fromJson(Map<String, dynamic> json) =>
      _$BattleHistoryFromJson(json);
}
