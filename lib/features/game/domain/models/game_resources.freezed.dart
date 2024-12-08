// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_resources.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameResources {
  WaterResource get water => throw _privateConstructorUsedError;
  EnergyResource get energy => throw _privateConstructorUsedError;
  SoilResource get soil => throw _privateConstructorUsedError;

  /// Create a copy of GameResources
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameResourcesCopyWith<GameResources> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameResourcesCopyWith<$Res> {
  factory $GameResourcesCopyWith(
          GameResources value, $Res Function(GameResources) then) =
      _$GameResourcesCopyWithImpl<$Res, GameResources>;
  @useResult
  $Res call({WaterResource water, EnergyResource energy, SoilResource soil});

  $WaterResourceCopyWith<$Res> get water;
  $EnergyResourceCopyWith<$Res> get energy;
  $SoilResourceCopyWith<$Res> get soil;
}

/// @nodoc
class _$GameResourcesCopyWithImpl<$Res, $Val extends GameResources>
    implements $GameResourcesCopyWith<$Res> {
  _$GameResourcesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameResources
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? water = null,
    Object? energy = null,
    Object? soil = null,
  }) {
    return _then(_value.copyWith(
      water: null == water
          ? _value.water
          : water // ignore: cast_nullable_to_non_nullable
              as WaterResource,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as EnergyResource,
      soil: null == soil
          ? _value.soil
          : soil // ignore: cast_nullable_to_non_nullable
              as SoilResource,
    ) as $Val);
  }

  /// Create a copy of GameResources
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WaterResourceCopyWith<$Res> get water {
    return $WaterResourceCopyWith<$Res>(_value.water, (value) {
      return _then(_value.copyWith(water: value) as $Val);
    });
  }

  /// Create a copy of GameResources
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EnergyResourceCopyWith<$Res> get energy {
    return $EnergyResourceCopyWith<$Res>(_value.energy, (value) {
      return _then(_value.copyWith(energy: value) as $Val);
    });
  }

  /// Create a copy of GameResources
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SoilResourceCopyWith<$Res> get soil {
    return $SoilResourceCopyWith<$Res>(_value.soil, (value) {
      return _then(_value.copyWith(soil: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameResourcesImplCopyWith<$Res>
    implements $GameResourcesCopyWith<$Res> {
  factory _$$GameResourcesImplCopyWith(
          _$GameResourcesImpl value, $Res Function(_$GameResourcesImpl) then) =
      __$$GameResourcesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WaterResource water, EnergyResource energy, SoilResource soil});

  @override
  $WaterResourceCopyWith<$Res> get water;
  @override
  $EnergyResourceCopyWith<$Res> get energy;
  @override
  $SoilResourceCopyWith<$Res> get soil;
}

/// @nodoc
class __$$GameResourcesImplCopyWithImpl<$Res>
    extends _$GameResourcesCopyWithImpl<$Res, _$GameResourcesImpl>
    implements _$$GameResourcesImplCopyWith<$Res> {
  __$$GameResourcesImplCopyWithImpl(
      _$GameResourcesImpl _value, $Res Function(_$GameResourcesImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameResources
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? water = null,
    Object? energy = null,
    Object? soil = null,
  }) {
    return _then(_$GameResourcesImpl(
      water: null == water
          ? _value.water
          : water // ignore: cast_nullable_to_non_nullable
              as WaterResource,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as EnergyResource,
      soil: null == soil
          ? _value.soil
          : soil // ignore: cast_nullable_to_non_nullable
              as SoilResource,
    ));
  }
}

/// @nodoc

class _$GameResourcesImpl extends _GameResources {
  const _$GameResourcesImpl(
      {this.water = const WaterResource(),
      this.energy = const EnergyResource(),
      this.soil = const SoilResource()})
      : super._();

  @override
  @JsonKey()
  final WaterResource water;
  @override
  @JsonKey()
  final EnergyResource energy;
  @override
  @JsonKey()
  final SoilResource soil;

  @override
  String toString() {
    return 'GameResources(water: $water, energy: $energy, soil: $soil)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameResourcesImpl &&
            (identical(other.water, water) || other.water == water) &&
            (identical(other.energy, energy) || other.energy == energy) &&
            (identical(other.soil, soil) || other.soil == soil));
  }

  @override
  int get hashCode => Object.hash(runtimeType, water, energy, soil);

  /// Create a copy of GameResources
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameResourcesImplCopyWith<_$GameResourcesImpl> get copyWith =>
      __$$GameResourcesImplCopyWithImpl<_$GameResourcesImpl>(this, _$identity);
}

abstract class _GameResources extends GameResources {
  const factory _GameResources(
      {final WaterResource water,
      final EnergyResource energy,
      final SoilResource soil}) = _$GameResourcesImpl;
  const _GameResources._() : super._();

  @override
  WaterResource get water;
  @override
  EnergyResource get energy;
  @override
  SoilResource get soil;

  /// Create a copy of GameResources
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameResourcesImplCopyWith<_$GameResourcesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
