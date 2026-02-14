import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'saved_scenario.freezed.dart';
part 'saved_scenario.g.dart';

@freezed
class SavedScenario with _$SavedScenario {
  @HiveType(typeId: 25)
  const factory SavedScenario({
    @HiveField(0) required String id,
    @HiveField(1) required String titleAr,
    @HiveField(2) required String titleEn,
    @HiveField(3) required String briefDescriptionAr,
    @HiveField(4) required String briefDescriptionEn,
    @HiveField(5) required List<String> contestantIds,
    @HiveField(6) required DateTime savedAt,
    @HiveField(7) String? suggestedWinnerId,
    @HiveField(8) @Default(5) int twistLevel, // 1-10
    @HiveField(9) String? providerUsed,
  }) = _SavedScenario;

  factory SavedScenario.fromJson(Map<String, dynamic> json) => _$SavedScenarioFromJson(json);
}
