import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/domain/model/achievement_model.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';

final List<Achievement> achievementList = [


  /*
  //チュートリアル系
  Achievement(
    id: "ACH_FIRSTBUY",
    titleKey: "ach_FIRSTBUY_title",
    descKey: "ach_FIRSTBUY_desc",
    reward: AchievementReward(
      coins: 100
    ),
    condition: (ctx) =>
        (ctx.user.actionFlags ?? []).contains("BOUGHT_ITEM"),
  ),

  Achievement(
    id: "ACH_FIRSTHARVEST",
    titleKey: "ach_FIRSTHARVEST_title",
    descKey: "ach_FIRSTHARVEST_desc",
    reward: AchievementReward(
        coins: 100
    ),
    condition: (ctx) =>
        (ctx.user.actionFlags ?? []).contains("HARVEST_PLANT"),
  ),

   */
  //属性コンプリート
  Achievement(
    id: "ACH_Leafy",
    titleKey: "ach_Leafy_title",
    descKey: "ach_Leafy_desc",
    reward: AchievementReward(
        coins: 500,
        items: [ItemReward(itemId: 104, quantity: 3)]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.attribute == Attribute.leafy)
        .map((c) => c.plantId)
        .toSet()
        .length >= 6,
  ),

  Achievement(
    id: "ACH_Bloom",
    titleKey: "ach_Bloom_title",
    descKey: "ach_Bloom_desc",
    reward: AchievementReward(
        coins: 1000,
        items: [ItemReward(itemId: 107, quantity: 3)]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.attribute == Attribute.bloom)
        .map((c) => c.plantId)
        .toSet()
        .length >= 6,
  ),

  Achievement(
    id: "ACH_Tree",
    titleKey: "ach_Tree_title",
    descKey: "ach_Tree_desc",
    reward: AchievementReward(
        coins: 1500,
        items: [ItemReward(itemId: 110, quantity: 3)]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.attribute == Attribute.tree)
        .map((c) => c.plantId)
        .toSet()
        .length >= 6,
  ),

  Achievement(
    id: "ACH_Fun",
    titleKey: "ach_Fun_title",
    descKey: "ach_Fun_desc",
    reward: AchievementReward(
        coins: 2000,
        items: [ItemReward(itemId: 113, quantity: 3)]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.attribute == Attribute.fun)
        .map((c) => c.plantId)
        .toSet()
        .length >= 6,
  ),

  Achievement(
    id: "ACH_Odd",
    titleKey: "ach_Odd_title",
    descKey: "ach_Odd_desc",
    reward: AchievementReward(
        coins: 2000,
        items: [ItemReward(itemId: 401, quantity: 3)]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.attribute == Attribute.odd)
        .map((c) => c.plantId)
        .toSet()
        .length >= 6,
  ),

  //ノーマルキャラコンプリート系
  Achievement(
    id: "ACH_NORMAL1",
    titleKey: "ach_NORMAL1_title",
    descKey: "ach_NORMAL1_desc",
    reward: AchievementReward(
        coins: 100,
        items: [ItemReward(itemId: 201, quantity: 1)]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.NORMAL)
        .map((c) => c.plantId)
        .toSet()
        .length >= 1,
  ),

  Achievement(
    id: "ACH_NORMAL5",
    titleKey: "ach_NORMAL5_title",
    descKey: "ach_NORMAL5_desc",
    reward: AchievementReward(
        coins: 300,
        items: [ItemReward(itemId: 201, quantity: 1)]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.NORMAL)
        .map((c) => c.plantId)
        .toSet()
        .length >= 5,
  ),

  Achievement(
    id: "ACH_NORMAL10",
    titleKey: "ach_NORMAL10_title",
    descKey: "ach_NORMAL10_desc",
    reward: AchievementReward(
        coins: 500,
        items: [
          ItemReward(itemId: 201, quantity: 3),
        ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.NORMAL)
        .map((c) => c.plantId)
        .toSet()
        .length >= 10,
  ),

  Achievement(
    id: "ACH_NORMAL15",
    titleKey: "ach_NORMAL15_title",
    descKey: "ach_NORMAL15_desc",
    reward: AchievementReward(
        coins: 500,
        items: [
          ItemReward(itemId: 201, quantity: 1),
          ItemReward(itemId: 301, quantity: 1),
        ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.NORMAL)
        .map((c) => c.plantId)
        .toSet()
        .length >= 15,
  ),

  Achievement(
    id: "ACH_NORMAL20",
    titleKey: "ach_NORMAL20_title",
    descKey: "ach_NORMAL20_desc",
    reward: AchievementReward(
        coins: 800,
        items: [
          ItemReward(itemId: 102, quantity: 1),
          ItemReward(itemId: 201, quantity: 1),
          ItemReward(itemId: 301, quantity: 1),
          ItemReward(itemId: 302, quantity: 1),
        ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.NORMAL)
        .map((c) => c.plantId)
        .toSet()
        .length >= 20,
  ),

  Achievement(
    id: "ACH_NORMAL25",
    titleKey: "ach_NORMAL25_title",
    descKey: "ach_NORMAL25_desc",
    reward: AchievementReward(
        coins: 800,
        items: [
          ItemReward(itemId: 201, quantity: 3),
          ItemReward(itemId: 301, quantity: 3),
          ItemReward(itemId: 302, quantity: 3),
        ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.NORMAL)
        .map((c) => c.plantId)
        .toSet()
        .length >= 25,
  ),

  Achievement(
    id: "ACH_NORMAL30",
    titleKey: "ach_NORMAL30_title",
    descKey: "ach_NORMAL30_desc",
    reward: AchievementReward(
        coins: 1000,
        items: [
          ItemReward(itemId: 103, quantity: 1),
          ItemReward(itemId: 509, quantity: 1),
        ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.NORMAL)
        .map((c) => c.plantId)
        .toSet()
        .length >= 30,
  ),

  //ゴールドキャラコンプリート系

  Achievement(
    id: "ACH_GOLD1",
    titleKey: "ach_GOLD1_title",
    descKey: "ach_GOLD1_desc",
    reward: AchievementReward(
      coins: 1000,
      items: [
        ItemReward(itemId: 301, quantity: 1),
        ItemReward(itemId: 302, quantity: 1),
      ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.GOLD)
        .map((c) => c.plantId)
        .toSet()
        .length >= 1,
  ),

  Achievement(
    id: "ACH_GOLD5",
    titleKey: "ach_GOLD5_title",
    descKey: "ach_GOLD5_desc",
    reward: AchievementReward(
      coins: 2000,
        items: [ItemReward(itemId: 102, quantity: 1),]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.GOLD)
        .map((c) => c.plantId)
        .toSet()
        .length >= 5,
  ),

  Achievement(
    id: "ACH_GOLD10",
    titleKey: "ach_GOLD10_title",
    descKey: "ach_GOLD10_desc",
    reward: AchievementReward(
      coins: 3000,
        items: [ItemReward(itemId: 105, quantity: 1),]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.GOLD)
        .map((c) => c.plantId)
        .toSet()
        .length >= 10,
  ),

  Achievement(
    id: "ACH_GOLD15",
    titleKey: "ach_GOLD15_title",
    descKey: "ach_GOLD15_desc",
    reward: AchievementReward(
      coins: 4000,
        items: [ItemReward(itemId: 108, quantity: 1),]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.GOLD)
        .map((c) => c.plantId)
        .toSet()
        .length >= 15,
  ),

  Achievement(
    id: "ACH_GOLD20",
    titleKey: "ach_GOLD20_title",
    descKey: "ach_GOLD20_desc",
    reward: AchievementReward(
      coins: 5000,
        items: [ItemReward(itemId: 111, quantity: 1),]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.GOLD)
        .map((c) => c.plantId)
        .toSet()
        .length >= 20,
  ),

  Achievement(
    id: "ACH_GOLD25",
    titleKey: "ach_GOLD25_title",
    descKey: "ach_GOLD25_desc",
    reward: AchievementReward(
      coins: 8000,
        items: [ItemReward(itemId: 114, quantity: 1),]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.GOLD)
        .map((c) => c.plantId)
        .toSet()
        .length >= 25,
  ),

  Achievement(
    id: "ACH_GOLD30",
    titleKey: "ach_GOLD30_title",
    descKey: "ach_GOLD30_desc",
    reward: AchievementReward(
        coins: 10000,
        items: [ItemReward(itemId: 501, quantity: 1),]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.GOLD)
        .map((c) => c.plantId)
        .toSet()
        .length >= 30,
  ),

  //レインボーキャラコンプリート系

  Achievement(
    id: "ACH_RAINBOW1",
    titleKey: "ach_RAINBOW1_title",
    descKey: "ach_RAINBOW1_desc",
    reward: AchievementReward(
        coins: 1000,
        items: [ItemReward(itemId: 401, quantity: 1)]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.RAINBOW)
        .map((c) => c.plantId)
        .toSet()
        .length >= 1,
  ),

  Achievement(
    id: "ACH_RAINBOW5",
    titleKey: "ach_RAINBOW5_title",
    descKey: "ach_RAINBOW5_desc",
    reward: AchievementReward(
        coins: 2000,
        items: [
          ItemReward(itemId: 103, quantity: 1),
          ItemReward(itemId: 401, quantity: 1),
        ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.RAINBOW)
        .map((c) => c.plantId)
        .toSet()
        .length >= 5,
  ),

  Achievement(
    id: "ACH_RAINBOW10",
    titleKey: "ach_RAINBOW10_title",
    descKey: "ach_RAINBOW10_desc",
    reward: AchievementReward(
        coins: 3000,
        items: [
          ItemReward(itemId: 106, quantity: 1),
          ItemReward(itemId: 401, quantity: 1),
        ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.RAINBOW)
        .map((c) => c.plantId)
        .toSet()
        .length >= 10,
  ),

  Achievement(
    id: "ACH_RAINBOW15",
    titleKey: "ach_RAINBOW15_title",
    descKey: "ach_RAINBOW15_desc",
    reward: AchievementReward(
        coins: 3000,
        items: [
          ItemReward(itemId: 109, quantity: 1),
          ItemReward(itemId: 401, quantity: 1),
        ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.RAINBOW)
        .map((c) => c.plantId)
        .toSet()
        .length >= 15,
  ),

  Achievement(
    id: "ACH_RAINBOW20",
    titleKey: "ach_RAINBOW20_title",
    descKey: "ach_RAINBOW20_desc",
    reward: AchievementReward(
        coins: 5000,
        items: [
          ItemReward(itemId: 112, quantity: 1),
          ItemReward(itemId: 401, quantity: 1),
        ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.RAINBOW)
        .map((c) => c.plantId)
        .toSet()
        .length >= 20,
  ),

  Achievement(
    id: "ACH_RAINBOW25",
    titleKey: "ach_RAINBOW25_title",
    descKey: "ach_RAINBOW25_desc",
    reward: AchievementReward(
        coins: 5000,
        items: [
          ItemReward(itemId: 115, quantity: 1),
          ItemReward(itemId: 401, quantity: 1),
        ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.RAINBOW)
        .map((c) => c.plantId)
        .toSet()
        .length >= 25,
  ),

  Achievement(
    id: "ACH_RAINBOW30",
    titleKey: "ach_RAINBOW30_title",
    descKey: "ach_RAINBOW30_desc",
    reward: AchievementReward(
        coins: 5000,
        items: [
          ItemReward(itemId: 401, quantity: 1),
          ItemReward(itemId: 502, quantity: 1),
        ]
    ),
    condition: (ctx) => ctx.collectedList
        .where((c) => c.variant == Variant.RAINBOW)
        .map((c) => c.plantId)
        .toSet()
        .length >= 30,
  ),
];

extension L10nGetString on AppLocalizations {
  String getString(String key) {
    switch (key) {
    case "ach_FIRSTBUY_title": return ach_FIRSTBUY_title;
    case "ach_FIRSTBUY_desc": return ach_FIRSTBUY_desc;
    case "ach_FIRSTHARVEST_title": return ach_FIRSTHARVEST_title;
    case "ach_FIRSTHARVEST_desc": return ach_FIRSTHARVEST_desc;
    case "ach_Leafy_title": return ach_Leafy_title;
    case "ach_Leafy_desc": return ach_Leafy_desc;
    case "ach_Bloom_title": return ach_Bloom_title;
    case "ach_Bloom_desc": return ach_Bloom_desc;
    case "ach_Tree_title": return ach_Tree_title;
    case "ach_Tree_desc": return ach_Tree_desc;
    case "ach_Fun_title": return ach_Fun_title;
    case "ach_Fun_desc": return ach_Fun_desc;
    case "ach_Odd_title": return ach_Odd_title;
    case "ach_Odd_desc": return ach_Odd_desc;
    case "ach_NORMAL1_title": return ach_NORMAL1_title;
    case "ach_NORMAL1_desc": return ach_NORMAL1_desc;
    case "ach_NORMAL5_title": return ach_NORMAL5_title;
    case "ach_NORMAL5_desc": return ach_NORMAL5_desc;
    case "ach_NORMAL10_title": return ach_NORMAL10_title;
    case "ach_NORMAL10_desc": return ach_NORMAL10_desc;
    case "ach_NORMAL15_title": return ach_NORMAL15_title;
    case "ach_NORMAL15_desc": return ach_NORMAL15_desc;
    case "ach_NORMAL20_title": return ach_NORMAL20_title;
    case "ach_NORMAL20_desc": return ach_NORMAL20_desc;
    case "ach_NORMAL25_title": return ach_NORMAL25_title;
    case "ach_NORMAL25_desc": return ach_NORMAL25_desc;
    case "ach_NORMAL30_title": return ach_NORMAL30_title;
    case "ach_NORMAL30_desc": return ach_NORMAL30_desc;
    case "ach_GOLD1_title": return ach_GOLD1_title;
    case "ach_GOLD1_desc": return ach_GOLD1_desc;
    case "ach_GOLD5_title": return ach_GOLD5_title;
    case "ach_GOLD5_desc": return ach_GOLD5_desc;
    case "ach_GOLD10_title": return ach_GOLD10_title;
    case "ach_GOLD10_desc": return ach_GOLD10_desc;
    case "ach_GOLD15_title": return ach_GOLD15_title;
    case "ach_GOLD15_desc": return ach_GOLD15_desc;
    case "ach_GOLD20_title": return ach_GOLD20_title;
    case "ach_GOLD20_desc": return ach_GOLD20_desc;
    case "ach_GOLD25_title": return ach_GOLD25_title;
    case "ach_GOLD25_desc": return ach_GOLD25_desc;
    case "ach_GOLD30_title": return ach_GOLD30_title;
    case "ach_GOLD30_desc": return ach_GOLD30_desc;
    case "ach_RAINBOW1_title": return ach_RAINBOW1_title;
    case "ach_RAINBOW1_desc": return ach_RAINBOW1_desc;
    case "ach_RAINBOW5_title": return ach_RAINBOW5_title;
    case "ach_RAINBOW5_desc": return ach_RAINBOW5_desc;
    case "ach_RAINBOW10_title": return ach_RAINBOW10_title;
    case "ach_RAINBOW10_desc": return ach_RAINBOW10_desc;
    case "ach_RAINBOW15_title": return ach_RAINBOW15_title;
    case "ach_RAINBOW15_desc": return ach_RAINBOW15_desc;
    case "ach_RAINBOW20_title": return ach_RAINBOW20_title;
    case "ach_RAINBOW20_desc": return ach_RAINBOW20_desc;
    case "ach_RAINBOW25_title": return ach_RAINBOW25_title;
    case "ach_RAINBOW25_desc": return ach_RAINBOW25_desc;
    case "ach_RAINBOW30_title": return ach_RAINBOW30_title;
    case "ach_RAINBOW30_desc": return ach_RAINBOW30_desc;
    }
    return key;
  }
}