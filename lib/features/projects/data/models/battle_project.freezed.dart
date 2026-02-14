// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BattleProject _$BattleProjectFromJson(Map<String, dynamic> json) {
  return _BattleProject.fromJson(json);
}

/// @nodoc
mixin _$BattleProject {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get nameAr => throw _privateConstructorUsedError;
  @HiveField(3)
  String get description => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get lastUsed => throw _privateConstructorUsedError; // Configuration
  @HiveField(6)
  List<String> get contestants => throw _privateConstructorUsedError;
  @HiveField(7)
  String get theme =>
      throw _privateConstructorUsedError; // AI Mix (The Providers)
  @HiveField(8)
  ProviderMix get providerMix => throw _privateConstructorUsedError; // Settings
  @HiveField(9)
  VideoSettings get videoSettings => throw _privateConstructorUsedError;
  @HiveField(10)
  BudgetMode get budgetMode => throw _privateConstructorUsedError; // Stats
  @HiveField(11)
  int get generationCount => throw _privateConstructorUsedError;
  @HiveField(12)
  double get totalSpent => throw _privateConstructorUsedError;
  @HiveField(13)
  double get averageQuality => throw _privateConstructorUsedError;
  @HiveField(14)
  String? get thumbnailPath => throw _privateConstructorUsedError;
  @HiveField(15)
  List<String> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BattleProjectCopyWith<BattleProject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleProjectCopyWith<$Res> {
  factory $BattleProjectCopyWith(
          BattleProject value, $Res Function(BattleProject) then) =
      _$BattleProjectCopyWithImpl<$Res, BattleProject>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String nameAr,
      @HiveField(3) String description,
      @HiveField(4) DateTime createdAt,
      @HiveField(5) DateTime lastUsed,
      @HiveField(6) List<String> contestants,
      @HiveField(7) String theme,
      @HiveField(8) ProviderMix providerMix,
      @HiveField(9) VideoSettings videoSettings,
      @HiveField(10) BudgetMode budgetMode,
      @HiveField(11) int generationCount,
      @HiveField(12) double totalSpent,
      @HiveField(13) double averageQuality,
      @HiveField(14) String? thumbnailPath,
      @HiveField(15) List<String> tags});

  $ProviderMixCopyWith<$Res> get providerMix;
  $VideoSettingsCopyWith<$Res> get videoSettings;
}

/// @nodoc
class _$BattleProjectCopyWithImpl<$Res, $Val extends BattleProject>
    implements $BattleProjectCopyWith<$Res> {
  _$BattleProjectCopyWithImpl(this._value, this._then);

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
    Object? description = null,
    Object? createdAt = null,
    Object? lastUsed = null,
    Object? contestants = null,
    Object? theme = null,
    Object? providerMix = null,
    Object? videoSettings = null,
    Object? budgetMode = null,
    Object? generationCount = null,
    Object? totalSpent = null,
    Object? averageQuality = null,
    Object? thumbnailPath = freezed,
    Object? tags = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUsed: null == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      contestants: null == contestants
          ? _value.contestants
          : contestants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      providerMix: null == providerMix
          ? _value.providerMix
          : providerMix // ignore: cast_nullable_to_non_nullable
              as ProviderMix,
      videoSettings: null == videoSettings
          ? _value.videoSettings
          : videoSettings // ignore: cast_nullable_to_non_nullable
              as VideoSettings,
      budgetMode: null == budgetMode
          ? _value.budgetMode
          : budgetMode // ignore: cast_nullable_to_non_nullable
              as BudgetMode,
      generationCount: null == generationCount
          ? _value.generationCount
          : generationCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      averageQuality: null == averageQuality
          ? _value.averageQuality
          : averageQuality // ignore: cast_nullable_to_non_nullable
              as double,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProviderMixCopyWith<$Res> get providerMix {
    return $ProviderMixCopyWith<$Res>(_value.providerMix, (value) {
      return _then(_value.copyWith(providerMix: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VideoSettingsCopyWith<$Res> get videoSettings {
    return $VideoSettingsCopyWith<$Res>(_value.videoSettings, (value) {
      return _then(_value.copyWith(videoSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BattleProjectImplCopyWith<$Res>
    implements $BattleProjectCopyWith<$Res> {
  factory _$$BattleProjectImplCopyWith(
          _$BattleProjectImpl value, $Res Function(_$BattleProjectImpl) then) =
      __$$BattleProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String nameAr,
      @HiveField(3) String description,
      @HiveField(4) DateTime createdAt,
      @HiveField(5) DateTime lastUsed,
      @HiveField(6) List<String> contestants,
      @HiveField(7) String theme,
      @HiveField(8) ProviderMix providerMix,
      @HiveField(9) VideoSettings videoSettings,
      @HiveField(10) BudgetMode budgetMode,
      @HiveField(11) int generationCount,
      @HiveField(12) double totalSpent,
      @HiveField(13) double averageQuality,
      @HiveField(14) String? thumbnailPath,
      @HiveField(15) List<String> tags});

  @override
  $ProviderMixCopyWith<$Res> get providerMix;
  @override
  $VideoSettingsCopyWith<$Res> get videoSettings;
}

/// @nodoc
class __$$BattleProjectImplCopyWithImpl<$Res>
    extends _$BattleProjectCopyWithImpl<$Res, _$BattleProjectImpl>
    implements _$$BattleProjectImplCopyWith<$Res> {
  __$$BattleProjectImplCopyWithImpl(
      _$BattleProjectImpl _value, $Res Function(_$BattleProjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? description = null,
    Object? createdAt = null,
    Object? lastUsed = null,
    Object? contestants = null,
    Object? theme = null,
    Object? providerMix = null,
    Object? videoSettings = null,
    Object? budgetMode = null,
    Object? generationCount = null,
    Object? totalSpent = null,
    Object? averageQuality = null,
    Object? thumbnailPath = freezed,
    Object? tags = null,
  }) {
    return _then(_$BattleProjectImpl(
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUsed: null == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      contestants: null == contestants
          ? _value._contestants
          : contestants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      providerMix: null == providerMix
          ? _value.providerMix
          : providerMix // ignore: cast_nullable_to_non_nullable
              as ProviderMix,
      videoSettings: null == videoSettings
          ? _value.videoSettings
          : videoSettings // ignore: cast_nullable_to_non_nullable
              as VideoSettings,
      budgetMode: null == budgetMode
          ? _value.budgetMode
          : budgetMode // ignore: cast_nullable_to_non_nullable
              as BudgetMode,
      generationCount: null == generationCount
          ? _value.generationCount
          : generationCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      averageQuality: null == averageQuality
          ? _value.averageQuality
          : averageQuality // ignore: cast_nullable_to_non_nullable
              as double,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 10)
class _$BattleProjectImpl implements _BattleProject {
  const _$BattleProjectImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.nameAr,
      @HiveField(3) required this.description,
      @HiveField(4) required this.createdAt,
      @HiveField(5) required this.lastUsed,
      @HiveField(6) required final List<String> contestants,
      @HiveField(7) this.theme = 'nature',
      @HiveField(8) required this.providerMix,
      @HiveField(9) required this.videoSettings,
      @HiveField(10) required this.budgetMode,
      @HiveField(11) this.generationCount = 0,
      @HiveField(12) this.totalSpent = 0.0,
      @HiveField(13) this.averageQuality = 0.0,
      @HiveField(14) this.thumbnailPath,
      @HiveField(15) final List<String> tags = const []})
      : _contestants = contestants,
        _tags = tags;

  factory _$BattleProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleProjectImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String nameAr;
  @override
  @HiveField(3)
  final String description;
  @override
  @HiveField(4)
  final DateTime createdAt;
  @override
  @HiveField(5)
  final DateTime lastUsed;
// Configuration
  final List<String> _contestants;
// Configuration
  @override
  @HiveField(6)
  List<String> get contestants {
    if (_contestants is EqualUnmodifiableListView) return _contestants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contestants);
  }

  @override
  @JsonKey()
  @HiveField(7)
  final String theme;
// AI Mix (The Providers)
  @override
  @HiveField(8)
  final ProviderMix providerMix;
// Settings
  @override
  @HiveField(9)
  final VideoSettings videoSettings;
  @override
  @HiveField(10)
  final BudgetMode budgetMode;
// Stats
  @override
  @JsonKey()
  @HiveField(11)
  final int generationCount;
  @override
  @JsonKey()
  @HiveField(12)
  final double totalSpent;
  @override
  @JsonKey()
  @HiveField(13)
  final double averageQuality;
  @override
  @HiveField(14)
  final String? thumbnailPath;
  final List<String> _tags;
  @override
  @JsonKey()
  @HiveField(15)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'BattleProject(id: $id, name: $name, nameAr: $nameAr, description: $description, createdAt: $createdAt, lastUsed: $lastUsed, contestants: $contestants, theme: $theme, providerMix: $providerMix, videoSettings: $videoSettings, budgetMode: $budgetMode, generationCount: $generationCount, totalSpent: $totalSpent, averageQuality: $averageQuality, thumbnailPath: $thumbnailPath, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed) &&
            const DeepCollectionEquality()
                .equals(other._contestants, _contestants) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.providerMix, providerMix) ||
                other.providerMix == providerMix) &&
            (identical(other.videoSettings, videoSettings) ||
                other.videoSettings == videoSettings) &&
            (identical(other.budgetMode, budgetMode) ||
                other.budgetMode == budgetMode) &&
            (identical(other.generationCount, generationCount) ||
                other.generationCount == generationCount) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.averageQuality, averageQuality) ||
                other.averageQuality == averageQuality) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      nameAr,
      description,
      createdAt,
      lastUsed,
      const DeepCollectionEquality().hash(_contestants),
      theme,
      providerMix,
      videoSettings,
      budgetMode,
      generationCount,
      totalSpent,
      averageQuality,
      thumbnailPath,
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleProjectImplCopyWith<_$BattleProjectImpl> get copyWith =>
      __$$BattleProjectImplCopyWithImpl<_$BattleProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleProjectImplToJson(
      this,
    );
  }
}

abstract class _BattleProject implements BattleProject {
  const factory _BattleProject(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String nameAr,
      @HiveField(3) required final String description,
      @HiveField(4) required final DateTime createdAt,
      @HiveField(5) required final DateTime lastUsed,
      @HiveField(6) required final List<String> contestants,
      @HiveField(7) final String theme,
      @HiveField(8) required final ProviderMix providerMix,
      @HiveField(9) required final VideoSettings videoSettings,
      @HiveField(10) required final BudgetMode budgetMode,
      @HiveField(11) final int generationCount,
      @HiveField(12) final double totalSpent,
      @HiveField(13) final double averageQuality,
      @HiveField(14) final String? thumbnailPath,
      @HiveField(15) final List<String> tags}) = _$BattleProjectImpl;

  factory _BattleProject.fromJson(Map<String, dynamic> json) =
      _$BattleProjectImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get nameAr;
  @override
  @HiveField(3)
  String get description;
  @override
  @HiveField(4)
  DateTime get createdAt;
  @override
  @HiveField(5)
  DateTime get lastUsed;
  @override // Configuration
  @HiveField(6)
  List<String> get contestants;
  @override
  @HiveField(7)
  String get theme;
  @override // AI Mix (The Providers)
  @HiveField(8)
  ProviderMix get providerMix;
  @override // Settings
  @HiveField(9)
  VideoSettings get videoSettings;
  @override
  @HiveField(10)
  BudgetMode get budgetMode;
  @override // Stats
  @HiveField(11)
  int get generationCount;
  @override
  @HiveField(12)
  double get totalSpent;
  @override
  @HiveField(13)
  double get averageQuality;
  @override
  @HiveField(14)
  String? get thumbnailPath;
  @override
  @HiveField(15)
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$$BattleProjectImplCopyWith<_$BattleProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProviderMix _$ProviderMixFromJson(Map<String, dynamic> json) {
  return _ProviderMix.fromJson(json);
}

/// @nodoc
mixin _$ProviderMix {
  @HiveField(0)
  String? get ideaProvider => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get scriptProvider => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get imageProvider => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get videoProvider => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get useSmartRouting => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProviderMixCopyWith<ProviderMix> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderMixCopyWith<$Res> {
  factory $ProviderMixCopyWith(
          ProviderMix value, $Res Function(ProviderMix) then) =
      _$ProviderMixCopyWithImpl<$Res, ProviderMix>;
  @useResult
  $Res call(
      {@HiveField(0) String? ideaProvider,
      @HiveField(1) String? scriptProvider,
      @HiveField(2) String? imageProvider,
      @HiveField(3) String? videoProvider,
      @HiveField(4) bool useSmartRouting});
}

/// @nodoc
class _$ProviderMixCopyWithImpl<$Res, $Val extends ProviderMix>
    implements $ProviderMixCopyWith<$Res> {
  _$ProviderMixCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ideaProvider = freezed,
    Object? scriptProvider = freezed,
    Object? imageProvider = freezed,
    Object? videoProvider = freezed,
    Object? useSmartRouting = null,
  }) {
    return _then(_value.copyWith(
      ideaProvider: freezed == ideaProvider
          ? _value.ideaProvider
          : ideaProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      scriptProvider: freezed == scriptProvider
          ? _value.scriptProvider
          : scriptProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      imageProvider: freezed == imageProvider
          ? _value.imageProvider
          : imageProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      videoProvider: freezed == videoProvider
          ? _value.videoProvider
          : videoProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      useSmartRouting: null == useSmartRouting
          ? _value.useSmartRouting
          : useSmartRouting // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProviderMixImplCopyWith<$Res>
    implements $ProviderMixCopyWith<$Res> {
  factory _$$ProviderMixImplCopyWith(
          _$ProviderMixImpl value, $Res Function(_$ProviderMixImpl) then) =
      __$$ProviderMixImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? ideaProvider,
      @HiveField(1) String? scriptProvider,
      @HiveField(2) String? imageProvider,
      @HiveField(3) String? videoProvider,
      @HiveField(4) bool useSmartRouting});
}

/// @nodoc
class __$$ProviderMixImplCopyWithImpl<$Res>
    extends _$ProviderMixCopyWithImpl<$Res, _$ProviderMixImpl>
    implements _$$ProviderMixImplCopyWith<$Res> {
  __$$ProviderMixImplCopyWithImpl(
      _$ProviderMixImpl _value, $Res Function(_$ProviderMixImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ideaProvider = freezed,
    Object? scriptProvider = freezed,
    Object? imageProvider = freezed,
    Object? videoProvider = freezed,
    Object? useSmartRouting = null,
  }) {
    return _then(_$ProviderMixImpl(
      ideaProvider: freezed == ideaProvider
          ? _value.ideaProvider
          : ideaProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      scriptProvider: freezed == scriptProvider
          ? _value.scriptProvider
          : scriptProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      imageProvider: freezed == imageProvider
          ? _value.imageProvider
          : imageProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      videoProvider: freezed == videoProvider
          ? _value.videoProvider
          : videoProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      useSmartRouting: null == useSmartRouting
          ? _value.useSmartRouting
          : useSmartRouting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 11)
class _$ProviderMixImpl implements _ProviderMix {
  const _$ProviderMixImpl(
      {@HiveField(0) this.ideaProvider,
      @HiveField(1) this.scriptProvider,
      @HiveField(2) this.imageProvider,
      @HiveField(3) this.videoProvider,
      @HiveField(4) this.useSmartRouting = true});

  factory _$ProviderMixImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProviderMixImplFromJson(json);

  @override
  @HiveField(0)
  final String? ideaProvider;
  @override
  @HiveField(1)
  final String? scriptProvider;
  @override
  @HiveField(2)
  final String? imageProvider;
  @override
  @HiveField(3)
  final String? videoProvider;
  @override
  @JsonKey()
  @HiveField(4)
  final bool useSmartRouting;

  @override
  String toString() {
    return 'ProviderMix(ideaProvider: $ideaProvider, scriptProvider: $scriptProvider, imageProvider: $imageProvider, videoProvider: $videoProvider, useSmartRouting: $useSmartRouting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProviderMixImpl &&
            (identical(other.ideaProvider, ideaProvider) ||
                other.ideaProvider == ideaProvider) &&
            (identical(other.scriptProvider, scriptProvider) ||
                other.scriptProvider == scriptProvider) &&
            (identical(other.imageProvider, imageProvider) ||
                other.imageProvider == imageProvider) &&
            (identical(other.videoProvider, videoProvider) ||
                other.videoProvider == videoProvider) &&
            (identical(other.useSmartRouting, useSmartRouting) ||
                other.useSmartRouting == useSmartRouting));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ideaProvider, scriptProvider,
      imageProvider, videoProvider, useSmartRouting);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProviderMixImplCopyWith<_$ProviderMixImpl> get copyWith =>
      __$$ProviderMixImplCopyWithImpl<_$ProviderMixImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProviderMixImplToJson(
      this,
    );
  }
}

abstract class _ProviderMix implements ProviderMix {
  const factory _ProviderMix(
      {@HiveField(0) final String? ideaProvider,
      @HiveField(1) final String? scriptProvider,
      @HiveField(2) final String? imageProvider,
      @HiveField(3) final String? videoProvider,
      @HiveField(4) final bool useSmartRouting}) = _$ProviderMixImpl;

  factory _ProviderMix.fromJson(Map<String, dynamic> json) =
      _$ProviderMixImpl.fromJson;

  @override
  @HiveField(0)
  String? get ideaProvider;
  @override
  @HiveField(1)
  String? get scriptProvider;
  @override
  @HiveField(2)
  String? get imageProvider;
  @override
  @HiveField(3)
  String? get videoProvider;
  @override
  @HiveField(4)
  bool get useSmartRouting;
  @override
  @JsonKey(ignore: true)
  _$$ProviderMixImplCopyWith<_$ProviderMixImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VideoSettings _$VideoSettingsFromJson(Map<String, dynamic> json) {
  return _VideoSettings.fromJson(json);
}

/// @nodoc
mixin _$VideoSettings {
  @HiveField(0)
  String get aspectRatio => throw _privateConstructorUsedError;
  @HiveField(1)
  String get resolution => throw _privateConstructorUsedError;
  @HiveField(2)
  int get fps => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get slowMotion => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get includeVoiceover => throw _privateConstructorUsedError;
  @HiveField(5)
  String get style => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoSettingsCopyWith<VideoSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoSettingsCopyWith<$Res> {
  factory $VideoSettingsCopyWith(
          VideoSettings value, $Res Function(VideoSettings) then) =
      _$VideoSettingsCopyWithImpl<$Res, VideoSettings>;
  @useResult
  $Res call(
      {@HiveField(0) String aspectRatio,
      @HiveField(1) String resolution,
      @HiveField(2) int fps,
      @HiveField(3) bool slowMotion,
      @HiveField(4) bool includeVoiceover,
      @HiveField(5) String style});
}

/// @nodoc
class _$VideoSettingsCopyWithImpl<$Res, $Val extends VideoSettings>
    implements $VideoSettingsCopyWith<$Res> {
  _$VideoSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? aspectRatio = null,
    Object? resolution = null,
    Object? fps = null,
    Object? slowMotion = null,
    Object? includeVoiceover = null,
    Object? style = null,
  }) {
    return _then(_value.copyWith(
      aspectRatio: null == aspectRatio
          ? _value.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
      fps: null == fps
          ? _value.fps
          : fps // ignore: cast_nullable_to_non_nullable
              as int,
      slowMotion: null == slowMotion
          ? _value.slowMotion
          : slowMotion // ignore: cast_nullable_to_non_nullable
              as bool,
      includeVoiceover: null == includeVoiceover
          ? _value.includeVoiceover
          : includeVoiceover // ignore: cast_nullable_to_non_nullable
              as bool,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoSettingsImplCopyWith<$Res>
    implements $VideoSettingsCopyWith<$Res> {
  factory _$$VideoSettingsImplCopyWith(
          _$VideoSettingsImpl value, $Res Function(_$VideoSettingsImpl) then) =
      __$$VideoSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String aspectRatio,
      @HiveField(1) String resolution,
      @HiveField(2) int fps,
      @HiveField(3) bool slowMotion,
      @HiveField(4) bool includeVoiceover,
      @HiveField(5) String style});
}

/// @nodoc
class __$$VideoSettingsImplCopyWithImpl<$Res>
    extends _$VideoSettingsCopyWithImpl<$Res, _$VideoSettingsImpl>
    implements _$$VideoSettingsImplCopyWith<$Res> {
  __$$VideoSettingsImplCopyWithImpl(
      _$VideoSettingsImpl _value, $Res Function(_$VideoSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? aspectRatio = null,
    Object? resolution = null,
    Object? fps = null,
    Object? slowMotion = null,
    Object? includeVoiceover = null,
    Object? style = null,
  }) {
    return _then(_$VideoSettingsImpl(
      aspectRatio: null == aspectRatio
          ? _value.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: null == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
      fps: null == fps
          ? _value.fps
          : fps // ignore: cast_nullable_to_non_nullable
              as int,
      slowMotion: null == slowMotion
          ? _value.slowMotion
          : slowMotion // ignore: cast_nullable_to_non_nullable
              as bool,
      includeVoiceover: null == includeVoiceover
          ? _value.includeVoiceover
          : includeVoiceover // ignore: cast_nullable_to_non_nullable
              as bool,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 12)
class _$VideoSettingsImpl implements _VideoSettings {
  const _$VideoSettingsImpl(
      {@HiveField(0) this.aspectRatio = '16:9',
      @HiveField(1) this.resolution = '1080p',
      @HiveField(2) this.fps = 24,
      @HiveField(3) this.slowMotion = false,
      @HiveField(4) this.includeVoiceover = true,
      @HiveField(5) this.style = 'cinematic'});

  factory _$VideoSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoSettingsImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final String aspectRatio;
  @override
  @JsonKey()
  @HiveField(1)
  final String resolution;
  @override
  @JsonKey()
  @HiveField(2)
  final int fps;
  @override
  @JsonKey()
  @HiveField(3)
  final bool slowMotion;
  @override
  @JsonKey()
  @HiveField(4)
  final bool includeVoiceover;
  @override
  @JsonKey()
  @HiveField(5)
  final String style;

  @override
  String toString() {
    return 'VideoSettings(aspectRatio: $aspectRatio, resolution: $resolution, fps: $fps, slowMotion: $slowMotion, includeVoiceover: $includeVoiceover, style: $style)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoSettingsImpl &&
            (identical(other.aspectRatio, aspectRatio) ||
                other.aspectRatio == aspectRatio) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.fps, fps) || other.fps == fps) &&
            (identical(other.slowMotion, slowMotion) ||
                other.slowMotion == slowMotion) &&
            (identical(other.includeVoiceover, includeVoiceover) ||
                other.includeVoiceover == includeVoiceover) &&
            (identical(other.style, style) || other.style == style));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, aspectRatio, resolution, fps,
      slowMotion, includeVoiceover, style);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoSettingsImplCopyWith<_$VideoSettingsImpl> get copyWith =>
      __$$VideoSettingsImplCopyWithImpl<_$VideoSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoSettingsImplToJson(
      this,
    );
  }
}

abstract class _VideoSettings implements VideoSettings {
  const factory _VideoSettings(
      {@HiveField(0) final String aspectRatio,
      @HiveField(1) final String resolution,
      @HiveField(2) final int fps,
      @HiveField(3) final bool slowMotion,
      @HiveField(4) final bool includeVoiceover,
      @HiveField(5) final String style}) = _$VideoSettingsImpl;

  factory _VideoSettings.fromJson(Map<String, dynamic> json) =
      _$VideoSettingsImpl.fromJson;

  @override
  @HiveField(0)
  String get aspectRatio;
  @override
  @HiveField(1)
  String get resolution;
  @override
  @HiveField(2)
  int get fps;
  @override
  @HiveField(3)
  bool get slowMotion;
  @override
  @HiveField(4)
  bool get includeVoiceover;
  @override
  @HiveField(5)
  String get style;
  @override
  @JsonKey(ignore: true)
  _$$VideoSettingsImplCopyWith<_$VideoSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
