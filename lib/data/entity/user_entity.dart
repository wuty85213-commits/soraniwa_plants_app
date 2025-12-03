import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'user_entity.g.dart';

/// =============================
/// 🧩 Hive版 UserEntity モデル
/// =============================
@HiveType(typeId: 10)
class UserEntity extends HiveObject {
  /// 🔑 Realmの ObjectId → String(UUID) に変更
  @HiveField(0)
  String id;

  /// 育成中の代表プラント
  @HiveField(1)
  String userKey;

  /// 所持コイン
  @HiveField(2)
  int coins;

  /// 解放スロット数（初期1）
  @HiveField(3)
  int unlockedSlots;

  @HiveField(4)
  List<String> actionFlags;

  /// 獲得済みリワードのフラグ
  @HiveField(5)
  List<String> rewardFlags;

  @HiveField(6, defaultValue: true)
  bool isBgmOn;

  @HiveField(7, defaultValue: true)
  bool isSeOn;

  @HiveField(8)
  String? languageCade;


  UserEntity({
    String? id,
    required this.userKey,
    required this.coins,
    required this.unlockedSlots,
    List<String>? actionFlags,
    List<String>? rewardFlags,
    this.isBgmOn = true,
    this.isSeOn = true,
    this.languageCade,
  }) : id = id ?? const Uuid().v4(),
  actionFlags = actionFlags ?? [],
  rewardFlags = rewardFlags ?? [];
}

