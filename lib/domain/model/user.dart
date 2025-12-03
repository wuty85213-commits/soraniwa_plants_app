import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String userKey,
    required int coins,
    required int unlockedSlots,
    required List<String> actionFlags,
    required List<String> rewardFlags,
    required bool isBgmOn,
    required bool isSeOn,
    String? languageCade,
  }) = _User;
}