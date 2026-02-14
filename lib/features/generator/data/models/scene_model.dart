// Lines: 35/300
import 'package:hive/hive.dart';
import '../../domain/entities/scene.dart';

part 'scene_model.g.dart';

@HiveType(typeId: 1)
class SceneModel extends Scene {
  @override
  @HiveField(0)
  final String description;
  @override
  @HiveField(1)
  final String imagePrompt;
  @override
  @HiveField(2)
  final String motionDescription;
  @override
  @HiveField(3)
  final String title;
  @override
  @HiveField(4)
  final String audioCue;
  @override
  @HiveField(5)
  final double duration;

  const SceneModel({
    required this.title,
    required this.description,
    required this.imagePrompt,
    required this.motionDescription,
    required this.audioCue,
    required this.duration,
  }) : super();

  factory SceneModel.fromJson(Map<String, dynamic> json) {
    return SceneModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? (json['visual_description'] as String? ?? ''),
      imagePrompt: json['image_prompt'] as String? ?? (json['visual_description'] as String? ?? ''),
      motionDescription: json['motion_description'] as String? ?? (json['motion_prompt'] as String? ?? ''),
      audioCue: json['audio_cue'] as String? ?? '',
      duration: (json['duration_seconds'] as num?)?.toDouble() ?? 5.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image_prompt': imagePrompt,
      'motion_description': motionDescription,
      'audio_cue': audioCue,
      'duration_seconds': duration,
    };
  }

  factory SceneModel.fromEntity(Scene scene) {
    return SceneModel(
      title: scene.title,
      description: scene.description,
      imagePrompt: scene.imagePrompt,
      motionDescription: scene.motionDescription,
      audioCue: scene.audioCue,
      duration: scene.duration,
    );
  }
}
