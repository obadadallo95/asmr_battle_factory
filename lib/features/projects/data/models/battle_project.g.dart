// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_project.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BattleProjectImplAdapter extends TypeAdapter<_$BattleProjectImpl> {
  @override
  final int typeId = 10;

  @override
  _$BattleProjectImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$BattleProjectImpl(
      id: fields[0] as String,
      name: fields[1] as String,
      nameAr: fields[2] as String,
      description: fields[3] as String,
      createdAt: fields[4] as DateTime,
      lastUsed: fields[5] as DateTime,
      contestants: (fields[6] as List).cast<String>(),
      theme: fields[7] as String,
      providerMix: fields[8] as ProviderMix,
      videoSettings: fields[9] as VideoSettings,
      budgetMode: fields[10] as BudgetMode,
      generationCount: fields[11] as int,
      totalSpent: fields[12] as double,
      averageQuality: fields[13] as double,
      thumbnailPath: fields[14] as String?,
      tags: (fields[15] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$BattleProjectImpl obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nameAr)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.lastUsed)
      ..writeByte(7)
      ..write(obj.theme)
      ..writeByte(8)
      ..write(obj.providerMix)
      ..writeByte(9)
      ..write(obj.videoSettings)
      ..writeByte(10)
      ..write(obj.budgetMode)
      ..writeByte(11)
      ..write(obj.generationCount)
      ..writeByte(12)
      ..write(obj.totalSpent)
      ..writeByte(13)
      ..write(obj.averageQuality)
      ..writeByte(14)
      ..write(obj.thumbnailPath)
      ..writeByte(6)
      ..write(obj.contestants)
      ..writeByte(15)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BattleProjectImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProviderMixImplAdapter extends TypeAdapter<_$ProviderMixImpl> {
  @override
  final int typeId = 11;

  @override
  _$ProviderMixImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$ProviderMixImpl(
      ideaProvider: fields[0] as String?,
      scriptProvider: fields[1] as String?,
      imageProvider: fields[2] as String?,
      videoProvider: fields[3] as String?,
      useSmartRouting: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$ProviderMixImpl obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.ideaProvider)
      ..writeByte(1)
      ..write(obj.scriptProvider)
      ..writeByte(2)
      ..write(obj.imageProvider)
      ..writeByte(3)
      ..write(obj.videoProvider)
      ..writeByte(4)
      ..write(obj.useSmartRouting);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProviderMixImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoSettingsImplAdapter extends TypeAdapter<_$VideoSettingsImpl> {
  @override
  final int typeId = 12;

  @override
  _$VideoSettingsImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$VideoSettingsImpl(
      aspectRatio: fields[0] as String,
      resolution: fields[1] as String,
      fps: fields[2] as int,
      slowMotion: fields[3] as bool,
      includeVoiceover: fields[4] as bool,
      style: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$VideoSettingsImpl obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.aspectRatio)
      ..writeByte(1)
      ..write(obj.resolution)
      ..writeByte(2)
      ..write(obj.fps)
      ..writeByte(3)
      ..write(obj.slowMotion)
      ..writeByte(4)
      ..write(obj.includeVoiceover)
      ..writeByte(5)
      ..write(obj.style);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoSettingsImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BattleProjectImpl _$$BattleProjectImplFromJson(Map<String, dynamic> json) =>
    _$BattleProjectImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUsed: DateTime.parse(json['lastUsed'] as String),
      contestants: (json['contestants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      theme: json['theme'] as String? ?? 'nature',
      providerMix:
          ProviderMix.fromJson(json['providerMix'] as Map<String, dynamic>),
      videoSettings:
          VideoSettings.fromJson(json['videoSettings'] as Map<String, dynamic>),
      budgetMode: $enumDecode(_$BudgetModeEnumMap, json['budgetMode']),
      generationCount: (json['generationCount'] as num?)?.toInt() ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toDouble() ?? 0.0,
      averageQuality: (json['averageQuality'] as num?)?.toDouble() ?? 0.0,
      thumbnailPath: json['thumbnailPath'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$BattleProjectImplToJson(_$BattleProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastUsed': instance.lastUsed.toIso8601String(),
      'contestants': instance.contestants,
      'theme': instance.theme,
      'providerMix': instance.providerMix,
      'videoSettings': instance.videoSettings,
      'budgetMode': _$BudgetModeEnumMap[instance.budgetMode]!,
      'generationCount': instance.generationCount,
      'totalSpent': instance.totalSpent,
      'averageQuality': instance.averageQuality,
      'thumbnailPath': instance.thumbnailPath,
      'tags': instance.tags,
    };

const _$BudgetModeEnumMap = {
  BudgetMode.economy: 'economy',
  BudgetMode.balanced: 'balanced',
  BudgetMode.premium: 'premium',
  BudgetMode.custom: 'custom',
};

_$ProviderMixImpl _$$ProviderMixImplFromJson(Map<String, dynamic> json) =>
    _$ProviderMixImpl(
      ideaProvider: json['ideaProvider'] as String?,
      scriptProvider: json['scriptProvider'] as String?,
      imageProvider: json['imageProvider'] as String?,
      videoProvider: json['videoProvider'] as String?,
      useSmartRouting: json['useSmartRouting'] as bool? ?? true,
    );

Map<String, dynamic> _$$ProviderMixImplToJson(_$ProviderMixImpl instance) =>
    <String, dynamic>{
      'ideaProvider': instance.ideaProvider,
      'scriptProvider': instance.scriptProvider,
      'imageProvider': instance.imageProvider,
      'videoProvider': instance.videoProvider,
      'useSmartRouting': instance.useSmartRouting,
    };

_$VideoSettingsImpl _$$VideoSettingsImplFromJson(Map<String, dynamic> json) =>
    _$VideoSettingsImpl(
      aspectRatio: json['aspectRatio'] as String? ?? '16:9',
      resolution: json['resolution'] as String? ?? '1080p',
      fps: (json['fps'] as num?)?.toInt() ?? 24,
      slowMotion: json['slowMotion'] as bool? ?? false,
      includeVoiceover: json['includeVoiceover'] as bool? ?? true,
      style: json['style'] as String? ?? 'cinematic',
    );

Map<String, dynamic> _$$VideoSettingsImplToJson(_$VideoSettingsImpl instance) =>
    <String, dynamic>{
      'aspectRatio': instance.aspectRatio,
      'resolution': instance.resolution,
      'fps': instance.fps,
      'slowMotion': instance.slowMotion,
      'includeVoiceover': instance.includeVoiceover,
      'style': instance.style,
    };
