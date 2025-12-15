import 'package:myplantapp_ver1/data/entity/collected_entity.dart';
import 'package:myplantapp_ver1/data/entity/user_entity.dart';
import 'package:myplantapp_ver1/domain/model/collected.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';

class Achievement {
  final String id;             // "ACH_CHARA60"
  final String titleKey;          // "キャラ60%コンプリート"
  final String descKey;    // "図鑑を60%埋めると達成"
  final AchievementReward reward;       // 報酬コイン量
  final bool Function(AchievementContext) condition; // 達成条件チェック関数

  Achievement({
    required this.id,
    required this.titleKey,
    required this.descKey,
    required this.reward,
    required this.condition,
  });
}

class AchievementContext {
  final User user;
  final List<Collected> collectedList;

  AchievementContext({
    required this.user,
    required this.collectedList,
  });
}

class AchievementReward {
  final int coins;
  final List<ItemReward> items;

  const AchievementReward({
    this.coins = 0,
    this.items = const [],
  });

  bool get hasReward => coins > 0 || items.isNotEmpty;
}

class ItemReward {
  final int itemId;
  final int quantity;

  const ItemReward({required this.itemId, required this.quantity});
}

