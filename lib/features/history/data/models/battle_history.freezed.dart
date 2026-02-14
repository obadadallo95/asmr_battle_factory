// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BattleHistory _$BattleHistoryFromJson(Map<String, dynamic> json) {
  return _BattleHistory.fromJson(json);
}

/// @nodoc
mixin _$BattleHistory {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  DateTime get timestamp => throw _privateConstructorUsedError;
  @HiveField(2)
  List<String> get contestantNames => throw _privateConstructorUsedError;
  @HiveField(3)
  String get winner => throw _privateConstructorUsedError;
  @HiveField(4)
  double get actualCost => throw _privateConstructorUsedError;
  @HiveField(5)
  String get scriptTitle => throw _privateConstructorUsedError;
  @HiveField(6)
  bool get wasSavedToVault => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get videoPath => throw _privateConstructorUsedError;
  @HiveField(8)
  String get style => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BattleHistoryCopyWith<BattleHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleHistoryCopyWith<$Res> {
  factory $BattleHistoryCopyWith(
          BattleHistory value, $Res Function(BattleHistory) then) =
      _$BattleHistoryCopyWithImpl<$Res, BattleHistory>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) DateTime timestamp,
      @HiveField(2) List<String> contestantNames,
      @HiveField(3) String winner,
      @HiveField(4) double actualCost,
      @HiveField(5) String scriptTitle,
      @HiveField(6) bool wasSavedToVault,
      @HiveField(7) String? videoPath,
      @HiveField(8) String style});
}

/// @nodoc
class _$BattleHistoryCopyWithImpl<$Res, $Val extends BattleHistory>
    implements $BattleHistoryCopyWith<$Res> {
  _$BattleHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? contestantNames = null,
    Object? winner = null,
    Object? actualCost = null,
    Object? scriptTitle = null,
    Object? wasSavedToVault = null,
    Object? videoPath = freezed,
    Object? style = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      contestantNames: null == contestantNames
          ? _value.contestantNames
          : contestantNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      winner: null == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as String,
      actualCost: null == actualCost
          ? _value.actualCost
          : actualCost // ignore: cast_nullable_to_non_nullable
              as double,
      scriptTitle: null == scriptTitle
          ? _value.scriptTitle
          : scriptTitle // ignore: cast_nullable_to_non_nullable
              as String,
      wasSavedToVault: null == wasSavedToVault
          ? _value.wasSavedToVault
          : wasSavedToVault // ignore: cast_nullable_to_non_nullable
              as bool,
      videoPath: freezed == videoPath
          ? _value.videoPath
          : videoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattleHistoryImplCopyWith<$Res>
    implements $BattleHistoryCopyWith<$Res> {
  factory _$$BattleHistoryImplCopyWith(
          _$BattleHistoryImpl value, $Res Function(_$BattleHistoryImpl) then) =
      __$$BattleHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) DateTime timestamp,
      @HiveField(2) List<String> contestantNames,
      @HiveField(3) String winner,
      @HiveField(4) double actualCost,
      @HiveField(5) String scriptTitle,
      @HiveField(6) bool wasSavedToVault,
      @HiveField(7) String? videoPath,
      @HiveField(8) String style});
}

/// @nodoc
class __$$BattleHistoryImplCopyWithImpl<$Res>
    extends _$BattleHistoryCopyWithImpl<$Res, _$BattleHistoryImpl>
    implements _$$BattleHistoryImplCopyWith<$Res> {
  __$$BattleHistoryImplCopyWithImpl(
      _$BattleHistoryImpl _value, $Res Function(_$BattleHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? contestantNames = null,
    Object? winner = null,
    Object? actualCost = null,
    Object? scriptTitle = null,
    Object? wasSavedToVault = null,
    Object? videoPath = freezed,
    Object? style = null,
  }) {
    return _then(_$BattleHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      contestantNames: null == contestantNames
          ? _value._contestantNames
          : contestantNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      winner: null == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as String,
      actualCost: null == actualCost
          ? _value.actualCost
          : actualCost // ignore: cast_nullable_to_non_nullable
              as double,
      scriptTitle: null == scriptTitle
          ? _value.scriptTitle
          : scriptTitle // ignore: cast_nullable_to_non_nullable
              as String,
      wasSavedToVault: null == wasSavedToVault
          ? _value.wasSavedToVault
          : wasSavedToVault // ignore: cast_nullable_to_non_nullable
              as bool,
      videoPath: freezed == videoPath
          ? _value.videoPath
          : videoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 15)
class _$BattleHistoryImpl implements _BattleHistory {
  const _$BattleHistoryImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.timestamp,
      @HiveField(2) required final List<String> contestantNames,
      @HiveField(3) required this.winner,
      @HiveField(4) required this.actualCost,
      @HiveField(5) required this.scriptTitle,
      @HiveField(6) this.wasSavedToVault = false,
      @HiveField(7) this.videoPath,
      @HiveField(8) this.style = 'cinematic'})
      : _contestantNames = contestantNames;

  factory _$BattleHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleHistoryImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final DateTime timestamp;
  final List<String> _contestantNames;
  @override
  @HiveField(2)
  List<String> get contestantNames {
    if (_contestantNames is EqualUnmodifiableListView) return _contestantNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contestantNames);
  }

  @override
  @HiveField(3)
  final String winner;
  @override
  @HiveField(4)
  final double actualCost;
  @override
  @HiveField(5)
  final String scriptTitle;
  @override
  @JsonKey()
  @HiveField(6)
  final bool wasSavedToVault;
  @override
  @HiveField(7)
  final String? videoPath;
  @override
  @JsonKey()
  @HiveField(8)
  final String style;

  @override
  String toString() {
    return 'BattleHistory(id: $id, timestamp: $timestamp, contestantNames: $contestantNames, winner: $winner, actualCost: $actualCost, scriptTitle: $scriptTitle, wasSavedToVault: $wasSavedToVault, videoPath: $videoPath, style: $style)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._contestantNames, _contestantNames) &&
            (identical(other.winner, winner) || other.winner == winner) &&
            (identical(other.actualCost, actualCost) ||
                other.actualCost == actualCost) &&
            (identical(other.scriptTitle, scriptTitle) ||
                other.scriptTitle == scriptTitle) &&
            (identical(other.wasSavedToVault, wasSavedToVault) ||
                other.wasSavedToVault == wasSavedToVault) &&
            (identical(other.videoPath, videoPath) ||
                other.videoPath == videoPath) &&
            (identical(other.style, style) || other.style == style));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timestamp,
      const DeepCollectionEquality().hash(_contestantNames),
      winner,
      actualCost,
      scriptTitle,
      wasSavedToVault,
      videoPath,
      style);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleHistoryImplCopyWith<_$BattleHistoryImpl> get copyWith =>
      __$$BattleHistoryImplCopyWithImpl<_$BattleHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleHistoryImplToJson(
      this,
    );
  }
}

abstract class _BattleHistory implements BattleHistory {
  const factory _BattleHistory(
      {@HiveField(0) required final String id,
      @HiveField(1) required final DateTime timestamp,
      @HiveField(2) required final List<String> contestantNames,
      @HiveField(3) required final String winner,
      @HiveField(4) required final double actualCost,
      @HiveField(5) required final String scriptTitle,
      @HiveField(6) final bool wasSavedToVault,
      @HiveField(7) final String? videoPath,
      @HiveField(8) final String style}) = _$BattleHistoryImpl;

  factory _BattleHistory.fromJson(Map<String, dynamic> json) =
      _$BattleHistoryImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  DateTime get timestamp;
  @override
  @HiveField(2)
  List<String> get contestantNames;
  @override
  @HiveField(3)
  String get winner;
  @override
  @HiveField(4)
  double get actualCost;
  @override
  @HiveField(5)
  String get scriptTitle;
  @override
  @HiveField(6)
  bool get wasSavedToVault;
  @override
  @HiveField(7)
  String? get videoPath;
  @override
  @HiveField(8)
  String get style;
  @override
  @JsonKey(ignore: true)
  _$$BattleHistoryImplCopyWith<_$BattleHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
