// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SceneModelAdapter extends TypeAdapter<SceneModel> {
  @override
  final int typeId = 1;

  @override
  SceneModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SceneModel(
      title: fields[3] as String,
      description: fields[0] as String,
      imagePrompt: fields[1] as String,
      motionDescription: fields[2] as String,
      audioCue: fields[4] as String,
      duration: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SceneModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.imagePrompt)
      ..writeByte(2)
      ..write(obj.motionDescription)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.audioCue)
      ..writeByte(5)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SceneModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
