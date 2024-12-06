// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlanetState {
  int get score => throw _privateConstructorUsedError;
  int get pollution =>
      throw _privateConstructorUsedError; // Start with medium pollution
  int get trees => throw _privateConstructorUsedError;
  PlanetLevel get level => throw _privateConstructorUsedError;

  /// Create a copy of PlanetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanetStateCopyWith<PlanetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanetStateCopyWith<$Res> {
  factory $PlanetStateCopyWith(
          PlanetState value, $Res Function(PlanetState) then) =
      _$PlanetStateCopyWithImpl<$Res, PlanetState>;
  @useResult
  $Res call({int score, int pollution, int trees, PlanetLevel level});
}

/// @nodoc
class _$PlanetStateCopyWithImpl<$Res, $Val extends PlanetState>
    implements $PlanetStateCopyWith<$Res> {
  _$PlanetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? pollution = null,
    Object? trees = null,
    Object? level = null,
  }) {
    return _then(_value.copyWith(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      pollution: null == pollution
          ? _value.pollution
          : pollution // ignore: cast_nullable_to_non_nullable
              as int,
      trees: null == trees
          ? _value.trees
          : trees // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as PlanetLevel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlanetStateImplCopyWith<$Res>
    implements $PlanetStateCopyWith<$Res> {
  factory _$$PlanetStateImplCopyWith(
          _$PlanetStateImpl value, $Res Function(_$PlanetStateImpl) then) =
      __$$PlanetStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int score, int pollution, int trees, PlanetLevel level});
}

/// @nodoc
class __$$PlanetStateImplCopyWithImpl<$Res>
    extends _$PlanetStateCopyWithImpl<$Res, _$PlanetStateImpl>
    implements _$$PlanetStateImplCopyWith<$Res> {
  __$$PlanetStateImplCopyWithImpl(
      _$PlanetStateImpl _value, $Res Function(_$PlanetStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlanetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? pollution = null,
    Object? trees = null,
    Object? level = null,
  }) {
    return _then(_$PlanetStateImpl(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      pollution: null == pollution
          ? _value.pollution
          : pollution // ignore: cast_nullable_to_non_nullable
              as int,
      trees: null == trees
          ? _value.trees
          : trees // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as PlanetLevel,
    ));
  }
}

/// @nodoc

class _$PlanetStateImpl implements _PlanetState {
  const _$PlanetStateImpl(
      {this.score = 0,
      this.pollution = 50,
      this.trees = 0,
      this.level = PlanetLevel.barren});

  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final int pollution;
// Start with medium pollution
  @override
  @JsonKey()
  final int trees;
  @override
  @JsonKey()
  final PlanetLevel level;

  @override
  String toString() {
    return 'PlanetState(score: $score, pollution: $pollution, trees: $trees, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanetStateImpl &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.pollution, pollution) ||
                other.pollution == pollution) &&
            (identical(other.trees, trees) || other.trees == trees) &&
            (identical(other.level, level) || other.level == level));
  }

  @override
  int get hashCode => Object.hash(runtimeType, score, pollution, trees, level);

  /// Create a copy of PlanetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanetStateImplCopyWith<_$PlanetStateImpl> get copyWith =>
      __$$PlanetStateImplCopyWithImpl<_$PlanetStateImpl>(this, _$identity);
}

abstract class _PlanetState implements PlanetState {
  const factory _PlanetState(
      {final int score,
      final int pollution,
      final int trees,
      final PlanetLevel level}) = _$PlanetStateImpl;

  @override
  int get score;
  @override
  int get pollution; // Start with medium pollution
  @override
  int get trees;
  @override
  PlanetLevel get level;

  /// Create a copy of PlanetState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanetStateImplCopyWith<_$PlanetStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
