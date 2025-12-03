// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'master_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MasterDataState {
  List<PlantMasterEntity> get plants => throw _privateConstructorUsedError;
  List<ItemMasterEntity> get items => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MasterDataStateCopyWith<MasterDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MasterDataStateCopyWith<$Res> {
  factory $MasterDataStateCopyWith(
          MasterDataState value, $Res Function(MasterDataState) then) =
      _$MasterDataStateCopyWithImpl<$Res, MasterDataState>;
  @useResult
  $Res call(
      {List<PlantMasterEntity> plants,
      List<ItemMasterEntity> items,
      bool loading,
      String? error});
}

/// @nodoc
class _$MasterDataStateCopyWithImpl<$Res, $Val extends MasterDataState>
    implements $MasterDataStateCopyWith<$Res> {
  _$MasterDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plants = null,
    Object? items = null,
    Object? loading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      plants: null == plants
          ? _value.plants
          : plants // ignore: cast_nullable_to_non_nullable
              as List<PlantMasterEntity>,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemMasterEntity>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MasterDataStateImplCopyWith<$Res>
    implements $MasterDataStateCopyWith<$Res> {
  factory _$$MasterDataStateImplCopyWith(_$MasterDataStateImpl value,
          $Res Function(_$MasterDataStateImpl) then) =
      __$$MasterDataStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PlantMasterEntity> plants,
      List<ItemMasterEntity> items,
      bool loading,
      String? error});
}

/// @nodoc
class __$$MasterDataStateImplCopyWithImpl<$Res>
    extends _$MasterDataStateCopyWithImpl<$Res, _$MasterDataStateImpl>
    implements _$$MasterDataStateImplCopyWith<$Res> {
  __$$MasterDataStateImplCopyWithImpl(
      _$MasterDataStateImpl _value, $Res Function(_$MasterDataStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plants = null,
    Object? items = null,
    Object? loading = null,
    Object? error = freezed,
  }) {
    return _then(_$MasterDataStateImpl(
      plants: null == plants
          ? _value._plants
          : plants // ignore: cast_nullable_to_non_nullable
              as List<PlantMasterEntity>,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemMasterEntity>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MasterDataStateImpl implements _MasterDataState {
  const _$MasterDataStateImpl(
      {final List<PlantMasterEntity> plants = const [],
      final List<ItemMasterEntity> items = const [],
      this.loading = false,
      this.error})
      : _plants = plants,
        _items = items;

  final List<PlantMasterEntity> _plants;
  @override
  @JsonKey()
  List<PlantMasterEntity> get plants {
    if (_plants is EqualUnmodifiableListView) return _plants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_plants);
  }

  final List<ItemMasterEntity> _items;
  @override
  @JsonKey()
  List<ItemMasterEntity> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final bool loading;
  @override
  final String? error;

  @override
  String toString() {
    return 'MasterDataState(plants: $plants, items: $items, loading: $loading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MasterDataStateImpl &&
            const DeepCollectionEquality().equals(other._plants, _plants) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_plants),
      const DeepCollectionEquality().hash(_items),
      loading,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MasterDataStateImplCopyWith<_$MasterDataStateImpl> get copyWith =>
      __$$MasterDataStateImplCopyWithImpl<_$MasterDataStateImpl>(
          this, _$identity);
}

abstract class _MasterDataState implements MasterDataState {
  const factory _MasterDataState(
      {final List<PlantMasterEntity> plants,
      final List<ItemMasterEntity> items,
      final bool loading,
      final String? error}) = _$MasterDataStateImpl;

  @override
  List<PlantMasterEntity> get plants;
  @override
  List<ItemMasterEntity> get items;
  @override
  bool get loading;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$MasterDataStateImplCopyWith<_$MasterDataStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
