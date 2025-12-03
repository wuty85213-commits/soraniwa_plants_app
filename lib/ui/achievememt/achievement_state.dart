import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myplantapp_ver1/domain/model/achievement_model.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';
import 'package:myplantapp_ver1/ui/achievememt/widget/ach_with_flags.dart';

part 'achievement_state.freezed.dart';

@freezed
class AchievementState with _$AchievementState {
  const factory AchievementState({
    required User user,
    @Default([])List<AchWithFlags> list,
    @Default([])List<AchWithFlags> filteredList,
    @Default(false) bool loading,
    @Default(true) bool showUnlocked,
    @Default(true) bool showLocked,
    @Default(true) bool showReceived,
    @Default([])List<Achievement> newlyUnlocked,
  }) = _AchievementState;
}