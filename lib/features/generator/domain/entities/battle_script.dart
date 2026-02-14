// Lines: 25/300
import 'package:equatable/equatable.dart';
import 'scene.dart';

abstract class BattleScript extends Equatable {
  String get id;
  String get title;
  List<Scene> get scenes;
  String get winner;
  List<String> get suggestedHashtags;

  const BattleScript();

  @override
  List<Object?> get props => [title, scenes, winner, suggestedHashtags];
}
