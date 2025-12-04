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
extension UserExtensions on User {
  /// コイン数を省略表記（K / M）で返す
  String get coinsFormatted {
    final value = coins;

    if (value >= 1000000) {
      double m = value / 1000000;
      return "${m.toStringAsFixed(m < 10 ? 1 : 0)}M";
    }

    return value.toString();
  }
}
