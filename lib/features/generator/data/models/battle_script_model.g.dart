// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_script_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BattleScriptModelAdapter extends TypeAdapter<BattleScriptModel> {
  @override
  final int typeId = 2;

  @override
  BattleScriptModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BattleScriptModel(
      id: fields[4] as String,
      title: fields[0] as String,
      scenes: (fields[1] as List).cast<SceneModel>(),
      winner: fields[2] as String,
      suggestedHashtags: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BattleScriptModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.scenes)
      ..writeByte(2)
      ..write(obj.winner)
      ..writeByte(3)
      ..write(obj.suggestedHashtags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BattleScriptModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
