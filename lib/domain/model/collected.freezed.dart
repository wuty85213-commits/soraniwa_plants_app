// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collected.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Collected {
  String get id => throw _privateConstructorUsedError;
  int get plantId => throw _privateConstructorUsedError;
  Variant get variant => throw _privateConstructorUsedError;
  Attribute get attribute => throw _privateConstructorUsedError;
  int get harvestCount => throw _privateConstructorUsedError;
  int get lastHarvestedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CollectedCopyWith<Collected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectedCopyWith<$Res> {
  factory $CollectedCopyWith(Collected value, $Res Function(Collected) then) =
      _$CollectedCopyWithImpl<$Res, Collected>;
  @useResult
  $Res call(
      {String id,
      int plantId,
      Variant variant,
      Attribute attribute,
      int harvestCount,
      int lastHarvestedAt});
}

/// @nodoc
class _$CollectedCopyWithImpl<$Res, $Val extends Collected>
    implements $CollectedCopyWith<$Res> {
  _$CollectedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? plantId = null,
    Object? variant = null,
    Object? attribute = null,
    Object? harvestCount = null,
    Object? lastHarvestedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      plantId: null == plantId
          ? _value.plantId
          : plantId // ignore: cast_nullable_to_non_nullable
              as int,
      variant: null == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as Variant,
      attribute: null == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as Attribute,
      harvestCount: null == harvestCount
          ? _value.harvestCount
          : harvestCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastHarvestedAt: null == lastHarvestedAt
          ? _value.lastHarvestedAt
          : lastHarvestedAt // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CollectedImplCopyWith<$Res>
    implements $CollectedCopyWith<$Res> {
  factory _$$CollectedImplCopyWith(
          _$CollectedImpl value, $Res Function(_$CollectedImpl) then) =
      __$$CollectedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int plantId,
      Variant variant,
      Attribute attribute,
      int harvestCount,
      int lastHarvestedAt});
}

/// @nodoc
class __$$CollectedImplCopyWithImpl<$Res>
    extends _$CollectedCopyWithImpl<$Res, _$CollectedImpl>
    implements _$$CollectedImplCopyWith<$Res> {
  __$$CollectedImplCopyWithImpl(
      _$CollectedImpl _value, $Res Function(_$CollectedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? plantId = null,
    Object? variant = null,
    Object? attribute = null,
    Object? harvestCount = null,
    Object? lastHarvestedAt = null,
  }) {
    return _then(_$CollectedImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      plantId: null == plantId
          ? _value.plantId
          : plantId // ignore: cast_nullable_to_non_nullable
              as int,
      variant: null == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as Variant,
      attribute: null == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as Attribute,
      harvestCount: null == harvestCount
          ? _value.harvestCount
          : harvestCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastHarvestedAt: null == lastHarvestedAt
          ? _value.lastHarvestedAt
          : lastHarvestedAt // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CollectedImpl implements _Collected {
  const _$CollectedImpl(
      {required this.id,
      required this.plantId,
      required this.variant,
      required this.attribute,
      required this.harvestCount,
      required this.lastHarvestedAt});

  @override
  final String id;
  @override
  final int plantId;
  @override
  final Variant variant;
  @override
  final Attribute attribute;
  @override
  final int harvestCount;
  @override
  final int lastHarvestedAt;

  @override
  String toString() {
    return 'Collected(id: $id, plantId: $plantId, variant: $variant, attribute: $attribute, harvestCount: $harvestCount, lastHarvestedAt: $lastHarvestedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plantId, plantId) || other.plantId == plantId) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.harvestCount, harvestCount) ||
                other.harvestCount == harvestCount) &&
            (identical(other.lastHarvestedAt, lastHarvestedAt) ||
                other.lastHarvestedAt == lastHarvestedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, plantId, variant, attribute,
      harvestCount, lastHarvestedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectedImplCopyWith<_$CollectedImpl> get copyWith =>
      __$$CollectedImplCopyWithImpl<_$CollectedImpl>(this, _$identity);
}

abstract class _Collected implements Collected {
  const factory _Collected(
      {required final String id,
      required final int plantId,
      required final Variant variant,
      required final Attribute attribute,
      required final int harvestCount,
      required final int lastHarvestedAt}) = _$CollectedImpl;

  @override
  String get id;
  @override
  int get plantId;
  @override
  Variant get variant;
  @override
  Attribute get attribute;
  @override
  int get harvestCount;
  @override
  int get lastHarvestedAt;
  @override
  @JsonKey(ignore: true)
  _$$CollectedImplCopyWith<_$CollectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
