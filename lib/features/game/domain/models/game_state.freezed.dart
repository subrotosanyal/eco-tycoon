// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameState {
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get gameOver => throw _privateConstructorUsedError;
  bool get victory => throw _privateConstructorUsedError;
  int get elapsedTime => throw _privateConstructorUsedError;
  PlanetState get planetState => throw _privateConstructorUsedError;
  GameResources get resources => throw _privateConstructorUsedError;
  List<TreePosition> get treePositions => throw _privateConstructorUsedError;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {bool isPlaying,
      bool gameOver,
      bool victory,
      int elapsedTime,
      PlanetState planetState,
      GameResources resources,
      List<TreePosition> treePositions});

  $PlanetStateCopyWith<$Res> get planetState;
  $GameResourcesCopyWith<$Res> get resources;
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
    Object? gameOver = null,
    Object? victory = null,
    Object? elapsedTime = null,
    Object? planetState = null,
    Object? resources = null,
    Object? treePositions = null,
  }) {
    return _then(_value.copyWith(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      gameOver: null == gameOver
          ? _value.gameOver
          : gameOver // ignore: cast_nullable_to_non_nullable
              as bool,
      victory: null == victory
          ? _value.victory
          : victory // ignore: cast_nullable_to_non_nullable
              as bool,
      elapsedTime: null == elapsedTime
          ? _value.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as int,
      planetState: null == planetState
          ? _value.planetState
          : planetState // ignore: cast_nullable_to_non_nullable
              as PlanetState,
      resources: null == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as GameResources,
      treePositions: null == treePositions
          ? _value.treePositions
          : treePositions // ignore: cast_nullable_to_non_nullable
              as List<TreePosition>,
    ) as $Val);
  }

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlanetStateCopyWith<$Res> get planetState {
    return $PlanetStateCopyWith<$Res>(_value.planetState, (value) {
      return _then(_value.copyWith(planetState: value) as $Val);
    });
  }

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GameResourcesCopyWith<$Res> get resources {
    return $GameResourcesCopyWith<$Res>(_value.resources, (value) {
      return _then(_value.copyWith(resources: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isPlaying,
      bool gameOver,
      bool victory,
      int elapsedTime,
      PlanetState planetState,
      GameResources resources,
      List<TreePosition> treePositions});

  @override
  $PlanetStateCopyWith<$Res> get planetState;
  @override
  $GameResourcesCopyWith<$Res> get resources;
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
    Object? gameOver = null,
    Object? victory = null,
    Object? elapsedTime = null,
    Object? planetState = null,
    Object? resources = null,
    Object? treePositions = null,
  }) {
    return _then(_$GameStateImpl(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      gameOver: null == gameOver
          ? _value.gameOver
          : gameOver // ignore: cast_nullable_to_non_nullable
              as bool,
      victory: null == victory
          ? _value.victory
          : victory // ignore: cast_nullable_to_non_nullable
              as bool,
      elapsedTime: null == elapsedTime
          ? _value.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as int,
      planetState: null == planetState
          ? _value.planetState
          : planetState // ignore: cast_nullable_to_non_nullable
              as PlanetState,
      resources: null == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as GameResources,
      treePositions: null == treePositions
          ? _value._treePositions
          : treePositions // ignore: cast_nullable_to_non_nullable
              as List<TreePosition>,
    ));
  }
}

/// @nodoc

class _$GameStateImpl implements _GameState {
  const _$GameStateImpl(
      {this.isPlaying = false,
      this.gameOver = false,
      this.victory = false,
      this.elapsedTime = 0,
      required this.planetState,
      required this.resources,
      required final List<TreePosition> treePositions})
      : _treePositions = treePositions;

  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final bool gameOver;
  @override
  @JsonKey()
  final bool victory;
  @override
  @JsonKey()
  final int elapsedTime;
  @override
  final PlanetState planetState;
  @override
  final GameResources resources;
  final List<TreePosition> _treePositions;
  @override
  List<TreePosition> get treePositions {
    if (_treePositions is EqualUnmodifiableListView) return _treePositions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_treePositions);
  }

  @override
  String toString() {
    return 'GameState(isPlaying: $isPlaying, gameOver: $gameOver, victory: $victory, elapsedTime: $elapsedTime, planetState: $planetState, resources: $resources, treePositions: $treePositions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.gameOver, gameOver) ||
                other.gameOver == gameOver) &&
            (identical(other.victory, victory) || other.victory == victory) &&
            (identical(other.elapsedTime, elapsedTime) ||
                other.elapsedTime == elapsedTime) &&
            (identical(other.planetState, planetState) ||
                other.planetState == planetState) &&
            (identical(other.resources, resources) ||
                other.resources == resources) &&
            const DeepCollectionEquality()
                .equals(other._treePositions, _treePositions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isPlaying,
      gameOver,
      victory,
      elapsedTime,
      planetState,
      resources,
      const DeepCollectionEquality().hash(_treePositions));

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {final bool isPlaying,
      final bool gameOver,
      final bool victory,
      final int elapsedTime,
      required final PlanetState planetState,
      required final GameResources resources,
      required final List<TreePosition> treePositions}) = _$GameStateImpl;

  @override
  bool get isPlaying;
  @override
  bool get gameOver;
  @override
  bool get victory;
  @override
  int get elapsedTime;
  @override
  PlanetState get planetState;
  @override
  GameResources get resources;
  @override
  List<TreePosition> get treePositions;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
