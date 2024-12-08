// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_resource.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BaseResource {
  String get name => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  IconData get icon => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get maxQuantity => throw _privateConstructorUsedError;

  /// Create a copy of BaseResource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BaseResourceCopyWith<BaseResource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseResourceCopyWith<$Res> {
  factory $BaseResourceCopyWith(
          BaseResource value, $Res Function(BaseResource) then) =
      _$BaseResourceCopyWithImpl<$Res, BaseResource>;
  @useResult
  $Res call(
      {String name, String label, IconData icon, int amount, int maxQuantity});
}

/// @nodoc
class _$BaseResourceCopyWithImpl<$Res, $Val extends BaseResource>
    implements $BaseResourceCopyWith<$Res> {
  _$BaseResourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BaseResource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? label = null,
    Object? icon = null,
    Object? amount = null,
    Object? maxQuantity = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      maxQuantity: null == maxQuantity
          ? _value.maxQuantity
          : maxQuantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BaseResourceImplCopyWith<$Res>
    implements $BaseResourceCopyWith<$Res> {
  factory _$$BaseResourceImplCopyWith(
          _$BaseResourceImpl value, $Res Function(_$BaseResourceImpl) then) =
      __$$BaseResourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String label, IconData icon, int amount, int maxQuantity});
}

/// @nodoc
class __$$BaseResourceImplCopyWithImpl<$Res>
    extends _$BaseResourceCopyWithImpl<$Res, _$BaseResourceImpl>
    implements _$$BaseResourceImplCopyWith<$Res> {
  __$$BaseResourceImplCopyWithImpl(
      _$BaseResourceImpl _value, $Res Function(_$BaseResourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of BaseResource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? label = null,
    Object? icon = null,
    Object? amount = null,
    Object? maxQuantity = null,
  }) {
    return _then(_$BaseResourceImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      maxQuantity: null == maxQuantity
          ? _value.maxQuantity
          : maxQuantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BaseResourceImpl extends _BaseResource {
  const _$BaseResourceImpl(
      {required this.name,
      required this.label,
      required this.icon,
      this.amount = 0,
      this.maxQuantity = 100})
      : super._();

  @override
  final String name;
  @override
  final String label;
  @override
  final IconData icon;
  @override
  @JsonKey()
  final int amount;
  @override
  @JsonKey()
  final int maxQuantity;

  @override
  String toString() {
    return 'BaseResource(name: $name, label: $label, icon: $icon, amount: $amount, maxQuantity: $maxQuantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseResourceImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.maxQuantity, maxQuantity) ||
                other.maxQuantity == maxQuantity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, label, icon, amount, maxQuantity);

  /// Create a copy of BaseResource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseResourceImplCopyWith<_$BaseResourceImpl> get copyWith =>
      __$$BaseResourceImplCopyWithImpl<_$BaseResourceImpl>(this, _$identity);
}

abstract class _BaseResource extends BaseResource {
  const factory _BaseResource(
      {required final String name,
      required final String label,
      required final IconData icon,
      final int amount,
      final int maxQuantity}) = _$BaseResourceImpl;
  const _BaseResource._() : super._();

  @override
  String get name;
  @override
  String get label;
  @override
  IconData get icon;
  @override
  int get amount;
  @override
  int get maxQuantity;

  /// Create a copy of BaseResource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BaseResourceImplCopyWith<_$BaseResourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
