// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duration_estimate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DurationEstimate {
  int get totalSeconds => throw _privateConstructorUsedError;
  Map<String, int> get sceneDurations =>
      throw _privateConstructorUsedError; // "intro": 3, "battle": 4...
  String get formattedDuration => throw _privateConstructorUsedError; // "0:18"
  String get platformRecommendation =>
      throw _privateConstructorUsedError; // "Perfect for TikTok"
  double get estimatedFileSizeMB => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DurationEstimateCopyWith<DurationEstimate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DurationEstimateCopyWith<$Res> {
  factory $DurationEstimateCopyWith(
          DurationEstimate value, $Res Function(DurationEstimate) then) =
      _$DurationEstimateCopyWithImpl<$Res, DurationEstimate>;
  @useResult
  $Res call(
      {int totalSeconds,
      Map<String, int> sceneDurations,
      String formattedDuration,
      String platformRecommendation,
      double estimatedFileSizeMB});
}

/// @nodoc
class _$DurationEstimateCopyWithImpl<$Res, $Val extends DurationEstimate>
    implements $DurationEstimateCopyWith<$Res> {
  _$DurationEstimateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSeconds = null,
    Object? sceneDurations = null,
    Object? formattedDuration = null,
    Object? platformRecommendation = null,
    Object? estimatedFileSizeMB = null,
  }) {
    return _then(_value.copyWith(
      totalSeconds: null == totalSeconds
          ? _value.totalSeconds
          : totalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      sceneDurations: null == sceneDurations
          ? _value.sceneDurations
          : sceneDurations // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      formattedDuration: null == formattedDuration
          ? _value.formattedDuration
          : formattedDuration // ignore: cast_nullable_to_non_nullable
              as String,
      platformRecommendation: null == platformRecommendation
          ? _value.platformRecommendation
          : platformRecommendation // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedFileSizeMB: null == estimatedFileSizeMB
          ? _value.estimatedFileSizeMB
          : estimatedFileSizeMB // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DurationEstimateImplCopyWith<$Res>
    implements $DurationEstimateCopyWith<$Res> {
  factory _$$DurationEstimateImplCopyWith(_$DurationEstimateImpl value,
          $Res Function(_$DurationEstimateImpl) then) =
      __$$DurationEstimateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalSeconds,
      Map<String, int> sceneDurations,
      String formattedDuration,
      String platformRecommendation,
      double estimatedFileSizeMB});
}

/// @nodoc
class __$$DurationEstimateImplCopyWithImpl<$Res>
    extends _$DurationEstimateCopyWithImpl<$Res, _$DurationEstimateImpl>
    implements _$$DurationEstimateImplCopyWith<$Res> {
  __$$DurationEstimateImplCopyWithImpl(_$DurationEstimateImpl _value,
      $Res Function(_$DurationEstimateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSeconds = null,
    Object? sceneDurations = null,
    Object? formattedDuration = null,
    Object? platformRecommendation = null,
    Object? estimatedFileSizeMB = null,
  }) {
    return _then(_$DurationEstimateImpl(
      totalSeconds: null == totalSeconds
          ? _value.totalSeconds
          : totalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      sceneDurations: null == sceneDurations
          ? _value._sceneDurations
          : sceneDurations // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      formattedDuration: null == formattedDuration
          ? _value.formattedDuration
          : formattedDuration // ignore: cast_nullable_to_non_nullable
              as String,
      platformRecommendation: null == platformRecommendation
          ? _value.platformRecommendation
          : platformRecommendation // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedFileSizeMB: null == estimatedFileSizeMB
          ? _value.estimatedFileSizeMB
          : estimatedFileSizeMB // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DurationEstimateImpl implements _DurationEstimate {
  const _$DurationEstimateImpl(
      {required this.totalSeconds,
      required final Map<String, int> sceneDurations,
      required this.formattedDuration,
      required this.platformRecommendation,
      required this.estimatedFileSizeMB})
      : _sceneDurations = sceneDurations;

  @override
  final int totalSeconds;
  final Map<String, int> _sceneDurations;
  @override
  Map<String, int> get sceneDurations {
    if (_sceneDurations is EqualUnmodifiableMapView) return _sceneDurations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sceneDurations);
  }

// "intro": 3, "battle": 4...
  @override
  final String formattedDuration;
// "0:18"
  @override
  final String platformRecommendation;
// "Perfect for TikTok"
  @override
  final double estimatedFileSizeMB;

  @override
  String toString() {
    return 'DurationEstimate(totalSeconds: $totalSeconds, sceneDurations: $sceneDurations, formattedDuration: $formattedDuration, platformRecommendation: $platformRecommendation, estimatedFileSizeMB: $estimatedFileSizeMB)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DurationEstimateImpl &&
            (identical(other.totalSeconds, totalSeconds) ||
                other.totalSeconds == totalSeconds) &&
            const DeepCollectionEquality()
                .equals(other._sceneDurations, _sceneDurations) &&
            (identical(other.formattedDuration, formattedDuration) ||
                other.formattedDuration == formattedDuration) &&
            (identical(other.platformRecommendation, platformRecommendation) ||
                other.platformRecommendation == platformRecommendation) &&
            (identical(other.estimatedFileSizeMB, estimatedFileSizeMB) ||
                other.estimatedFileSizeMB == estimatedFileSizeMB));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalSeconds,
      const DeepCollectionEquality().hash(_sceneDurations),
      formattedDuration,
      platformRecommendation,
      estimatedFileSizeMB);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DurationEstimateImplCopyWith<_$DurationEstimateImpl> get copyWith =>
      __$$DurationEstimateImplCopyWithImpl<_$DurationEstimateImpl>(
          this, _$identity);
}

abstract class _DurationEstimate implements DurationEstimate {
  const factory _DurationEstimate(
      {required final int totalSeconds,
      required final Map<String, int> sceneDurations,
      required final String formattedDuration,
      required final String platformRecommendation,
      required final double estimatedFileSizeMB}) = _$DurationEstimateImpl;

  @override
  int get totalSeconds;
  @override
  Map<String, int> get sceneDurations;
  @override // "intro": 3, "battle": 4...
  String get formattedDuration;
  @override // "0:18"
  String get platformRecommendation;
  @override // "Perfect for TikTok"
  double get estimatedFileSizeMB;
  @override
  @JsonKey(ignore: true)
  _$$DurationEstimateImplCopyWith<_$DurationEstimateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
