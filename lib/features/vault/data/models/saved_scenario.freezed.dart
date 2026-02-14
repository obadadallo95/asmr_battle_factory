// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_scenario.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SavedScenario _$SavedScenarioFromJson(Map<String, dynamic> json) {
  return _SavedScenario.fromJson(json);
}

/// @nodoc
mixin _$SavedScenario {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get titleAr => throw _privateConstructorUsedError;
  @HiveField(2)
  String get titleEn => throw _privateConstructorUsedError;
  @HiveField(3)
  String get briefDescriptionAr => throw _privateConstructorUsedError;
  @HiveField(4)
  String get briefDescriptionEn => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String> get contestantIds => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get savedAt => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get suggestedWinnerId => throw _privateConstructorUsedError;
  @HiveField(8)
  int get twistLevel => throw _privateConstructorUsedError; // 1-10
  @HiveField(9)
  String? get providerUsed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SavedScenarioCopyWith<SavedScenario> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedScenarioCopyWith<$Res> {
  factory $SavedScenarioCopyWith(
          SavedScenario value, $Res Function(SavedScenario) then) =
      _$SavedScenarioCopyWithImpl<$Res, SavedScenario>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String titleAr,
      @HiveField(2) String titleEn,
      @HiveField(3) String briefDescriptionAr,
      @HiveField(4) String briefDescriptionEn,
      @HiveField(5) List<String> contestantIds,
      @HiveField(6) DateTime savedAt,
      @HiveField(7) String? suggestedWinnerId,
      @HiveField(8) int twistLevel,
      @HiveField(9) String? providerUsed});
}

/// @nodoc
class _$SavedScenarioCopyWithImpl<$Res, $Val extends SavedScenario>
    implements $SavedScenarioCopyWith<$Res> {
  _$SavedScenarioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titleAr = null,
    Object? titleEn = null,
    Object? briefDescriptionAr = null,
    Object? briefDescriptionEn = null,
    Object? contestantIds = null,
    Object? savedAt = null,
    Object? suggestedWinnerId = freezed,
    Object? twistLevel = null,
    Object? providerUsed = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      titleAr: null == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String,
      titleEn: null == titleEn
          ? _value.titleEn
          : titleEn // ignore: cast_nullable_to_non_nullable
              as String,
      briefDescriptionAr: null == briefDescriptionAr
          ? _value.briefDescriptionAr
          : briefDescriptionAr // ignore: cast_nullable_to_non_nullable
              as String,
      briefDescriptionEn: null == briefDescriptionEn
          ? _value.briefDescriptionEn
          : briefDescriptionEn // ignore: cast_nullable_to_non_nullable
              as String,
      contestantIds: null == contestantIds
          ? _value.contestantIds
          : contestantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      savedAt: null == savedAt
          ? _value.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      suggestedWinnerId: freezed == suggestedWinnerId
          ? _value.suggestedWinnerId
          : suggestedWinnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      twistLevel: null == twistLevel
          ? _value.twistLevel
          : twistLevel // ignore: cast_nullable_to_non_nullable
              as int,
      providerUsed: freezed == providerUsed
          ? _value.providerUsed
          : providerUsed // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavedScenarioImplCopyWith<$Res>
    implements $SavedScenarioCopyWith<$Res> {
  factory _$$SavedScenarioImplCopyWith(
          _$SavedScenarioImpl value, $Res Function(_$SavedScenarioImpl) then) =
      __$$SavedScenarioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String titleAr,
      @HiveField(2) String titleEn,
      @HiveField(3) String briefDescriptionAr,
      @HiveField(4) String briefDescriptionEn,
      @HiveField(5) List<String> contestantIds,
      @HiveField(6) DateTime savedAt,
      @HiveField(7) String? suggestedWinnerId,
      @HiveField(8) int twistLevel,
      @HiveField(9) String? providerUsed});
}

/// @nodoc
class __$$SavedScenarioImplCopyWithImpl<$Res>
    extends _$SavedScenarioCopyWithImpl<$Res, _$SavedScenarioImpl>
    implements _$$SavedScenarioImplCopyWith<$Res> {
  __$$SavedScenarioImplCopyWithImpl(
      _$SavedScenarioImpl _value, $Res Function(_$SavedScenarioImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titleAr = null,
    Object? titleEn = null,
    Object? briefDescriptionAr = null,
    Object? briefDescriptionEn = null,
    Object? contestantIds = null,
    Object? savedAt = null,
    Object? suggestedWinnerId = freezed,
    Object? twistLevel = null,
    Object? providerUsed = freezed,
  }) {
    return _then(_$SavedScenarioImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      titleAr: null == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String,
      titleEn: null == titleEn
          ? _value.titleEn
          : titleEn // ignore: cast_nullable_to_non_nullable
              as String,
      briefDescriptionAr: null == briefDescriptionAr
          ? _value.briefDescriptionAr
          : briefDescriptionAr // ignore: cast_nullable_to_non_nullable
              as String,
      briefDescriptionEn: null == briefDescriptionEn
          ? _value.briefDescriptionEn
          : briefDescriptionEn // ignore: cast_nullable_to_non_nullable
              as String,
      contestantIds: null == contestantIds
          ? _value._contestantIds
          : contestantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      savedAt: null == savedAt
          ? _value.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      suggestedWinnerId: freezed == suggestedWinnerId
          ? _value.suggestedWinnerId
          : suggestedWinnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      twistLevel: null == twistLevel
          ? _value.twistLevel
          : twistLevel // ignore: cast_nullable_to_non_nullable
              as int,
      providerUsed: freezed == providerUsed
          ? _value.providerUsed
          : providerUsed // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 25)
class _$SavedScenarioImpl implements _SavedScenario {
  const _$SavedScenarioImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.titleAr,
      @HiveField(2) required this.titleEn,
      @HiveField(3) required this.briefDescriptionAr,
      @HiveField(4) required this.briefDescriptionEn,
      @HiveField(5) required final List<String> contestantIds,
      @HiveField(6) required this.savedAt,
      @HiveField(7) this.suggestedWinnerId,
      @HiveField(8) this.twistLevel = 5,
      @HiveField(9) this.providerUsed})
      : _contestantIds = contestantIds;

  factory _$SavedScenarioImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedScenarioImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String titleAr;
  @override
  @HiveField(2)
  final String titleEn;
  @override
  @HiveField(3)
  final String briefDescriptionAr;
  @override
  @HiveField(4)
  final String briefDescriptionEn;
  final List<String> _contestantIds;
  @override
  @HiveField(5)
  List<String> get contestantIds {
    if (_contestantIds is EqualUnmodifiableListView) return _contestantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contestantIds);
  }

  @override
  @HiveField(6)
  final DateTime savedAt;
  @override
  @HiveField(7)
  final String? suggestedWinnerId;
  @override
  @JsonKey()
  @HiveField(8)
  final int twistLevel;
// 1-10
  @override
  @HiveField(9)
  final String? providerUsed;

  @override
  String toString() {
    return 'SavedScenario(id: $id, titleAr: $titleAr, titleEn: $titleEn, briefDescriptionAr: $briefDescriptionAr, briefDescriptionEn: $briefDescriptionEn, contestantIds: $contestantIds, savedAt: $savedAt, suggestedWinnerId: $suggestedWinnerId, twistLevel: $twistLevel, providerUsed: $providerUsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedScenarioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.titleAr, titleAr) || other.titleAr == titleAr) &&
            (identical(other.titleEn, titleEn) || other.titleEn == titleEn) &&
            (identical(other.briefDescriptionAr, briefDescriptionAr) ||
                other.briefDescriptionAr == briefDescriptionAr) &&
            (identical(other.briefDescriptionEn, briefDescriptionEn) ||
                other.briefDescriptionEn == briefDescriptionEn) &&
            const DeepCollectionEquality()
                .equals(other._contestantIds, _contestantIds) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt) &&
            (identical(other.suggestedWinnerId, suggestedWinnerId) ||
                other.suggestedWinnerId == suggestedWinnerId) &&
            (identical(other.twistLevel, twistLevel) ||
                other.twistLevel == twistLevel) &&
            (identical(other.providerUsed, providerUsed) ||
                other.providerUsed == providerUsed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      titleAr,
      titleEn,
      briefDescriptionAr,
      briefDescriptionEn,
      const DeepCollectionEquality().hash(_contestantIds),
      savedAt,
      suggestedWinnerId,
      twistLevel,
      providerUsed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedScenarioImplCopyWith<_$SavedScenarioImpl> get copyWith =>
      __$$SavedScenarioImplCopyWithImpl<_$SavedScenarioImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedScenarioImplToJson(
      this,
    );
  }
}

abstract class _SavedScenario implements SavedScenario {
  const factory _SavedScenario(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String titleAr,
      @HiveField(2) required final String titleEn,
      @HiveField(3) required final String briefDescriptionAr,
      @HiveField(4) required final String briefDescriptionEn,
      @HiveField(5) required final List<String> contestantIds,
      @HiveField(6) required final DateTime savedAt,
      @HiveField(7) final String? suggestedWinnerId,
      @HiveField(8) final int twistLevel,
      @HiveField(9) final String? providerUsed}) = _$SavedScenarioImpl;

  factory _SavedScenario.fromJson(Map<String, dynamic> json) =
      _$SavedScenarioImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get titleAr;
  @override
  @HiveField(2)
  String get titleEn;
  @override
  @HiveField(3)
  String get briefDescriptionAr;
  @override
  @HiveField(4)
  String get briefDescriptionEn;
  @override
  @HiveField(5)
  List<String> get contestantIds;
  @override
  @HiveField(6)
  DateTime get savedAt;
  @override
  @HiveField(7)
  String? get suggestedWinnerId;
  @override
  @HiveField(8)
  int get twistLevel;
  @override // 1-10
  @HiveField(9)
  String? get providerUsed;
  @override
  @JsonKey(ignore: true)
  _$$SavedScenarioImplCopyWith<_$SavedScenarioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
