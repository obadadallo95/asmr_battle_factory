// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_scenario.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedScenarioImplAdapter extends TypeAdapter<_$SavedScenarioImpl> {
  @override
  final int typeId = 25;

  @override
  _$SavedScenarioImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SavedScenarioImpl(
      id: fields[0] as String,
      titleAr: fields[1] as String,
      titleEn: fields[2] as String,
      briefDescriptionAr: fields[3] as String,
      briefDescriptionEn: fields[4] as String,
      contestantIds: (fields[5] as List).cast<String>(),
      savedAt: fields[6] as DateTime,
      suggestedWinnerId: fields[7] as String?,
      twistLevel: fields[8] as int,
      providerUsed: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$SavedScenarioImpl obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titleAr)
      ..writeByte(2)
      ..write(obj.titleEn)
      ..writeByte(3)
      ..write(obj.briefDescriptionAr)
      ..writeByte(4)
      ..write(obj.briefDescriptionEn)
      ..writeByte(6)
      ..write(obj.savedAt)
      ..writeByte(7)
      ..write(obj.suggestedWinnerId)
      ..writeByte(8)
      ..write(obj.twistLevel)
      ..writeByte(9)
      ..write(obj.providerUsed)
      ..writeByte(5)
      ..write(obj.contestantIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedScenarioImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedScenarioImpl _$$SavedScenarioImplFromJson(Map<String, dynamic> json) =>
    _$SavedScenarioImpl(
      id: json['id'] as String,
      titleAr: json['titleAr'] as String,
      titleEn: json['titleEn'] as String,
      briefDescriptionAr: json['briefDescriptionAr'] as String,
      briefDescriptionEn: json['briefDescriptionEn'] as String,
      contestantIds: (json['contestantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      savedAt: DateTime.parse(json['savedAt'] as String),
      suggestedWinnerId: json['suggestedWinnerId'] as String?,
      twistLevel: (json['twistLevel'] as num?)?.toInt() ?? 5,
      providerUsed: json['providerUsed'] as String?,
    );

Map<String, dynamic> _$$SavedScenarioImplToJson(_$SavedScenarioImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleAr': instance.titleAr,
      'titleEn': instance.titleEn,
      'briefDescriptionAr': instance.briefDescriptionAr,
      'briefDescriptionEn': instance.briefDescriptionEn,
      'contestantIds': instance.contestantIds,
      'savedAt': instance.savedAt.toIso8601String(),
      'suggestedWinnerId': instance.suggestedWinnerId,
      'twistLevel': instance.twistLevel,
      'providerUsed': instance.providerUsed,
    };
