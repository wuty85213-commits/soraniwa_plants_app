// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Pot {
  String get id => throw _privateConstructorUsedError;
  int get slotIndex => throw _privateConstructorUsedError;
  int get itemId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PotCopyWith<Pot> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PotCopyWith<$Res> {
  factory $PotCopyWith(Pot value, $Res Function(Pot) then) =
      _$PotCopyWithImpl<$Res, Pot>;
  @useResult
  $Res call({String id, int slotIndex, int itemId});
}

/// @nodoc
class _$PotCopyWithImpl<$Res, $Val extends Pot> implements $PotCopyWith<$Res> {
  _$PotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slotIndex = null,
    Object? itemId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      slotIndex: null == slotIndex
          ? _value.slotIndex
          : slotIndex // ignore: cast_nullable_to_non_nullable
              as int,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PotImplCopyWith<$Res> implements $PotCopyWith<$Res> {
  factory _$$PotImplCopyWith(_$PotImpl value, $Res Function(_$PotImpl) then) =
      __$$PotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int slotIndex, int itemId});
}

/// @nodoc
class __$$PotImplCopyWithImpl<$Res> extends _$PotCopyWithImpl<$Res, _$PotImpl>
    implements _$$PotImplCopyWith<$Res> {
  __$$PotImplCopyWithImpl(_$PotImpl _value, $Res Function(_$PotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slotIndex = null,
    Object? itemId = null,
  }) {
    return _then(_$PotImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      slotIndex: null == slotIndex
          ? _value.slotIndex
          : slotIndex // ignore: cast_nullable_to_non_nullable
              as int,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PotImpl implements _Pot {
  const _$PotImpl(
      {required this.id, required this.slotIndex, required this.itemId});

  @override
  final String id;
  @override
  final int slotIndex;
  @override
  final int itemId;

  @override
  String toString() {
    return 'Pot(id: $id, slotIndex: $slotIndex, itemId: $itemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.slotIndex, slotIndex) ||
                other.slotIndex == slotIndex) &&
            (identical(other.itemId, itemId) || other.itemId == itemId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, slotIndex, itemId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PotImplCopyWith<_$PotImpl> get copyWith =>
      __$$PotImplCopyWithImpl<_$PotImpl>(this, _$identity);
}

abstract class _Pot implements Pot {
  const factory _Pot(
      {required final String id,
      required final int slotIndex,
      required final int itemId}) = _$PotImpl;

  @override
  String get id;
  @override
  int get slotIndex;
  @override
  int get itemId;
  @override
  @JsonKey(ignore: true)
  _$$PotImplCopyWith<_$PotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
