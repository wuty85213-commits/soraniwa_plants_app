// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collected_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CollectedState {
  List<Collected> get collected => throw _privateConstructorUsedError;
  List<PlantMasterEntity> get normalPlants =>
      throw _privateConstructorUsedError;
  List<PlantMasterEntity> get plants => throw _privateConstructorUsedError;
  List<ItemMasterEntity> get items => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CollectedStateCopyWith<CollectedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectedStateCopyWith<$Res> {
  factory $CollectedStateCopyWith(
          CollectedState value, $Res Function(CollectedState) then) =
      _$CollectedStateCopyWithImpl<$Res, CollectedState>;
  @useResult
  $Res call(
      {List<Collected> collected,
      List<PlantMasterEntity> normalPlants,
      List<PlantMasterEntity> plants,
      List<ItemMasterEntity> items,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class _$CollectedStateCopyWithImpl<$Res, $Val extends CollectedState>
    implements $CollectedStateCopyWith<$Res> {
  _$CollectedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collected = null,
    Object? normalPlants = null,
    Object? plants = null,
    Object? items = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      collected: null == collected
          ? _value.collected
          : collected // ignore: cast_nullable_to_non_nullable
              as List<Collected>,
      normalPlants: null == normalPlants
          ? _value.normalPlants
          : normalPlants // ignore: cast_nullable_to_non_nullable
              as List<PlantMasterEntity>,
      plants: null == plants
          ? _value.plants
          : plants // ignore: cast_nullable_to_non_nullable
              as List<PlantMasterEntity>,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemMasterEntity>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CollectedStateImplCopyWith<$Res>
    implements $CollectedStateCopyWith<$Res> {
  factory _$$CollectedStateImplCopyWith(_$CollectedStateImpl value,
          $Res Function(_$CollectedStateImpl) then) =
      __$$CollectedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Collected> collected,
      List<PlantMasterEntity> normalPlants,
      List<PlantMasterEntity> plants,
      List<ItemMasterEntity> items,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$CollectedStateImplCopyWithImpl<$Res>
    extends _$CollectedStateCopyWithImpl<$Res, _$CollectedStateImpl>
    implements _$$CollectedStateImplCopyWith<$Res> {
  __$$CollectedStateImplCopyWithImpl(
      _$CollectedStateImpl _value, $Res Function(_$CollectedStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collected = null,
    Object? normalPlants = null,
    Object? plants = null,
    Object? items = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$CollectedStateImpl(
      collected: null == collected
          ? _value._collected
          : collected // ignore: cast_nullable_to_non_nullable
              as List<Collected>,
      normalPlants: null == normalPlants
          ? _value._normalPlants
          : normalPlants // ignore: cast_nullable_to_non_nullable
              as List<PlantMasterEntity>,
      plants: null == plants
          ? _value._plants
          : plants // ignore: cast_nullable_to_non_nullable
              as List<PlantMasterEntity>,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemMasterEntity>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CollectedStateImpl implements _CollectedState {
  const _$CollectedStateImpl(
      {final List<Collected> collected = const [],
      final List<PlantMasterEntity> normalPlants = const [],
      final List<PlantMasterEntity> plants = const [],
      final List<ItemMasterEntity> items = const [],
      this.isLoading = false,
      this.errorMessage})
      : _collected = collected,
        _normalPlants = normalPlants,
        _plants = plants,
        _items = items;

  final List<Collected> _collected;
  @override
  @JsonKey()
  List<Collected> get collected {
    if (_collected is EqualUnmodifiableListView) return _collected;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collected);
  }

  final List<PlantMasterEntity> _normalPlants;
  @override
  @JsonKey()
  List<PlantMasterEntity> get normalPlants {
    if (_normalPlants is EqualUnmodifiableListView) return _normalPlants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_normalPlants);
  }

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
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CollectedState(collected: $collected, normalPlants: $normalPlants, plants: $plants, items: $items, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectedStateImpl &&
            const DeepCollectionEquality()
                .equals(other._collected, _collected) &&
            const DeepCollectionEquality()
                .equals(other._normalPlants, _normalPlants) &&
            const DeepCollectionEquality().equals(other._plants, _plants) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_collected),
      const DeepCollectionEquality().hash(_normalPlants),
      const DeepCollectionEquality().hash(_plants),
      const DeepCollectionEquality().hash(_items),
      isLoading,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectedStateImplCopyWith<_$CollectedStateImpl> get copyWith =>
      __$$CollectedStateImplCopyWithImpl<_$CollectedStateImpl>(
          this, _$identity);
}

abstract class _CollectedState implements CollectedState {
  const factory _CollectedState(
      {final List<Collected> collected,
      final List<PlantMasterEntity> normalPlants,
      final List<PlantMasterEntity> plants,
      final List<ItemMasterEntity> items,
      final bool isLoading,
      final String? errorMessage}) = _$CollectedStateImpl;

  @override
  List<Collected> get collected;
  @override
  List<PlantMasterEntity> get normalPlants;
  @override
  List<PlantMasterEntity> get plants;
  @override
  List<ItemMasterEntity> get items;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$CollectedStateImplCopyWith<_$CollectedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
