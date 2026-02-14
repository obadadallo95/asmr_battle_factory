// Lines: 20/300
import 'package:equatable/equatable.dart';

abstract class Scene extends Equatable {
  String get title;
  String get description;
  String get imagePrompt;
  String get motionDescription;
  String get audioCue;
  double get duration;

  const Scene();

  @override
  List<Object?> get props => [title, description, imagePrompt, motionDescription, audioCue, duration];
}
