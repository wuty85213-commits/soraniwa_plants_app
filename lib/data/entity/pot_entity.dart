import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'pot_entity.g.dart';

/// =============================
/// 🧩 Hive版 UserEntity モデル
/// =============================
@HiveType(typeId: 16)
class PotEntity extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  int slotIndex;

  /// 育成中の代表プラント
  @HiveField(2)
  int itemId;

  PotEntity({
    String? id,
    required this.slotIndex,
    this.itemId = 500,
  }) : id = id ?? const Uuid().v4();
}
