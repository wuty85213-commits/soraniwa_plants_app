// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'farm_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FarmState {
  List<UserPlant> get userPlants => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FarmStateCopyWith<FarmState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmStateCopyWith<$Res> {
  factory $FarmStateCopyWith(FarmState value, $Res Function(FarmState) then) =
      _$FarmStateCopyWithImpl<$Res, FarmState>;
  @useResult
  $Res call({List<UserPlant> userPlants});
}

/// @nodoc
class _$FarmStateCopyWithImpl<$Res, $Val extends FarmState>
    implements $FarmStateCopyWith<$Res> {
  _$FarmStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userPlants = null,
  }) {
    return _then(_value.copyWith(
      userPlants: null == userPlants
          ? _value.userPlants
          : userPlants // ignore: cast_nullable_to_non_nullable
              as List<UserPlant>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FarmStateImplCopyWith<$Res>
    implements $FarmStateCopyWith<$Res> {
  factory _$$FarmStateImplCopyWith(
          _$FarmStateImpl value, $Res Function(_$FarmStateImpl) then) =
      __$$FarmStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserPlant> userPlants});
}

/// @nodoc
class __$$FarmStateImplCopyWithImpl<$Res>
    extends _$FarmStateCopyWithImpl<$Res, _$FarmStateImpl>
    implements _$$FarmStateImplCopyWith<$Res> {
  __$$FarmStateImplCopyWithImpl(
      _$FarmStateImpl _value, $Res Function(_$FarmStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userPlants = null,
  }) {
    return _then(_$FarmStateImpl(
      userPlants: null == userPlants
          ? _value._userPlants
          : userPlants // ignore: cast_nullable_to_non_nullable
              as List<UserPlant>,
    ));
  }
}

/// @nodoc

class _$FarmStateImpl implements _FarmState {
  const _$FarmStateImpl({final List<UserPlant> userPlants = const []})
      : _userPlants = userPlants;

  final List<UserPlant> _userPlants;
  @override
  @JsonKey()
  List<UserPlant> get userPlants {
    if (_userPlants is EqualUnmodifiableListView) return _userPlants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userPlants);
  }

  @override
  String toString() {
    return 'FarmState(userPlants: $userPlants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmStateImpl &&
            const DeepCollectionEquality()
                .equals(other._userPlants, _userPlants));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_userPlants));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmStateImplCopyWith<_$FarmStateImpl> get copyWith =>
      __$$FarmStateImplCopyWithImpl<_$FarmStateImpl>(this, _$identity);
}

abstract class _FarmState implements FarmState {
  const factory _FarmState({final List<UserPlant> userPlants}) =
      _$FarmStateImpl;

  @override
  List<UserPlant> get userPlants;
  @override
  @JsonKey(ignore: true)
  _$$FarmStateImplCopyWith<_$FarmStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
