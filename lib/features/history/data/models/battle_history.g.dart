// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BattleHistoryImplAdapter extends TypeAdapter<_$BattleHistoryImpl> {
  @override
  final int typeId = 15;

  @override
  _$BattleHistoryImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$BattleHistoryImpl(
      id: fields[0] as String,
      timestamp: fields[1] as DateTime,
      contestantNames: (fields[2] as List).cast<String>(),
      winner: fields[3] as String,
      actualCost: fields[4] as double,
      scriptTitle: fields[5] as String,
      wasSavedToVault: fields[6] as bool,
      videoPath: fields[7] as String?,
      style: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$BattleHistoryImpl obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.winner)
      ..writeByte(4)
      ..write(obj.actualCost)
      ..writeByte(5)
      ..write(obj.scriptTitle)
      ..writeByte(6)
      ..write(obj.wasSavedToVault)
      ..writeByte(7)
      ..write(obj.videoPath)
      ..writeByte(8)
      ..write(obj.style)
      ..writeByte(2)
      ..write(obj.contestantNames);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BattleHistoryImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BattleHistoryImpl _$$BattleHistoryImplFromJson(Map<String, dynamic> json) =>
    _$BattleHistoryImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      contestantNames: (json['contestantNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      winner: json['winner'] as String,
      actualCost: (json['actualCost'] as num).toDouble(),
      scriptTitle: json['scriptTitle'] as String,
      wasSavedToVault: json['wasSavedToVault'] as bool? ?? false,
      videoPath: json['videoPath'] as String?,
      style: json['style'] as String? ?? 'cinematic',
    );

Map<String, dynamic> _$$BattleHistoryImplToJson(_$BattleHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'contestantNames': instance.contestantNames,
      'winner': instance.winner,
      'actualCost': instance.actualCost,
      'scriptTitle': instance.scriptTitle,
      'wasSavedToVault': instance.wasSavedToVault,
      'videoPath': instance.videoPath,
      'style': instance.style,
    };
