// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StoreState {
  User get user => throw _privateConstructorUsedError;
  List<ItemMasterEntity> get displayableItems =>
      throw _privateConstructorUsedError;
  List<PlantMasterEntity> get plantMasters =>
      throw _privateConstructorUsedError;
  List<ItemMasterEntity> get itemsMasters => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StoreStateCopyWith<StoreState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreStateCopyWith<$Res> {
  factory $StoreStateCopyWith(
          StoreState value, $Res Function(StoreState) then) =
      _$StoreStateCopyWithImpl<$Res, StoreState>;
  @useResult
  $Res call(
      {User user,
      List<ItemMasterEntity> displayableItems,
      List<PlantMasterEntity> plantMasters,
      List<ItemMasterEntity> itemsMasters});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$StoreStateCopyWithImpl<$Res, $Val extends StoreState>
    implements $StoreStateCopyWith<$Res> {
  _$StoreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? displayableItems = null,
    Object? plantMasters = null,
    Object? itemsMasters = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      displayableItems: null == displayableItems
          ? _value.displayableItems
          : displayableItems // ignore: cast_nullable_to_non_nullable
              as List<ItemMasterEntity>,
      plantMasters: null == plantMasters
          ? _value.plantMasters
          : plantMasters // ignore: cast_nullable_to_non_nullable
              as List<PlantMasterEntity>,
      itemsMasters: null == itemsMasters
          ? _value.itemsMasters
          : itemsMasters // ignore: cast_nullable_to_non_nullable
              as List<ItemMasterEntity>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoreStateImplCopyWith<$Res>
    implements $StoreStateCopyWith<$Res> {
  factory _$$StoreStateImplCopyWith(
          _$StoreStateImpl value, $Res Function(_$StoreStateImpl) then) =
      __$$StoreStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {User user,
      List<ItemMasterEntity> displayableItems,
      List<PlantMasterEntity> plantMasters,
      List<ItemMasterEntity> itemsMasters});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$StoreStateImplCopyWithImpl<$Res>
    extends _$StoreStateCopyWithImpl<$Res, _$StoreStateImpl>
    implements _$$StoreStateImplCopyWith<$Res> {
  __$$StoreStateImplCopyWithImpl(
      _$StoreStateImpl _value, $Res Function(_$StoreStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? displayableItems = null,
    Object? plantMasters = null,
    Object? itemsMasters = null,
  }) {
    return _then(_$StoreStateImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      displayableItems: null == displayableItems
          ? _value._displayableItems
          : displayableItems // ignore: cast_nullable_to_non_nullable
              as List<ItemMasterEntity>,
      plantMasters: null == plantMasters
          ? _value._plantMasters
          : plantMasters // ignore: cast_nullable_to_non_nullable
              as List<PlantMasterEntity>,
      itemsMasters: null == itemsMasters
          ? _value._itemsMasters
          : itemsMasters // ignore: cast_nullable_to_non_nullable
              as List<ItemMasterEntity>,
    ));
  }
}

/// @nodoc

class _$StoreStateImpl implements _StoreState {
  const _$StoreStateImpl(
      {required this.user,
      final List<ItemMasterEntity> displayableItems = const [],
      final List<PlantMasterEntity> plantMasters = const [],
      final List<ItemMasterEntity> itemsMasters = const []})
      : _displayableItems = displayableItems,
        _plantMasters = plantMasters,
        _itemsMasters = itemsMasters;

  @override
  final User user;
  final List<ItemMasterEntity> _displayableItems;
  @override
  @JsonKey()
  List<ItemMasterEntity> get displayableItems {
    if (_displayableItems is EqualUnmodifiableListView)
      return _displayableItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_displayableItems);
  }

  final List<PlantMasterEntity> _plantMasters;
  @override
  @JsonKey()
  List<PlantMasterEntity> get plantMasters {
    if (_plantMasters is EqualUnmodifiableListView) return _plantMasters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_plantMasters);
  }

  final List<ItemMasterEntity> _itemsMasters;
  @override
  @JsonKey()
  List<ItemMasterEntity> get itemsMasters {
    if (_itemsMasters is EqualUnmodifiableListView) return _itemsMasters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemsMasters);
  }

  @override
  String toString() {
    return 'StoreState(user: $user, displayableItems: $displayableItems, plantMasters: $plantMasters, itemsMasters: $itemsMasters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreStateImpl &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality()
                .equals(other._displayableItems, _displayableItems) &&
            const DeepCollectionEquality()
                .equals(other._plantMasters, _plantMasters) &&
            const DeepCollectionEquality()
                .equals(other._itemsMasters, _itemsMasters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      user,
      const DeepCollectionEquality().hash(_displayableItems),
      const DeepCollectionEquality().hash(_plantMasters),
      const DeepCollectionEquality().hash(_itemsMasters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreStateImplCopyWith<_$StoreStateImpl> get copyWith =>
      __$$StoreStateImplCopyWithImpl<_$StoreStateImpl>(this, _$identity);
}

abstract class _StoreState implements StoreState {
  const factory _StoreState(
      {required final User user,
      final List<ItemMasterEntity> displayableItems,
      final List<PlantMasterEntity> plantMasters,
      final List<ItemMasterEntity> itemsMasters}) = _$StoreStateImpl;

  @override
  User get user;
  @override
  List<ItemMasterEntity> get displayableItems;
  @override
  List<PlantMasterEntity> get plantMasters;
  @override
  List<ItemMasterEntity> get itemsMasters;
  @override
  @JsonKey(ignore: true)
  _$$StoreStateImplCopyWith<_$StoreStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
