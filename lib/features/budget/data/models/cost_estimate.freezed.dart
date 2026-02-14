// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cost_estimate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CostEstimate {
  double get totalCostUSD => throw _privateConstructorUsedError;
  double get totalDurationSeconds => throw _privateConstructorUsedError;
  CostBreakdown get breakdown => throw _privateConstructorUsedError;
  ProviderStack get apiStack =>
      throw _privateConstructorUsedError; // Which providers were selected
  String get riskLevel =>
      throw _privateConstructorUsedError; // Low, Medium, High
  BudgetMode get mode => throw _privateConstructorUsedError;
  List<String> get optimizationSuggestions =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CostEstimateCopyWith<CostEstimate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CostEstimateCopyWith<$Res> {
  factory $CostEstimateCopyWith(
          CostEstimate value, $Res Function(CostEstimate) then) =
      _$CostEstimateCopyWithImpl<$Res, CostEstimate>;
  @useResult
  $Res call(
      {double totalCostUSD,
      double totalDurationSeconds,
      CostBreakdown breakdown,
      ProviderStack apiStack,
      String riskLevel,
      BudgetMode mode,
      List<String> optimizationSuggestions});

  $CostBreakdownCopyWith<$Res> get breakdown;
}

/// @nodoc
class _$CostEstimateCopyWithImpl<$Res, $Val extends CostEstimate>
    implements $CostEstimateCopyWith<$Res> {
  _$CostEstimateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCostUSD = null,
    Object? totalDurationSeconds = null,
    Object? breakdown = null,
    Object? apiStack = null,
    Object? riskLevel = null,
    Object? mode = null,
    Object? optimizationSuggestions = null,
  }) {
    return _then(_value.copyWith(
      totalCostUSD: null == totalCostUSD
          ? _value.totalCostUSD
          : totalCostUSD // ignore: cast_nullable_to_non_nullable
              as double,
      totalDurationSeconds: null == totalDurationSeconds
          ? _value.totalDurationSeconds
          : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      breakdown: null == breakdown
          ? _value.breakdown
          : breakdown // ignore: cast_nullable_to_non_nullable
              as CostBreakdown,
      apiStack: null == apiStack
          ? _value.apiStack
          : apiStack // ignore: cast_nullable_to_non_nullable
              as ProviderStack,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as BudgetMode,
      optimizationSuggestions: null == optimizationSuggestions
          ? _value.optimizationSuggestions
          : optimizationSuggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CostBreakdownCopyWith<$Res> get breakdown {
    return $CostBreakdownCopyWith<$Res>(_value.breakdown, (value) {
      return _then(_value.copyWith(breakdown: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CostEstimateImplCopyWith<$Res>
    implements $CostEstimateCopyWith<$Res> {
  factory _$$CostEstimateImplCopyWith(
          _$CostEstimateImpl value, $Res Function(_$CostEstimateImpl) then) =
      __$$CostEstimateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalCostUSD,
      double totalDurationSeconds,
      CostBreakdown breakdown,
      ProviderStack apiStack,
      String riskLevel,
      BudgetMode mode,
      List<String> optimizationSuggestions});

  @override
  $CostBreakdownCopyWith<$Res> get breakdown;
}

/// @nodoc
class __$$CostEstimateImplCopyWithImpl<$Res>
    extends _$CostEstimateCopyWithImpl<$Res, _$CostEstimateImpl>
    implements _$$CostEstimateImplCopyWith<$Res> {
  __$$CostEstimateImplCopyWithImpl(
      _$CostEstimateImpl _value, $Res Function(_$CostEstimateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCostUSD = null,
    Object? totalDurationSeconds = null,
    Object? breakdown = null,
    Object? apiStack = null,
    Object? riskLevel = null,
    Object? mode = null,
    Object? optimizationSuggestions = null,
  }) {
    return _then(_$CostEstimateImpl(
      totalCostUSD: null == totalCostUSD
          ? _value.totalCostUSD
          : totalCostUSD // ignore: cast_nullable_to_non_nullable
              as double,
      totalDurationSeconds: null == totalDurationSeconds
          ? _value.totalDurationSeconds
          : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      breakdown: null == breakdown
          ? _value.breakdown
          : breakdown // ignore: cast_nullable_to_non_nullable
              as CostBreakdown,
      apiStack: null == apiStack
          ? _value.apiStack
          : apiStack // ignore: cast_nullable_to_non_nullable
              as ProviderStack,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as BudgetMode,
      optimizationSuggestions: null == optimizationSuggestions
          ? _value._optimizationSuggestions
          : optimizationSuggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$CostEstimateImpl implements _CostEstimate {
  const _$CostEstimateImpl(
      {required this.totalCostUSD,
      required this.totalDurationSeconds,
      required this.breakdown,
      required this.apiStack,
      required this.riskLevel,
      required this.mode,
      final List<String> optimizationSuggestions = const []})
      : _optimizationSuggestions = optimizationSuggestions;

  @override
  final double totalCostUSD;
  @override
  final double totalDurationSeconds;
  @override
  final CostBreakdown breakdown;
  @override
  final ProviderStack apiStack;
// Which providers were selected
  @override
  final String riskLevel;
// Low, Medium, High
  @override
  final BudgetMode mode;
  final List<String> _optimizationSuggestions;
  @override
  @JsonKey()
  List<String> get optimizationSuggestions {
    if (_optimizationSuggestions is EqualUnmodifiableListView)
      return _optimizationSuggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optimizationSuggestions);
  }

  @override
  String toString() {
    return 'CostEstimate(totalCostUSD: $totalCostUSD, totalDurationSeconds: $totalDurationSeconds, breakdown: $breakdown, apiStack: $apiStack, riskLevel: $riskLevel, mode: $mode, optimizationSuggestions: $optimizationSuggestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CostEstimateImpl &&
            (identical(other.totalCostUSD, totalCostUSD) ||
                other.totalCostUSD == totalCostUSD) &&
            (identical(other.totalDurationSeconds, totalDurationSeconds) ||
                other.totalDurationSeconds == totalDurationSeconds) &&
            (identical(other.breakdown, breakdown) ||
                other.breakdown == breakdown) &&
            (identical(other.apiStack, apiStack) ||
                other.apiStack == apiStack) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            const DeepCollectionEquality().equals(
                other._optimizationSuggestions, _optimizationSuggestions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalCostUSD,
      totalDurationSeconds,
      breakdown,
      apiStack,
      riskLevel,
      mode,
      const DeepCollectionEquality().hash(_optimizationSuggestions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CostEstimateImplCopyWith<_$CostEstimateImpl> get copyWith =>
      __$$CostEstimateImplCopyWithImpl<_$CostEstimateImpl>(this, _$identity);
}

abstract class _CostEstimate implements CostEstimate {
  const factory _CostEstimate(
      {required final double totalCostUSD,
      required final double totalDurationSeconds,
      required final CostBreakdown breakdown,
      required final ProviderStack apiStack,
      required final String riskLevel,
      required final BudgetMode mode,
      final List<String> optimizationSuggestions}) = _$CostEstimateImpl;

  @override
  double get totalCostUSD;
  @override
  double get totalDurationSeconds;
  @override
  CostBreakdown get breakdown;
  @override
  ProviderStack get apiStack;
  @override // Which providers were selected
  String get riskLevel;
  @override // Low, Medium, High
  BudgetMode get mode;
  @override
  List<String> get optimizationSuggestions;
  @override
  @JsonKey(ignore: true)
  _$$CostEstimateImplCopyWith<_$CostEstimateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CostBreakdown {
  double get ideaGeneration => throw _privateConstructorUsedError;
  double get scriptWriting => throw _privateConstructorUsedError;
  double get imageGeneration => throw _privateConstructorUsedError;
  double get videoGeneration => throw _privateConstructorUsedError;
  double get audioGeneration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CostBreakdownCopyWith<CostBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CostBreakdownCopyWith<$Res> {
  factory $CostBreakdownCopyWith(
          CostBreakdown value, $Res Function(CostBreakdown) then) =
      _$CostBreakdownCopyWithImpl<$Res, CostBreakdown>;
  @useResult
  $Res call(
      {double ideaGeneration,
      double scriptWriting,
      double imageGeneration,
      double videoGeneration,
      double audioGeneration});
}

/// @nodoc
class _$CostBreakdownCopyWithImpl<$Res, $Val extends CostBreakdown>
    implements $CostBreakdownCopyWith<$Res> {
  _$CostBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ideaGeneration = null,
    Object? scriptWriting = null,
    Object? imageGeneration = null,
    Object? videoGeneration = null,
    Object? audioGeneration = null,
  }) {
    return _then(_value.copyWith(
      ideaGeneration: null == ideaGeneration
          ? _value.ideaGeneration
          : ideaGeneration // ignore: cast_nullable_to_non_nullable
              as double,
      scriptWriting: null == scriptWriting
          ? _value.scriptWriting
          : scriptWriting // ignore: cast_nullable_to_non_nullable
              as double,
      imageGeneration: null == imageGeneration
          ? _value.imageGeneration
          : imageGeneration // ignore: cast_nullable_to_non_nullable
              as double,
      videoGeneration: null == videoGeneration
          ? _value.videoGeneration
          : videoGeneration // ignore: cast_nullable_to_non_nullable
              as double,
      audioGeneration: null == audioGeneration
          ? _value.audioGeneration
          : audioGeneration // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CostBreakdownImplCopyWith<$Res>
    implements $CostBreakdownCopyWith<$Res> {
  factory _$$CostBreakdownImplCopyWith(
          _$CostBreakdownImpl value, $Res Function(_$CostBreakdownImpl) then) =
      __$$CostBreakdownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double ideaGeneration,
      double scriptWriting,
      double imageGeneration,
      double videoGeneration,
      double audioGeneration});
}

/// @nodoc
class __$$CostBreakdownImplCopyWithImpl<$Res>
    extends _$CostBreakdownCopyWithImpl<$Res, _$CostBreakdownImpl>
    implements _$$CostBreakdownImplCopyWith<$Res> {
  __$$CostBreakdownImplCopyWithImpl(
      _$CostBreakdownImpl _value, $Res Function(_$CostBreakdownImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ideaGeneration = null,
    Object? scriptWriting = null,
    Object? imageGeneration = null,
    Object? videoGeneration = null,
    Object? audioGeneration = null,
  }) {
    return _then(_$CostBreakdownImpl(
      ideaGeneration: null == ideaGeneration
          ? _value.ideaGeneration
          : ideaGeneration // ignore: cast_nullable_to_non_nullable
              as double,
      scriptWriting: null == scriptWriting
          ? _value.scriptWriting
          : scriptWriting // ignore: cast_nullable_to_non_nullable
              as double,
      imageGeneration: null == imageGeneration
          ? _value.imageGeneration
          : imageGeneration // ignore: cast_nullable_to_non_nullable
              as double,
      videoGeneration: null == videoGeneration
          ? _value.videoGeneration
          : videoGeneration // ignore: cast_nullable_to_non_nullable
              as double,
      audioGeneration: null == audioGeneration
          ? _value.audioGeneration
          : audioGeneration // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$CostBreakdownImpl implements _CostBreakdown {
  const _$CostBreakdownImpl(
      {required this.ideaGeneration,
      required this.scriptWriting,
      required this.imageGeneration,
      required this.videoGeneration,
      required this.audioGeneration});

  @override
  final double ideaGeneration;
  @override
  final double scriptWriting;
  @override
  final double imageGeneration;
  @override
  final double videoGeneration;
  @override
  final double audioGeneration;

  @override
  String toString() {
    return 'CostBreakdown(ideaGeneration: $ideaGeneration, scriptWriting: $scriptWriting, imageGeneration: $imageGeneration, videoGeneration: $videoGeneration, audioGeneration: $audioGeneration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CostBreakdownImpl &&
            (identical(other.ideaGeneration, ideaGeneration) ||
                other.ideaGeneration == ideaGeneration) &&
            (identical(other.scriptWriting, scriptWriting) ||
                other.scriptWriting == scriptWriting) &&
            (identical(other.imageGeneration, imageGeneration) ||
                other.imageGeneration == imageGeneration) &&
            (identical(other.videoGeneration, videoGeneration) ||
                other.videoGeneration == videoGeneration) &&
            (identical(other.audioGeneration, audioGeneration) ||
                other.audioGeneration == audioGeneration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ideaGeneration, scriptWriting,
      imageGeneration, videoGeneration, audioGeneration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CostBreakdownImplCopyWith<_$CostBreakdownImpl> get copyWith =>
      __$$CostBreakdownImplCopyWithImpl<_$CostBreakdownImpl>(this, _$identity);
}

abstract class _CostBreakdown implements CostBreakdown {
  const factory _CostBreakdown(
      {required final double ideaGeneration,
      required final double scriptWriting,
      required final double imageGeneration,
      required final double videoGeneration,
      required final double audioGeneration}) = _$CostBreakdownImpl;

  @override
  double get ideaGeneration;
  @override
  double get scriptWriting;
  @override
  double get imageGeneration;
  @override
  double get videoGeneration;
  @override
  double get audioGeneration;
  @override
  @JsonKey(ignore: true)
  _$$CostBreakdownImplCopyWith<_$CostBreakdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
