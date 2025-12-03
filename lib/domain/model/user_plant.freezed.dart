// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_plant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserPlant {
  String get id => throw _privateConstructorUsedError;
  int get plantId => throw _privateConstructorUsedError;
  Variant get variant => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  int get growthBoost => throw _privateConstructorUsedError;
  int get lastWatered => throw _privateConstructorUsedError;
  int get lastUpdate => throw _privateConstructorUsedError;
  PlantCondition get plantCondition => throw _privateConstructorUsedError;
  int get slotIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserPlantCopyWith<UserPlant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPlantCopyWith<$Res> {
  factory $UserPlantCopyWith(UserPlant value, $Res Function(UserPlant) then) =
      _$UserPlantCopyWithImpl<$Res, UserPlant>;
  @useResult
  $Res call(
      {String id,
      int plantId,
      Variant variant,
      double progress,
      int growthBoost,
      int lastWatered,
      int lastUpdate,
      PlantCondition plantCondition,
      int slotIndex});
}

/// @nodoc
class _$UserPlantCopyWithImpl<$Res, $Val extends UserPlant>
    implements $UserPlantCopyWith<$Res> {
  _$UserPlantCopyWithImpl(this._value, this._then);

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
    Object? progress = null,
    Object? growthBoost = null,
    Object? lastWatered = null,
    Object? lastUpdate = null,
    Object? plantCondition = null,
    Object? slotIndex = null,
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
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      growthBoost: null == growthBoost
          ? _value.growthBoost
          : growthBoost // ignore: cast_nullable_to_non_nullable
              as int,
      lastWatered: null == lastWatered
          ? _value.lastWatered
          : lastWatered // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as int,
      plantCondition: null == plantCondition
          ? _value.plantCondition
          : plantCondition // ignore: cast_nullable_to_non_nullable
              as PlantCondition,
      slotIndex: null == slotIndex
          ? _value.slotIndex
          : slotIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPlantImplCopyWith<$Res>
    implements $UserPlantCopyWith<$Res> {
  factory _$$UserPlantImplCopyWith(
          _$UserPlantImpl value, $Res Function(_$UserPlantImpl) then) =
      __$$UserPlantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int plantId,
      Variant variant,
      double progress,
      int growthBoost,
      int lastWatered,
      int lastUpdate,
      PlantCondition plantCondition,
      int slotIndex});
}

/// @nodoc
class __$$UserPlantImplCopyWithImpl<$Res>
    extends _$UserPlantCopyWithImpl<$Res, _$UserPlantImpl>
    implements _$$UserPlantImplCopyWith<$Res> {
  __$$UserPlantImplCopyWithImpl(
      _$UserPlantImpl _value, $Res Function(_$UserPlantImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? plantId = null,
    Object? variant = null,
    Object? progress = null,
    Object? growthBoost = null,
    Object? lastWatered = null,
    Object? lastUpdate = null,
    Object? plantCondition = null,
    Object? slotIndex = null,
  }) {
    return _then(_$UserPlantImpl(
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
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      growthBoost: null == growthBoost
          ? _value.growthBoost
          : growthBoost // ignore: cast_nullable_to_non_nullable
              as int,
      lastWatered: null == lastWatered
          ? _value.lastWatered
          : lastWatered // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as int,
      plantCondition: null == plantCondition
          ? _value.plantCondition
          : plantCondition // ignore: cast_nullable_to_non_nullable
              as PlantCondition,
      slotIndex: null == slotIndex
          ? _value.slotIndex
          : slotIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UserPlantImpl implements _UserPlant {
  const _$UserPlantImpl(
      {required this.id,
      required this.plantId,
      required this.variant,
      required this.progress,
      required this.growthBoost,
      required this.lastWatered,
      required this.lastUpdate,
      required this.plantCondition,
      required this.slotIndex});

  @override
  final String id;
  @override
  final int plantId;
  @override
  final Variant variant;
  @override
  final double progress;
  @override
  final int growthBoost;
  @override
  final int lastWatered;
  @override
  final int lastUpdate;
  @override
  final PlantCondition plantCondition;
  @override
  final int slotIndex;

  @override
  String toString() {
    return 'UserPlant(id: $id, plantId: $plantId, variant: $variant, progress: $progress, growthBoost: $growthBoost, lastWatered: $lastWatered, lastUpdate: $lastUpdate, plantCondition: $plantCondition, slotIndex: $slotIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPlantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plantId, plantId) || other.plantId == plantId) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.growthBoost, growthBoost) ||
                other.growthBoost == growthBoost) &&
            (identical(other.lastWatered, lastWatered) ||
                other.lastWatered == lastWatered) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            (identical(other.plantCondition, plantCondition) ||
                other.plantCondition == plantCondition) &&
            (identical(other.slotIndex, slotIndex) ||
                other.slotIndex == slotIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, plantId, variant, progress,
      growthBoost, lastWatered, lastUpdate, plantCondition, slotIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPlantImplCopyWith<_$UserPlantImpl> get copyWith =>
      __$$UserPlantImplCopyWithImpl<_$UserPlantImpl>(this, _$identity);
}

abstract class _UserPlant implements UserPlant {
  const factory _UserPlant(
      {required final String id,
      required final int plantId,
      required final Variant variant,
      required final double progress,
      required final int growthBoost,
      required final int lastWatered,
      required final int lastUpdate,
      required final PlantCondition plantCondition,
      required final int slotIndex}) = _$UserPlantImpl;

  @override
  String get id;
  @override
  int get plantId;
  @override
  Variant get variant;
  @override
  double get progress;
  @override
  int get growthBoost;
  @override
  int get lastWatered;
  @override
  int get lastUpdate;
  @override
  PlantCondition get plantCondition;
  @override
  int get slotIndex;
  @override
  @JsonKey(ignore: true)
  _$$UserPlantImplCopyWith<_$UserPlantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
