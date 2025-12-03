import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myplantapp_ver1/domain/model/pot.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    required User user,
    @Default([]) List<Pot> pots,
  }) = _UserState;
}