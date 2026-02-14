// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_catalog_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProviderCatalogEntryImpl _$$ProviderCatalogEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$ProviderCatalogEntryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      function: $enumDecode(_$ProviderFunctionEnumMap, json['function']),
      tier: $enumDecode(_$ProviderTierEnumMap, json['tier']),
      logoAsset: json['logoAsset'] as String?,
      brandColor: json['brandColor'] as String? ?? '#6366F1',
      freeTierDescription: json['freeTierDescription'] as String?,
      paidPricing: json['paidPricing'] as String?,
      websiteUrl: json['websiteUrl'] as String,
      signupUrl: json['signupUrl'] as String?,
      docsUrl: json['docsUrl'] as String?,
      costPerInputUnit: (json['costPerInputUnit'] as num?)?.toDouble(),
      costPerOutputUnit: (json['costPerOutputUnit'] as num?)?.toDouble(),
      unitQuantity: (json['unitQuantity'] as num?)?.toInt() ?? 1000,
      supportsStreaming: json['supportsStreaming'] as bool? ?? false,
      supportsBatch: json['supportsBatch'] as bool? ?? false,
      maxContextLength: (json['maxContextLength'] as num?)?.toInt(),
      supportedModels: (json['supportedModels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      qualityRating: (json['qualityRating'] as num?)?.toDouble() ?? 3.0,
      speedRating: (json['speedRating'] as num?)?.toDouble() ?? 3.0,
      costEfficiencyRating:
          (json['costEfficiencyRating'] as num?)?.toDouble() ?? 3.0,
      requiresCreditCard: json['requiresCreditCard'] as bool? ?? false,
      availableInSyria: json['availableInSyria'] as bool? ?? true,
      alternativeFor: json['alternativeFor'] as String?,
      setupDifficulty: $enumDecodeNullable(
              _$SetupDifficultyEnumMap, json['setupDifficulty']) ??
          SetupDifficulty.easy,
      requiresKey: json['requiresKey'] as bool? ?? true,
    );

Map<String, dynamic> _$$ProviderCatalogEntryImplToJson(
        _$ProviderCatalogEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'function': _$ProviderFunctionEnumMap[instance.function]!,
      'tier': _$ProviderTierEnumMap[instance.tier]!,
      'logoAsset': instance.logoAsset,
      'brandColor': instance.brandColor,
      'freeTierDescription': instance.freeTierDescription,
      'paidPricing': instance.paidPricing,
      'websiteUrl': instance.websiteUrl,
      'signupUrl': instance.signupUrl,
      'docsUrl': instance.docsUrl,
      'costPerInputUnit': instance.costPerInputUnit,
      'costPerOutputUnit': instance.costPerOutputUnit,
      'unitQuantity': instance.unitQuantity,
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
      'setupDifficulty': _$SetupDifficultyEnumMap[instance.setupDifficulty]!,
      'requiresKey': instance.requiresKey,
    };

const _$ProviderFunctionEnumMap = {
  ProviderFunction.textGeneration: 'text_generation',
  ProviderFunction.imageGeneration: 'image_generation',
  ProviderFunction.videoGeneration: 'video_generation',
  ProviderFunction.audioGeneration: 'audio_generation',
  ProviderFunction.musicGeneration: 'music_generation',
  ProviderFunction.voiceCloning: 'voice_cloning',
  ProviderFunction.upscaling: 'upscaling',
  ProviderFunction.faceSwap: 'face_swap',
  ProviderFunction.subtitleGeneration: 'subtitle_generation',
};

const _$ProviderTierEnumMap = {
  ProviderTier.free: 'free',
  ProviderTier.freemium: 'freemium',
  ProviderTier.paid: 'paid',
  ProviderTier.openSource: 'open_source',
};

const _$SetupDifficultyEnumMap = {
  SetupDifficulty.easy: 'easy',
  SetupDifficulty.medium: 'medium',
  SetupDifficulty.hard: 'hard',
};
