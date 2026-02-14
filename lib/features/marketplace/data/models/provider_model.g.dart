// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProviderModelImpl _$$ProviderModelImplFromJson(Map<String, dynamic> json) =>
    _$ProviderModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      function: $enumDecode(_$ProviderFunctionEnumMap, json['function']),
      tier: $enumDecode(_$ProviderTierEnumMap, json['tier']),
      brandColor: json['brandColor'] as String,
      freeTierDescription: json['freeTierDescription'] as String,
      paidPricing: json['paidPricing'] as String,
      costPerInputUnit: (json['costPerInputUnit'] as num?)?.toDouble() ?? 0.0,
      costPerOutputUnit: (json['costPerOutputUnit'] as num?)?.toDouble() ?? 0.0,
      unitQuantity: (json['unitQuantity'] as num?)?.toInt() ?? 1,
      websiteUrl: json['websiteUrl'] as String,
      signupUrl: json['signupUrl'] as String,
      docsUrl: json['docsUrl'] as String,
      supportsStreaming: json['supportsStreaming'] as bool,
      supportsBatch: json['supportsBatch'] as bool,
      maxContextLength: (json['maxContextLength'] as num?)?.toInt(),
      supportedModels: (json['supportedModels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      qualityRating: (json['qualityRating'] as num).toDouble(),
      speedRating: (json['speedRating'] as num).toDouble(),
      costEfficiencyRating: (json['costEfficiencyRating'] as num).toDouble(),
      requiresCreditCard: json['requiresCreditCard'] as bool,
      availableInSyria: json['availableInSyria'] as bool,
      alternativeFor: json['alternativeFor'] as String?,
      setupDifficulty: json['setupDifficulty'] as String,
      requiresKey: json['requiresKey'] as bool,
    );

Map<String, dynamic> _$$ProviderModelImplToJson(_$ProviderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'function': _$ProviderFunctionEnumMap[instance.function]!,
      'tier': _$ProviderTierEnumMap[instance.tier]!,
      'brandColor': instance.brandColor,
      'freeTierDescription': instance.freeTierDescription,
      'paidPricing': instance.paidPricing,
      'costPerInputUnit': instance.costPerInputUnit,
      'costPerOutputUnit': instance.costPerOutputUnit,
      'unitQuantity': instance.unitQuantity,
      'websiteUrl': instance.websiteUrl,
      'signupUrl': instance.signupUrl,
      'docsUrl': instance.docsUrl,
      'supportsStreaming': instance.supportsStreaming,
      'supportsBatch': instance.supportsBatch,
      'maxContextLength': instance.maxContextLength,
      'supportedModels': instance.supportedModels,
      'qualityRating': instance.qualityRating,
      'speedRating': instance.speedRating,
      'costEfficiencyRating': instance.costEfficiencyRating,
      'requiresCreditCard': instance.requiresCreditCard,
      'availableInSyria': instance.availableInSyria,
      'alternativeFor': instance.alternativeFor,
      'setupDifficulty': instance.setupDifficulty,
      'requiresKey': instance.requiresKey,
    };

const _$ProviderFunctionEnumMap = {
  ProviderFunction.textGeneration: 'text_generation',
  ProviderFunction.imageGeneration: 'image_generation',
  ProviderFunction.videoGeneration: 'video_generation',
  ProviderFunction.audioGeneration: 'audio_generation',
  ProviderFunction.musicGeneration: 'music_generation',
  ProviderFunction.subtitleGeneration: 'subtitle_generation',
};

const _$ProviderTierEnumMap = {
  ProviderTier.free: 'free',
  ProviderTier.freemium: 'freemium',
  ProviderTier.paid: 'paid',
};
