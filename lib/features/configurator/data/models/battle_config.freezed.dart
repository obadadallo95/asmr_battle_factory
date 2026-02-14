// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BattleConfig _$BattleConfigFromJson(Map<String, dynamic> json) {
  return _BattleConfig.fromJson(json);
}

/// @nodoc
mixin _$BattleConfig {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  List<String> get selectedContestantIds => throw _privateConstructorUsedError;
  @HiveField(2)
  WinnerMode get winnerMode => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get userSelectedWinnerId => throw _privateConstructorUsedError;
  @HiveField(4)
  BattleType get battleType => throw _privateConstructorUsedError;
  @HiveField(5)
  double get chaosLevel => throw _privateConstructorUsedError; // 0.0 - 1.0
  @HiveField(6)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BattleConfigCopyWith<BattleConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleConfigCopyWith<$Res> {
  factory $BattleConfigCopyWith(
          BattleConfig value, $Res Function(BattleConfig) then) =
      _$BattleConfigCopyWithImpl<$Res, BattleConfig>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) List<String> selectedContestantIds,
      @HiveField(2) WinnerMode winnerMode,
      @HiveField(3) String? userSelectedWinnerId,
      @HiveField(4) BattleType battleType,
      @HiveField(5) double chaosLevel,
      @HiveField(6) DateTime? createdAt});
}

/// @nodoc
class _$BattleConfigCopyWithImpl<$Res, $Val extends BattleConfig>
    implements $BattleConfigCopyWith<$Res> {
  _$BattleConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? selectedContestantIds = null,
    Object? winnerMode = null,
    Object? userSelectedWinnerId = freezed,
    Object? battleType = null,
    Object? chaosLevel = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      selectedContestantIds: null == selectedContestantIds
          ? _value.selectedContestantIds
          : selectedContestantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      winnerMode: null == winnerMode
          ? _value.winnerMode
          : winnerMode // ignore: cast_nullable_to_non_nullable
              as WinnerMode,
      userSelectedWinnerId: freezed == userSelectedWinnerId
          ? _value.userSelectedWinnerId
          : userSelectedWinnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      battleType: null == battleType
          ? _value.battleType
          : battleType // ignore: cast_nullable_to_non_nullable
              as BattleType,
      chaosLevel: null == chaosLevel
          ? _value.chaosLevel
          : chaosLevel // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattleConfigImplCopyWith<$Res>
    implements $BattleConfigCopyWith<$Res> {
  factory _$$BattleConfigImplCopyWith(
          _$BattleConfigImpl value, $Res Function(_$BattleConfigImpl) then) =
      __$$BattleConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) List<String> selectedContestantIds,
      @HiveField(2) WinnerMode winnerMode,
      @HiveField(3) String? userSelectedWinnerId,
      @HiveField(4) BattleType battleType,
      @HiveField(5) double chaosLevel,
      @HiveField(6) DateTime? createdAt});
}

/// @nodoc
class __$$BattleConfigImplCopyWithImpl<$Res>
    extends _$BattleConfigCopyWithImpl<$Res, _$BattleConfigImpl>
    implements _$$BattleConfigImplCopyWith<$Res> {
  __$$BattleConfigImplCopyWithImpl(
      _$BattleConfigImpl _value, $Res Function(_$BattleConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? selectedContestantIds = null,
    Object? winnerMode = null,
    Object? userSelectedWinnerId = freezed,
    Object? battleType = null,
    Object? chaosLevel = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$BattleConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      selectedContestantIds: null == selectedContestantIds
          ? _value._selectedContestantIds
          : selectedContestantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      winnerMode: null == winnerMode
          ? _value.winnerMode
          : winnerMode // ignore: cast_nullable_to_non_nullable
              as WinnerMode,
      userSelectedWinnerId: freezed == userSelectedWinnerId
          ? _value.userSelectedWinnerId
          : userSelectedWinnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      battleType: null == battleType
          ? _value.battleType
          : battleType // ignore: cast_nullable_to_non_nullable
              as BattleType,
      chaosLevel: null == chaosLevel
          ? _value.chaosLevel
          : chaosLevel // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 24)
class _$BattleConfigImpl implements _BattleConfig {
  const _$BattleConfigImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required final List<String> selectedContestantIds,
      @HiveField(2) this.winnerMode = WinnerMode.aiDecided,
      @HiveField(3) this.userSelectedWinnerId,
      @HiveField(4) this.battleType = BattleType.battleRoyale,
      @HiveField(5) this.chaosLevel = 0.5,
      @HiveField(6) this.createdAt})
      : _selectedContestantIds = selectedContestantIds;

  factory _$BattleConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleConfigImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  final List<String> _selectedContestantIds;
  @override
  @HiveField(1)
  List<String> get selectedContestantIds {
    if (_selectedContestantIds is EqualUnmodifiableListView)
      return _selectedContestantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedContestantIds);
  }

  @override
  @JsonKey()
  @HiveField(2)
  final WinnerMode winnerMode;
  @override
  @HiveField(3)
  final String? userSelectedWinnerId;
  @override
  @JsonKey()
  @HiveField(4)
  final BattleType battleType;
  @override
  @JsonKey()
  @HiveField(5)
  final double chaosLevel;
// 0.0 - 1.0
  @override
  @HiveField(6)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'BattleConfig(id: $id, selectedContestantIds: $selectedContestantIds, winnerMode: $winnerMode, userSelectedWinnerId: $userSelectedWinnerId, battleType: $battleType, chaosLevel: $chaosLevel, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._selectedContestantIds, _selectedContestantIds) &&
            (identical(other.winnerMode, winnerMode) ||
                other.winnerMode == winnerMode) &&
            (identical(other.userSelectedWinnerId, userSelectedWinnerId) ||
                other.userSelectedWinnerId == userSelectedWinnerId) &&
            (identical(other.battleType, battleType) ||
                other.battleType == battleType) &&
            (identical(other.chaosLevel, chaosLevel) ||
                other.chaosLevel == chaosLevel) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_selectedContestantIds),
      winnerMode,
      userSelectedWinnerId,
      battleType,
      chaosLevel,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleConfigImplCopyWith<_$BattleConfigImpl> get copyWith =>
      __$$BattleConfigImplCopyWithImpl<_$BattleConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleConfigImplToJson(
      this,
    );
  }
}

abstract class _BattleConfig implements BattleConfig {
  const factory _BattleConfig(
      {@HiveField(0) required final String id,
      @HiveField(1) required final List<String> selectedContestantIds,
      @HiveField(2) final WinnerMode winnerMode,
      @HiveField(3) final String? userSelectedWinnerId,
      @HiveField(4) final BattleType battleType,
      @HiveField(5) final double chaosLevel,
      @HiveField(6) final DateTime? createdAt}) = _$BattleConfigImpl;

  factory _BattleConfig.fromJson(Map<String, dynamic> json) =
      _$BattleConfigImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  List<String> get selectedContestantIds;
  @override
  @HiveField(2)
  WinnerMode get winnerMode;
  @override
  @HiveField(3)
  String? get userSelectedWinnerId;
  @override
  @HiveField(4)
  BattleType get battleType;
  @override
  @HiveField(5)
  double get chaosLevel;
  @override // 0.0 - 1.0
  @HiveField(6)
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$BattleConfigImplCopyWith<_$BattleConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
