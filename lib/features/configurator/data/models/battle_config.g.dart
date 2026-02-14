// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WinnerModeAdapter extends TypeAdapter<WinnerMode> {
  @override
  final int typeId = 22;

  @override
  WinnerMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WinnerMode.aiDecided;
      case 1:
        return WinnerMode.random;
      case 2:
        return WinnerMode.userSelected;
      case 3:
        return WinnerMode.scriptBased;
      default:
        return WinnerMode.aiDecided;
    }
  }

  @override
  void write(BinaryWriter writer, WinnerMode obj) {
    switch (obj) {
      case WinnerMode.aiDecided:
        writer.writeByte(0);
        break;
      case WinnerMode.random:
        writer.writeByte(1);
        break;
      case WinnerMode.userSelected:
        writer.writeByte(2);
        break;
      case WinnerMode.scriptBased:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WinnerModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BattleTypeAdapter extends TypeAdapter<BattleType> {
  @override
  final int typeId = 23;

  @override
  BattleType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BattleType.tournament;
      case 1:
        return BattleType.battleRoyale;
      case 2:
        return BattleType.revengeSeries;
      default:
        return BattleType.tournament;
    }
  }

  @override
  void write(BinaryWriter writer, BattleType obj) {
    switch (obj) {
      case BattleType.tournament:
        writer.writeByte(0);
        break;
      case BattleType.battleRoyale:
        writer.writeByte(1);
        break;
      case BattleType.revengeSeries:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BattleTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BattleConfigImplAdapter extends TypeAdapter<_$BattleConfigImpl> {
  @override
  final int typeId = 24;

  @override
  _$BattleConfigImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$BattleConfigImpl(
      id: fields[0] as String,
      selectedContestantIds: (fields[1] as List).cast<String>(),
      winnerMode: fields[2] as WinnerMode,
      userSelectedWinnerId: fields[3] as String?,
      battleType: fields[4] as BattleType,
      chaosLevel: fields[5] as double,
      createdAt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, _$BattleConfigImpl obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.winnerMode)
      ..writeByte(3)
      ..write(obj.userSelectedWinnerId)
      ..writeByte(4)
      ..write(obj.battleType)
      ..writeByte(5)
      ..write(obj.chaosLevel)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.selectedContestantIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BattleConfigImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BattleConfigImpl _$$BattleConfigImplFromJson(Map<String, dynamic> json) =>
    _$BattleConfigImpl(
      id: json['id'] as String,
      selectedContestantIds: (json['selectedContestantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      winnerMode:
          $enumDecodeNullable(_$WinnerModeEnumMap, json['winnerMode']) ??
              WinnerMode.aiDecided,
      userSelectedWinnerId: json['userSelectedWinnerId'] as String?,
      battleType:
          $enumDecodeNullable(_$BattleTypeEnumMap, json['battleType']) ??
              BattleType.battleRoyale,
      chaosLevel: (json['chaosLevel'] as num?)?.toDouble() ?? 0.5,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$BattleConfigImplToJson(_$BattleConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'selectedContestantIds': instance.selectedContestantIds,
      'winnerMode': _$WinnerModeEnumMap[instance.winnerMode]!,
      'userSelectedWinnerId': instance.userSelectedWinnerId,
      'battleType': _$BattleTypeEnumMap[instance.battleType]!,
      'chaosLevel': instance.chaosLevel,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$WinnerModeEnumMap = {
  WinnerMode.aiDecided: 'aiDecided',
  WinnerMode.random: 'random',
  WinnerMode.userSelected: 'userSelected',
  WinnerMode.scriptBased: 'scriptBased',
};

const _$BattleTypeEnumMap = {
  BattleType.tournament: 'tournament',
  BattleType.battleRoyale: 'battleRoyale',
  BattleType.revengeSeries: 'revengeSeries',
};
