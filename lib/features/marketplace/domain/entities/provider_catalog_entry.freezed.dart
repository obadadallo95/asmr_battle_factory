// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_catalog_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProviderCatalogEntry _$ProviderCatalogEntryFromJson(Map<String, dynamic> json) {
  return _ProviderCatalogEntry.fromJson(json);
}

/// @nodoc
mixin _$ProviderCatalogEntry {
  String get id =>
      throw _privateConstructorUsedError; // 'openai', 'runway', 'pollinations'
  String get name => throw _privateConstructorUsedError;
  String get nameAr => throw _privateConstructorUsedError;
  ProviderFunction get function => throw _privateConstructorUsedError;
  ProviderTier get tier =>
      throw _privateConstructorUsedError; // Visual identity
  String? get logoAsset => throw _privateConstructorUsedError;
  String get brandColor =>
      throw _privateConstructorUsedError; // Pricing transparency
  String? get freeTierDescription =>
      throw _privateConstructorUsedError; // "1,000 tokens/day free"
  String? get paidPricing =>
      throw _privateConstructorUsedError; // "$0.20 per second"
  String get websiteUrl => throw _privateConstructorUsedError;
  String? get signupUrl => throw _privateConstructorUsedError;
  String? get docsUrl =>
      throw _privateConstructorUsedError; // Structured Pricing
  double? get costPerInputUnit =>
      throw _privateConstructorUsedError; // USD per token/image/second
  double? get costPerOutputUnit =>
      throw _privateConstructorUsedError; // USD per token
  int get unitQuantity =>
      throw _privateConstructorUsedError; // 1000 for tokens, 1 for others
// Capabilities
  bool get supportsStreaming => throw _privateConstructorUsedError;
  bool get supportsBatch => throw _privateConstructorUsedError;
  int? get maxContextLength => throw _privateConstructorUsedError;
  List<String> get supportedModels =>
      throw _privateConstructorUsedError; // Quality ratings (1.0-5.0 stars)
  double get qualityRating =>
      throw _privateConstructorUsedError; // For this specific function
  double get speedRating => throw _privateConstructorUsedError;
  double get costEfficiencyRating =>
      throw _privateConstructorUsedError; // Special features
  bool get requiresCreditCard =>
      throw _privateConstructorUsedError; // For free tier
  bool get availableInSyria =>
      throw _privateConstructorUsedError; // Geo-restrictions
  String? get alternativeFor =>
      throw _privateConstructorUsedError; // If banned, use this instead
  SetupDifficulty get setupDifficulty => throw _privateConstructorUsedError;
  bool get requiresKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProviderCatalogEntryCopyWith<ProviderCatalogEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderCatalogEntryCopyWith<$Res> {
  factory $ProviderCatalogEntryCopyWith(ProviderCatalogEntry value,
          $Res Function(ProviderCatalogEntry) then) =
      _$ProviderCatalogEntryCopyWithImpl<$Res, ProviderCatalogEntry>;
  @useResult
  $Res call(
      {String id,
      String name,
      String nameAr,
      ProviderFunction function,
      ProviderTier tier,
      String? logoAsset,
      String brandColor,
      String? freeTierDescription,
      String? paidPricing,
      String websiteUrl,
      String? signupUrl,
      String? docsUrl,
      double? costPerInputUnit,
      double? costPerOutputUnit,
      int unitQuantity,
      bool supportsStreaming,
      bool supportsBatch,
      int? maxContextLength,
      List<String> supportedModels,
      double qualityRating,
      double speedRating,
      double costEfficiencyRating,
      bool requiresCreditCard,
      bool availableInSyria,
      String? alternativeFor,
      SetupDifficulty setupDifficulty,
      bool requiresKey});
}

/// @nodoc
class _$ProviderCatalogEntryCopyWithImpl<$Res,
        $Val extends ProviderCatalogEntry>
    implements $ProviderCatalogEntryCopyWith<$Res> {
  _$ProviderCatalogEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? function = null,
    Object? tier = null,
    Object? logoAsset = freezed,
    Object? brandColor = null,
    Object? freeTierDescription = freezed,
    Object? paidPricing = freezed,
    Object? websiteUrl = null,
    Object? signupUrl = freezed,
    Object? docsUrl = freezed,
    Object? costPerInputUnit = freezed,
    Object? costPerOutputUnit = freezed,
    Object? unitQuantity = null,
    Object? supportsStreaming = null,
    Object? supportsBatch = null,
    Object? maxContextLength = freezed,
    Object? supportedModels = null,
    Object? qualityRating = null,
    Object? speedRating = null,
    Object? costEfficiencyRating = null,
    Object? requiresCreditCard = null,
    Object? availableInSyria = null,
    Object? alternativeFor = freezed,
    Object? setupDifficulty = null,
    Object? requiresKey = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      function: null == function
          ? _value.function
          : function // ignore: cast_nullable_to_non_nullable
              as ProviderFunction,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as ProviderTier,
      logoAsset: freezed == logoAsset
          ? _value.logoAsset
          : logoAsset // ignore: cast_nullable_to_non_nullable
              as String?,
      brandColor: null == brandColor
          ? _value.brandColor
          : brandColor // ignore: cast_nullable_to_non_nullable
              as String,
      freeTierDescription: freezed == freeTierDescription
          ? _value.freeTierDescription
          : freeTierDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      paidPricing: freezed == paidPricing
          ? _value.paidPricing
          : paidPricing // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: null == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String,
      signupUrl: freezed == signupUrl
          ? _value.signupUrl
          : signupUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      docsUrl: freezed == docsUrl
          ? _value.docsUrl
          : docsUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      costPerInputUnit: freezed == costPerInputUnit
          ? _value.costPerInputUnit
          : costPerInputUnit // ignore: cast_nullable_to_non_nullable
              as double?,
      costPerOutputUnit: freezed == costPerOutputUnit
          ? _value.costPerOutputUnit
          : costPerOutputUnit // ignore: cast_nullable_to_non_nullable
              as double?,
      unitQuantity: null == unitQuantity
          ? _value.unitQuantity
          : unitQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      supportsStreaming: null == supportsStreaming
          ? _value.supportsStreaming
          : supportsStreaming // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsBatch: null == supportsBatch
          ? _value.supportsBatch
          : supportsBatch // ignore: cast_nullable_to_non_nullable
              as bool,
      maxContextLength: freezed == maxContextLength
          ? _value.maxContextLength
          : maxContextLength // ignore: cast_nullable_to_non_nullable
              as int?,
      supportedModels: null == supportedModels
          ? _value.supportedModels
          : supportedModels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      qualityRating: null == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as double,
      speedRating: null == speedRating
          ? _value.speedRating
          : speedRating // ignore: cast_nullable_to_non_nullable
              as double,
      costEfficiencyRating: null == costEfficiencyRating
          ? _value.costEfficiencyRating
          : costEfficiencyRating // ignore: cast_nullable_to_non_nullable
              as double,
      requiresCreditCard: null == requiresCreditCard
          ? _value.requiresCreditCard
          : requiresCreditCard // ignore: cast_nullable_to_non_nullable
              as bool,
      availableInSyria: null == availableInSyria
          ? _value.availableInSyria
          : availableInSyria // ignore: cast_nullable_to_non_nullable
              as bool,
      alternativeFor: freezed == alternativeFor
          ? _value.alternativeFor
          : alternativeFor // ignore: cast_nullable_to_non_nullable
              as String?,
      setupDifficulty: null == setupDifficulty
          ? _value.setupDifficulty
          : setupDifficulty // ignore: cast_nullable_to_non_nullable
              as SetupDifficulty,
      requiresKey: null == requiresKey
          ? _value.requiresKey
          : requiresKey // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProviderCatalogEntryImplCopyWith<$Res>
    implements $ProviderCatalogEntryCopyWith<$Res> {
  factory _$$ProviderCatalogEntryImplCopyWith(_$ProviderCatalogEntryImpl value,
          $Res Function(_$ProviderCatalogEntryImpl) then) =
      __$$ProviderCatalogEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String nameAr,
      ProviderFunction function,
      ProviderTier tier,
      String? logoAsset,
      String brandColor,
      String? freeTierDescription,
      String? paidPricing,
      String websiteUrl,
      String? signupUrl,
      String? docsUrl,
      double? costPerInputUnit,
      double? costPerOutputUnit,
      int unitQuantity,
      bool supportsStreaming,
      bool supportsBatch,
      int? maxContextLength,
      List<String> supportedModels,
      double qualityRating,
      double speedRating,
      double costEfficiencyRating,
      bool requiresCreditCard,
      bool availableInSyria,
      String? alternativeFor,
      SetupDifficulty setupDifficulty,
      bool requiresKey});
}

/// @nodoc
class __$$ProviderCatalogEntryImplCopyWithImpl<$Res>
    extends _$ProviderCatalogEntryCopyWithImpl<$Res, _$ProviderCatalogEntryImpl>
    implements _$$ProviderCatalogEntryImplCopyWith<$Res> {
  __$$ProviderCatalogEntryImplCopyWithImpl(_$ProviderCatalogEntryImpl _value,
      $Res Function(_$ProviderCatalogEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? function = null,
    Object? tier = null,
    Object? logoAsset = freezed,
    Object? brandColor = null,
    Object? freeTierDescription = freezed,
    Object? paidPricing = freezed,
    Object? websiteUrl = null,
    Object? signupUrl = freezed,
    Object? docsUrl = freezed,
    Object? costPerInputUnit = freezed,
    Object? costPerOutputUnit = freezed,
    Object? unitQuantity = null,
    Object? supportsStreaming = null,
    Object? supportsBatch = null,
    Object? maxContextLength = freezed,
    Object? supportedModels = null,
    Object? qualityRating = null,
    Object? speedRating = null,
    Object? costEfficiencyRating = null,
    Object? requiresCreditCard = null,
    Object? availableInSyria = null,
    Object? alternativeFor = freezed,
    Object? setupDifficulty = null,
    Object? requiresKey = null,
  }) {
    return _then(_$ProviderCatalogEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      function: null == function
          ? _value.function
          : function // ignore: cast_nullable_to_non_nullable
              as ProviderFunction,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as ProviderTier,
      logoAsset: freezed == logoAsset
          ? _value.logoAsset
          : logoAsset // ignore: cast_nullable_to_non_nullable
              as String?,
      brandColor: null == brandColor
          ? _value.brandColor
          : brandColor // ignore: cast_nullable_to_non_nullable
              as String,
      freeTierDescription: freezed == freeTierDescription
          ? _value.freeTierDescription
          : freeTierDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      paidPricing: freezed == paidPricing
          ? _value.paidPricing
          : paidPricing // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteUrl: null == websiteUrl
          ? _value.websiteUrl
          : websiteUrl // ignore: cast_nullable_to_non_nullable
              as String,
      signupUrl: freezed == signupUrl
          ? _value.signupUrl
          : signupUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      docsUrl: freezed == docsUrl
          ? _value.docsUrl
          : docsUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      costPerInputUnit: freezed == costPerInputUnit
          ? _value.costPerInputUnit
          : costPerInputUnit // ignore: cast_nullable_to_non_nullable
              as double?,
      costPerOutputUnit: freezed == costPerOutputUnit
          ? _value.costPerOutputUnit
          : costPerOutputUnit // ignore: cast_nullable_to_non_nullable
              as double?,
      unitQuantity: null == unitQuantity
          ? _value.unitQuantity
          : unitQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      supportsStreaming: null == supportsStreaming
          ? _value.supportsStreaming
          : supportsStreaming // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsBatch: null == supportsBatch
          ? _value.supportsBatch
          : supportsBatch // ignore: cast_nullable_to_non_nullable
              as bool,
      maxContextLength: freezed == maxContextLength
          ? _value.maxContextLength
          : maxContextLength // ignore: cast_nullable_to_non_nullable
              as int?,
      supportedModels: null == supportedModels
          ? _value._supportedModels
          : supportedModels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      qualityRating: null == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as double,
      speedRating: null == speedRating
          ? _value.speedRating
          : speedRating // ignore: cast_nullable_to_non_nullable
              as double,
      costEfficiencyRating: null == costEfficiencyRating
          ? _value.costEfficiencyRating
          : costEfficiencyRating // ignore: cast_nullable_to_non_nullable
              as double,
      requiresCreditCard: null == requiresCreditCard
          ? _value.requiresCreditCard
          : requiresCreditCard // ignore: cast_nullable_to_non_nullable
              as bool,
      availableInSyria: null == availableInSyria
          ? _value.availableInSyria
          : availableInSyria // ignore: cast_nullable_to_non_nullable
              as bool,
      alternativeFor: freezed == alternativeFor
          ? _value.alternativeFor
          : alternativeFor // ignore: cast_nullable_to_non_nullable
              as String?,
      setupDifficulty: null == setupDifficulty
          ? _value.setupDifficulty
          : setupDifficulty // ignore: cast_nullable_to_non_nullable
              as SetupDifficulty,
      requiresKey: null == requiresKey
          ? _value.requiresKey
          : requiresKey // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProviderCatalogEntryImpl implements _ProviderCatalogEntry {
  const _$ProviderCatalogEntryImpl(
      {required this.id,
      required this.name,
      required this.nameAr,
      required this.function,
      required this.tier,
      this.logoAsset,
      this.brandColor = '#6366F1',
      this.freeTierDescription,
      this.paidPricing,
      required this.websiteUrl,
      this.signupUrl,
      this.docsUrl,
      this.costPerInputUnit,
      this.costPerOutputUnit,
      this.unitQuantity = 1000,
      this.supportsStreaming = false,
      this.supportsBatch = false,
      this.maxContextLength,
      final List<String> supportedModels = const [],
      this.qualityRating = 3.0,
      this.speedRating = 3.0,
      this.costEfficiencyRating = 3.0,
      this.requiresCreditCard = false,
      this.availableInSyria = true,
      this.alternativeFor,
      this.setupDifficulty = SetupDifficulty.easy,
      this.requiresKey = true})
      : _supportedModels = supportedModels;

  factory _$ProviderCatalogEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProviderCatalogEntryImplFromJson(json);

  @override
  final String id;
// 'openai', 'runway', 'pollinations'
  @override
  final String name;
  @override
  final String nameAr;
  @override
  final ProviderFunction function;
  @override
  final ProviderTier tier;
// Visual identity
  @override
  final String? logoAsset;
  @override
  @JsonKey()
  final String brandColor;
// Pricing transparency
  @override
  final String? freeTierDescription;
// "1,000 tokens/day free"
  @override
  final String? paidPricing;
// "$0.20 per second"
  @override
  final String websiteUrl;
  @override
  final String? signupUrl;
  @override
  final String? docsUrl;
// Structured Pricing
  @override
  final double? costPerInputUnit;
// USD per token/image/second
  @override
  final double? costPerOutputUnit;
// USD per token
  @override
  @JsonKey()
  final int unitQuantity;
// 1000 for tokens, 1 for others
// Capabilities
  @override
  @JsonKey()
  final bool supportsStreaming;
  @override
  @JsonKey()
  final bool supportsBatch;
  @override
  final int? maxContextLength;
  final List<String> _supportedModels;
  @override
  @JsonKey()
  List<String> get supportedModels {
    if (_supportedModels is EqualUnmodifiableListView) return _supportedModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedModels);
  }

// Quality ratings (1.0-5.0 stars)
  @override
  @JsonKey()
  final double qualityRating;
// For this specific function
  @override
  @JsonKey()
  final double speedRating;
  @override
  @JsonKey()
  final double costEfficiencyRating;
// Special features
  @override
  @JsonKey()
  final bool requiresCreditCard;
// For free tier
  @override
  @JsonKey()
  final bool availableInSyria;
// Geo-restrictions
  @override
  final String? alternativeFor;
// If banned, use this instead
  @override
  @JsonKey()
  final SetupDifficulty setupDifficulty;
  @override
  @JsonKey()
  final bool requiresKey;

  @override
  String toString() {
    return 'ProviderCatalogEntry(id: $id, name: $name, nameAr: $nameAr, function: $function, tier: $tier, logoAsset: $logoAsset, brandColor: $brandColor, freeTierDescription: $freeTierDescription, paidPricing: $paidPricing, websiteUrl: $websiteUrl, signupUrl: $signupUrl, docsUrl: $docsUrl, costPerInputUnit: $costPerInputUnit, costPerOutputUnit: $costPerOutputUnit, unitQuantity: $unitQuantity, supportsStreaming: $supportsStreaming, supportsBatch: $supportsBatch, maxContextLength: $maxContextLength, supportedModels: $supportedModels, qualityRating: $qualityRating, speedRating: $speedRating, costEfficiencyRating: $costEfficiencyRating, requiresCreditCard: $requiresCreditCard, availableInSyria: $availableInSyria, alternativeFor: $alternativeFor, setupDifficulty: $setupDifficulty, requiresKey: $requiresKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProviderCatalogEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.function, function) ||
                other.function == function) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.logoAsset, logoAsset) ||
                other.logoAsset == logoAsset) &&
            (identical(other.brandColor, brandColor) ||
                other.brandColor == brandColor) &&
            (identical(other.freeTierDescription, freeTierDescription) ||
                other.freeTierDescription == freeTierDescription) &&
            (identical(other.paidPricing, paidPricing) ||
                other.paidPricing == paidPricing) &&
            (identical(other.websiteUrl, websiteUrl) ||
                other.websiteUrl == websiteUrl) &&
            (identical(other.signupUrl, signupUrl) ||
                other.signupUrl == signupUrl) &&
            (identical(other.docsUrl, docsUrl) || other.docsUrl == docsUrl) &&
            (identical(other.costPerInputUnit, costPerInputUnit) ||
                other.costPerInputUnit == costPerInputUnit) &&
            (identical(other.costPerOutputUnit, costPerOutputUnit) ||
                other.costPerOutputUnit == costPerOutputUnit) &&
            (identical(other.unitQuantity, unitQuantity) ||
                other.unitQuantity == unitQuantity) &&
            (identical(other.supportsStreaming, supportsStreaming) ||
                other.supportsStreaming == supportsStreaming) &&
            (identical(other.supportsBatch, supportsBatch) ||
                other.supportsBatch == supportsBatch) &&
            (identical(other.maxContextLength, maxContextLength) ||
                other.maxContextLength == maxContextLength) &&
            const DeepCollectionEquality()
                .equals(other._supportedModels, _supportedModels) &&
            (identical(other.qualityRating, qualityRating) ||
                other.qualityRating == qualityRating) &&
            (identical(other.speedRating, speedRating) ||
                other.speedRating == speedRating) &&
            (identical(other.costEfficiencyRating, costEfficiencyRating) ||
                other.costEfficiencyRating == costEfficiencyRating) &&
            (identical(other.requiresCreditCard, requiresCreditCard) ||
                other.requiresCreditCard == requiresCreditCard) &&
            (identical(other.availableInSyria, availableInSyria) ||
                other.availableInSyria == availableInSyria) &&
            (identical(other.alternativeFor, alternativeFor) ||
                other.alternativeFor == alternativeFor) &&
            (identical(other.setupDifficulty, setupDifficulty) ||
                other.setupDifficulty == setupDifficulty) &&
            (identical(other.requiresKey, requiresKey) ||
                other.requiresKey == requiresKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        nameAr,
        function,
        tier,
        logoAsset,
        brandColor,
        freeTierDescription,
        paidPricing,
        websiteUrl,
        signupUrl,
        docsUrl,
        costPerInputUnit,
        costPerOutputUnit,
        unitQuantity,
        supportsStreaming,
        supportsBatch,
        maxContextLength,
        const DeepCollectionEquality().hash(_supportedModels),
        qualityRating,
        speedRating,
        costEfficiencyRating,
        requiresCreditCard,
        availableInSyria,
        alternativeFor,
        setupDifficulty,
        requiresKey
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProviderCatalogEntryImplCopyWith<_$ProviderCatalogEntryImpl>
      get copyWith =>
          __$$ProviderCatalogEntryImplCopyWithImpl<_$ProviderCatalogEntryImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProviderCatalogEntryImplToJson(
      this,
    );
  }
}

abstract class _ProviderCatalogEntry implements ProviderCatalogEntry {
  const factory _ProviderCatalogEntry(
      {required final String id,
      required final String name,
      required final String nameAr,
      required final ProviderFunction function,
      required final ProviderTier tier,
      final String? logoAsset,
      final String brandColor,
      final String? freeTierDescription,
      final String? paidPricing,
      required final String websiteUrl,
      final String? signupUrl,
      final String? docsUrl,
      final double? costPerInputUnit,
      final double? costPerOutputUnit,
      final int unitQuantity,
      final bool supportsStreaming,
      final bool supportsBatch,
      final int? maxContextLength,
      final List<String> supportedModels,
      final double qualityRating,
      final double speedRating,
      final double costEfficiencyRating,
      final bool requiresCreditCard,
      final bool availableInSyria,
      final String? alternativeFor,
      final SetupDifficulty setupDifficulty,
      final bool requiresKey}) = _$ProviderCatalogEntryImpl;

  factory _ProviderCatalogEntry.fromJson(Map<String, dynamic> json) =
      _$ProviderCatalogEntryImpl.fromJson;

  @override
  String get id;
  @override // 'openai', 'runway', 'pollinations'
  String get name;
  @override
  String get nameAr;
  @override
  ProviderFunction get function;
  @override
  ProviderTier get tier;
  @override // Visual identity
  String? get logoAsset;
  @override
  String get brandColor;
  @override // Pricing transparency
  String? get freeTierDescription;
  @override // "1,000 tokens/day free"
  String? get paidPricing;
  @override // "$0.20 per second"
  String get websiteUrl;
  @override
  String? get signupUrl;
  @override
  String? get docsUrl;
  @override // Structured Pricing
  double? get costPerInputUnit;
  @override // USD per token/image/second
  double? get costPerOutputUnit;
  @override // USD per token
  int get unitQuantity;
  @override // 1000 for tokens, 1 for others
// Capabilities
  bool get supportsStreaming;
  @override
  bool get supportsBatch;
  @override
  int? get maxContextLength;
  @override
  List<String> get supportedModels;
  @override // Quality ratings (1.0-5.0 stars)
  double get qualityRating;
  @override // For this specific function
  double get speedRating;
  @override
  double get costEfficiencyRating;
  @override // Special features
  bool get requiresCreditCard;
  @override // For free tier
  bool get availableInSyria;
  @override // Geo-restrictions
  String? get alternativeFor;
  @override // If banned, use this instead
  SetupDifficulty get setupDifficulty;
  @override
  bool get requiresKey;
  @override
  @JsonKey(ignore: true)
  _$$ProviderCatalogEntryImplCopyWith<_$ProviderCatalogEntryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
