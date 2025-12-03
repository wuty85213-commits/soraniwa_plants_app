// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ach_with_flags.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AchWithFlags {
  Achievement get ach => throw _privateConstructorUsedError;
  bool get unlocked => throw _privateConstructorUsedError;
  bool get rewarded => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AchWithFlagsCopyWith<AchWithFlags> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchWithFlagsCopyWith<$Res> {
  factory $AchWithFlagsCopyWith(
          AchWithFlags value, $Res Function(AchWithFlags) then) =
      _$AchWithFlagsCopyWithImpl<$Res, AchWithFlags>;
  @useResult
  $Res call({Achievement ach, bool unlocked, bool rewarded});
}

/// @nodoc
class _$AchWithFlagsCopyWithImpl<$Res, $Val extends AchWithFlags>
    implements $AchWithFlagsCopyWith<$Res> {
  _$AchWithFlagsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ach = null,
    Object? unlocked = null,
    Object? rewarded = null,
  }) {
    return _then(_value.copyWith(
      ach: null == ach
          ? _value.ach
          : ach // ignore: cast_nullable_to_non_nullable
              as Achievement,
      unlocked: null == unlocked
          ? _value.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      rewarded: null == rewarded
          ? _value.rewarded
          : rewarded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AchWithFlagsImplCopyWith<$Res>
    implements $AchWithFlagsCopyWith<$Res> {
  factory _$$AchWithFlagsImplCopyWith(
          _$AchWithFlagsImpl value, $Res Function(_$AchWithFlagsImpl) then) =
      __$$AchWithFlagsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Achievement ach, bool unlocked, bool rewarded});
}

/// @nodoc
class __$$AchWithFlagsImplCopyWithImpl<$Res>
    extends _$AchWithFlagsCopyWithImpl<$Res, _$AchWithFlagsImpl>
    implements _$$AchWithFlagsImplCopyWith<$Res> {
  __$$AchWithFlagsImplCopyWithImpl(
      _$AchWithFlagsImpl _value, $Res Function(_$AchWithFlagsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ach = null,
    Object? unlocked = null,
    Object? rewarded = null,
  }) {
    return _then(_$AchWithFlagsImpl(
      ach: null == ach
          ? _value.ach
          : ach // ignore: cast_nullable_to_non_nullable
              as Achievement,
      unlocked: null == unlocked
          ? _value.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      rewarded: null == rewarded
          ? _value.rewarded
          : rewarded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AchWithFlagsImpl implements _AchWithFlags {
  const _$AchWithFlagsImpl(
      {required this.ach, this.unlocked = false, this.rewarded = false});

  @override
  final Achievement ach;
  @override
  @JsonKey()
  final bool unlocked;
  @override
  @JsonKey()
  final bool rewarded;

  @override
  String toString() {
    return 'AchWithFlags(ach: $ach, unlocked: $unlocked, rewarded: $rewarded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchWithFlagsImpl &&
            (identical(other.ach, ach) || other.ach == ach) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked) &&
            (identical(other.rewarded, rewarded) ||
                other.rewarded == rewarded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ach, unlocked, rewarded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AchWithFlagsImplCopyWith<_$AchWithFlagsImpl> get copyWith =>
      __$$AchWithFlagsImplCopyWithImpl<_$AchWithFlagsImpl>(this, _$identity);
}

abstract class _AchWithFlags implements AchWithFlags {
  const factory _AchWithFlags(
      {required final Achievement ach,
      final bool unlocked,
      final bool rewarded}) = _$AchWithFlagsImpl;

  @override
  Achievement get ach;
  @override
  bool get unlocked;
  @override
  bool get rewarded;
  @override
  @JsonKey(ignore: true)
  _$$AchWithFlagsImplCopyWith<_$AchWithFlagsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
