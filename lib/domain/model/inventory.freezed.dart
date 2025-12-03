// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Inventory {
  String get id => throw _privateConstructorUsedError;
  int get itemId => throw _privateConstructorUsedError;
  ItemType get itemType => throw _privateConstructorUsedError;
  Variant? get variant => throw _privateConstructorUsedError;
  Attribute? get attribute => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InventoryCopyWith<Inventory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCopyWith<$Res> {
  factory $InventoryCopyWith(Inventory value, $Res Function(Inventory) then) =
      _$InventoryCopyWithImpl<$Res, Inventory>;
  @useResult
  $Res call(
      {String id,
      int itemId,
      ItemType itemType,
      Variant? variant,
      Attribute? attribute,
      int quantity});
}

/// @nodoc
class _$InventoryCopyWithImpl<$Res, $Val extends Inventory>
    implements $InventoryCopyWith<$Res> {
  _$InventoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemId = null,
    Object? itemType = null,
    Object? variant = freezed,
    Object? attribute = freezed,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      itemType: null == itemType
          ? _value.itemType
          : itemType // ignore: cast_nullable_to_non_nullable
              as ItemType,
      variant: freezed == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as Variant?,
      attribute: freezed == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as Attribute?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryImplCopyWith<$Res>
    implements $InventoryCopyWith<$Res> {
  factory _$$InventoryImplCopyWith(
          _$InventoryImpl value, $Res Function(_$InventoryImpl) then) =
      __$$InventoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int itemId,
      ItemType itemType,
      Variant? variant,
      Attribute? attribute,
      int quantity});
}

/// @nodoc
class __$$InventoryImplCopyWithImpl<$Res>
    extends _$InventoryCopyWithImpl<$Res, _$InventoryImpl>
    implements _$$InventoryImplCopyWith<$Res> {
  __$$InventoryImplCopyWithImpl(
      _$InventoryImpl _value, $Res Function(_$InventoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemId = null,
    Object? itemType = null,
    Object? variant = freezed,
    Object? attribute = freezed,
    Object? quantity = null,
  }) {
    return _then(_$InventoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      itemType: null == itemType
          ? _value.itemType
          : itemType // ignore: cast_nullable_to_non_nullable
              as ItemType,
      variant: freezed == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as Variant?,
      attribute: freezed == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as Attribute?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$InventoryImpl implements _Inventory {
  const _$InventoryImpl(
      {required this.id,
      required this.itemId,
      required this.itemType,
      this.variant,
      this.attribute,
      required this.quantity});

  @override
  final String id;
  @override
  final int itemId;
  @override
  final ItemType itemType;
  @override
  final Variant? variant;
  @override
  final Attribute? attribute;
  @override
  final int quantity;

  @override
  String toString() {
    return 'Inventory(id: $id, itemId: $itemId, itemType: $itemType, variant: $variant, attribute: $attribute, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.itemType, itemType) ||
                other.itemType == itemType) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, itemId, itemType, variant, attribute, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryImplCopyWith<_$InventoryImpl> get copyWith =>
      __$$InventoryImplCopyWithImpl<_$InventoryImpl>(this, _$identity);
}

abstract class _Inventory implements Inventory {
  const factory _Inventory(
      {required final String id,
      required final int itemId,
      required final ItemType itemType,
      final Variant? variant,
      final Attribute? attribute,
      required final int quantity}) = _$InventoryImpl;

  @override
  String get id;
  @override
  int get itemId;
  @override
  ItemType get itemType;
  @override
  Variant? get variant;
  @override
  Attribute? get attribute;
  @override
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$InventoryImplCopyWith<_$InventoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
