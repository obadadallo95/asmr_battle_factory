// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$APICostModelImpl _$$APICostModelImplFromJson(Map<String, dynamic> json) =>
    _$APICostModelImpl(
      providerId: json['providerId'] as String,
      modelName: json['modelName'] as String,
      type: $enumDecode(_$CostTypeEnumMap, json['type']),
      inputCostPerUnit: (json['inputCostPerUnit'] as num).toDouble(),
      outputCostPerUnit: (json['outputCostPerUnit'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$APICostModelImplToJson(_$APICostModelImpl instance) =>
    <String, dynamic>{
      'providerId': instance.providerId,
      'modelName': instance.modelName,
      'type': _$CostTypeEnumMap[instance.type]!,
      'inputCostPerUnit': instance.inputCostPerUnit,
      'outputCostPerUnit': instance.outputCostPerUnit,
      'currency': instance.currency,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

const _$CostTypeEnumMap = {
  CostType.perToken: 'perToken',
  CostType.perImage: 'perImage',
  CostType.perSecondVideo: 'perSecondVideo',
  CostType.perRequest: 'perRequest',
  CostType.perCharacter: 'perCharacter',
};
