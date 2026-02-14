import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/battle_script.dart';
import 'scene_model.dart';

part 'battle_script_model.g.dart';

@HiveType(typeId: 2)
class BattleScriptModel extends BattleScript {
  @override
  @HiveField(4)
  final String id;
  @override
  @HiveField(0)
  final String title;
  @override
  @HiveField(1)
  final List<SceneModel> scenes;
  @override
  @HiveField(2)
  final String winner;
  @override
  @HiveField(3)
  final List<String> suggestedHashtags;

  const BattleScriptModel({
    required this.id,
    required this.title,
    required this.scenes,
    required this.winner,
    required this.suggestedHashtags,
  }) : super();

  factory BattleScriptModel.fromJson(Map<String, dynamic> json) {
    return BattleScriptModel(
      id: json['id'] as String? ?? const Uuid().v4(),
      title: json['title'] as String,
      scenes: (json['scenes'] as List)
          .map((e) => SceneModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      winner: json['winner'] as String,
      suggestedHashtags: (json['suggested_hashtags'] as List).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'scenes': scenes.map((e) => e.toJson()).toList(),
      'winner': winner,
      'suggested_hashtags': suggestedHashtags,
    };
  }

  factory BattleScriptModel.fromEntity(BattleScript script) {
    return BattleScriptModel(
      id: script.id,
      title: script.title,
      scenes: script.scenes.map((e) => SceneModel.fromEntity(e)).toList(),
      winner: script.winner,
      suggestedHashtags: script.suggestedHashtags,
    );
  }
}
