import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myplantapp_ver1/domain/model/achievement_model.dart';

part 'ach_with_flags.freezed.dart';
@freezed
class AchWithFlags with _$AchWithFlags {
  const factory AchWithFlags({
    required Achievement ach,
    @Default(false) bool unlocked,
    @Default(false) bool rewarded,
  }) = _AchWithFlags;
}