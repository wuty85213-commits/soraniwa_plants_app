// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get userKey => throw _privateConstructorUsedError;
  int get coins => throw _privateConstructorUsedError;
  int get unlockedSlots => throw _privateConstructorUsedError;
  List<String> get actionFlags => throw _privateConstructorUsedError;
  List<String> get rewardFlags => throw _privateConstructorUsedError;
  bool get isBgmOn => throw _privateConstructorUsedError;
  bool get isSeOn => throw _privateConstructorUsedError;
  String? get languageCade => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String userKey,
      int coins,
      int unlockedSlots,
      List<String> actionFlags,
      List<String> rewardFlags,
      bool isBgmOn,
      bool isSeOn,
      String? languageCade});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userKey = null,
    Object? coins = null,
    Object? unlockedSlots = null,
    Object? actionFlags = null,
    Object? rewardFlags = null,
    Object? isBgmOn = null,
    Object? isSeOn = null,
    Object? languageCade = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userKey: null == userKey
          ? _value.userKey
          : userKey // ignore: cast_nullable_to_non_nullable
              as String,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      unlockedSlots: null == unlockedSlots
          ? _value.unlockedSlots
          : unlockedSlots // ignore: cast_nullable_to_non_nullable
              as int,
      actionFlags: null == actionFlags
          ? _value.actionFlags
          : actionFlags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rewardFlags: null == rewardFlags
          ? _value.rewardFlags
          : rewardFlags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isBgmOn: null == isBgmOn
          ? _value.isBgmOn
          : isBgmOn // ignore: cast_nullable_to_non_nullable
              as bool,
      isSeOn: null == isSeOn
          ? _value.isSeOn
          : isSeOn // ignore: cast_nullable_to_non_nullable
              as bool,
      languageCade: freezed == languageCade
          ? _value.languageCade
          : languageCade // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userKey,
      int coins,
      int unlockedSlots,
      List<String> actionFlags,
      List<String> rewardFlags,
      bool isBgmOn,
      bool isSeOn,
      String? languageCade});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userKey = null,
    Object? coins = null,
    Object? unlockedSlots = null,
    Object? actionFlags = null,
    Object? rewardFlags = null,
    Object? isBgmOn = null,
    Object? isSeOn = null,
    Object? languageCade = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userKey: null == userKey
          ? _value.userKey
          : userKey // ignore: cast_nullable_to_non_nullable
              as String,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      unlockedSlots: null == unlockedSlots
          ? _value.unlockedSlots
          : unlockedSlots // ignore: cast_nullable_to_non_nullable
              as int,
      actionFlags: null == actionFlags
          ? _value._actionFlags
          : actionFlags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rewardFlags: null == rewardFlags
          ? _value._rewardFlags
          : rewardFlags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isBgmOn: null == isBgmOn
          ? _value.isBgmOn
          : isBgmOn // ignore: cast_nullable_to_non_nullable
              as bool,
      isSeOn: null == isSeOn
          ? _value.isSeOn
          : isSeOn // ignore: cast_nullable_to_non_nullable
              as bool,
      languageCade: freezed == languageCade
          ? _value.languageCade
          : languageCade // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.userKey,
      required this.coins,
      required this.unlockedSlots,
      required final List<String> actionFlags,
      required final List<String> rewardFlags,
      required this.isBgmOn,
      required this.isSeOn,
      this.languageCade})
      : _actionFlags = actionFlags,
        _rewardFlags = rewardFlags;

  @override
  final String id;
  @override
  final String userKey;
  @override
  final int coins;
  @override
  final int unlockedSlots;
  final List<String> _actionFlags;
  @override
  List<String> get actionFlags {
    if (_actionFlags is EqualUnmodifiableListView) return _actionFlags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actionFlags);
  }

  final List<String> _rewardFlags;
  @override
  List<String> get rewardFlags {
    if (_rewardFlags is EqualUnmodifiableListView) return _rewardFlags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rewardFlags);
  }

  @override
  final bool isBgmOn;
  @override
  final bool isSeOn;
  @override
  final String? languageCade;

  @override
  String toString() {
    return 'User(id: $id, userKey: $userKey, coins: $coins, unlockedSlots: $unlockedSlots, actionFlags: $actionFlags, rewardFlags: $rewardFlags, isBgmOn: $isBgmOn, isSeOn: $isSeOn, languageCade: $languageCade)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userKey, userKey) || other.userKey == userKey) &&
            (identical(other.coins, coins) || other.coins == coins) &&
            (identical(other.unlockedSlots, unlockedSlots) ||
                other.unlockedSlots == unlockedSlots) &&
            const DeepCollectionEquality()
                .equals(other._actionFlags, _actionFlags) &&
            const DeepCollectionEquality()
                .equals(other._rewardFlags, _rewardFlags) &&
            (identical(other.isBgmOn, isBgmOn) || other.isBgmOn == isBgmOn) &&
            (identical(other.isSeOn, isSeOn) || other.isSeOn == isSeOn) &&
            (identical(other.languageCade, languageCade) ||
                other.languageCade == languageCade));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userKey,
      coins,
      unlockedSlots,
      const DeepCollectionEquality().hash(_actionFlags),
      const DeepCollectionEquality().hash(_rewardFlags),
      isBgmOn,
      isSeOn,
      languageCade);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);
}

abstract class _User implements User {
  const factory _User(
      {required final String id,
      required final String userKey,
      required final int coins,
      required final int unlockedSlots,
      required final List<String> actionFlags,
      required final List<String> rewardFlags,
      required final bool isBgmOn,
      required final bool isSeOn,
      final String? languageCade}) = _$UserImpl;

  @override
  String get id;
  @override
  String get userKey;
  @override
  int get coins;
  @override
  int get unlockedSlots;
  @override
  List<String> get actionFlags;
  @override
  List<String> get rewardFlags;
  @override
  bool get isBgmOn;
  @override
  bool get isSeOn;
  @override
  String? get languageCade;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
