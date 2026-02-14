// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cost_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

APICostModel _$APICostModelFromJson(Map<String, dynamic> json) {
  return _APICostModel.fromJson(json);
}

/// @nodoc
mixin _$APICostModel {
  String get providerId =>
      throw _privateConstructorUsedError; // 'openai', 'runway', 'flux'
  String get modelName =>
      throw _privateConstructorUsedError; // 'gpt-4o', 'gen-2', etc.
  CostType get type =>
      throw _privateConstructorUsedError; // perToken, perImage, perSecond, perRequest
  double get inputCostPerUnit => throw _privateConstructorUsedError; // USD
  double get outputCostPerUnit =>
      throw _privateConstructorUsedError; // USD (if applicable)
  String get currency => throw _privateConstructorUsedError; // USD (default)
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $APICostModelCopyWith<APICostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $APICostModelCopyWith<$Res> {
  factory $APICostModelCopyWith(
          APICostModel value, $Res Function(APICostModel) then) =
      _$APICostModelCopyWithImpl<$Res, APICostModel>;
  @useResult
  $Res call(
      {String providerId,
      String modelName,
      CostType type,
      double inputCostPerUnit,
      double outputCostPerUnit,
      String currency,
      DateTime lastUpdated});
}

/// @nodoc
class _$APICostModelCopyWithImpl<$Res, $Val extends APICostModel>
    implements $APICostModelCopyWith<$Res> {
  _$APICostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? modelName = null,
    Object? type = null,
    Object? inputCostPerUnit = null,
    Object? outputCostPerUnit = null,
    Object? currency = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      modelName: null == modelName
          ? _value.modelName
          : modelName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CostType,
      inputCostPerUnit: null == inputCostPerUnit
          ? _value.inputCostPerUnit
          : inputCostPerUnit // ignore: cast_nullable_to_non_nullable
              as double,
      outputCostPerUnit: null == outputCostPerUnit
          ? _value.outputCostPerUnit
          : outputCostPerUnit // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$APICostModelImplCopyWith<$Res>
    implements $APICostModelCopyWith<$Res> {
  factory _$$APICostModelImplCopyWith(
          _$APICostModelImpl value, $Res Function(_$APICostModelImpl) then) =
      __$$APICostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String providerId,
      String modelName,
      CostType type,
      double inputCostPerUnit,
      double outputCostPerUnit,
      String currency,
      DateTime lastUpdated});
}

/// @nodoc
class __$$APICostModelImplCopyWithImpl<$Res>
    extends _$APICostModelCopyWithImpl<$Res, _$APICostModelImpl>
    implements _$$APICostModelImplCopyWith<$Res> {
  __$$APICostModelImplCopyWithImpl(
      _$APICostModelImpl _value, $Res Function(_$APICostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? modelName = null,
    Object? type = null,
    Object? inputCostPerUnit = null,
    Object? outputCostPerUnit = null,
    Object? currency = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$APICostModelImpl(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      modelName: null == modelName
          ? _value.modelName
          : modelName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CostType,
      inputCostPerUnit: null == inputCostPerUnit
          ? _value.inputCostPerUnit
          : inputCostPerUnit // ignore: cast_nullable_to_non_nullable
              as double,
      outputCostPerUnit: null == outputCostPerUnit
          ? _value.outputCostPerUnit
          : outputCostPerUnit // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$APICostModelImpl implements _APICostModel {
  const _$APICostModelImpl(
      {required this.providerId,
      required this.modelName,
      required this.type,
      required this.inputCostPerUnit,
      required this.outputCostPerUnit,
      this.currency = 'USD',
      required this.lastUpdated});

  factory _$APICostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$APICostModelImplFromJson(json);

  @override
  final String providerId;
// 'openai', 'runway', 'flux'
  @override
  final String modelName;
// 'gpt-4o', 'gen-2', etc.
  @override
  final CostType type;
// perToken, perImage, perSecond, perRequest
  @override
  final double inputCostPerUnit;
// USD
  @override
  final double outputCostPerUnit;
// USD (if applicable)
  @override
  @JsonKey()
  final String currency;
// USD (default)
  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'APICostModel(providerId: $providerId, modelName: $modelName, type: $type, inputCostPerUnit: $inputCostPerUnit, outputCostPerUnit: $outputCostPerUnit, currency: $currency, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$APICostModelImpl &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.modelName, modelName) ||
                other.modelName == modelName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.inputCostPerUnit, inputCostPerUnit) ||
                other.inputCostPerUnit == inputCostPerUnit) &&
            (identical(other.outputCostPerUnit, outputCostPerUnit) ||
                other.outputCostPerUnit == outputCostPerUnit) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, providerId, modelName, type,
      inputCostPerUnit, outputCostPerUnit, currency, lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$APICostModelImplCopyWith<_$APICostModelImpl> get copyWith =>
      __$$APICostModelImplCopyWithImpl<_$APICostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$APICostModelImplToJson(
      this,
    );
  }
}

abstract class _APICostModel implements APICostModel {
  const factory _APICostModel(
      {required final String providerId,
      required final String modelName,
      required final CostType type,
      required final double inputCostPerUnit,
      required final double outputCostPerUnit,
      final String currency,
      required final DateTime lastUpdated}) = _$APICostModelImpl;

  factory _APICostModel.fromJson(Map<String, dynamic> json) =
      _$APICostModelImpl.fromJson;

  @override
  String get providerId;
  @override // 'openai', 'runway', 'flux'
  String get modelName;
  @override // 'gpt-4o', 'gen-2', etc.
  CostType get type;
  @override // perToken, perImage, perSecond, perRequest
  double get inputCostPerUnit;
  @override // USD
  double get outputCostPerUnit;
  @override // USD (if applicable)
  String get currency;
  @override // USD (default)
  DateTime get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$APICostModelImplCopyWith<_$APICostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
