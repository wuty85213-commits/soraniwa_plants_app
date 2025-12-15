import 'package:myplantapp_ver1/data/entity/collected_entity.dart';
import 'package:myplantapp_ver1/data/entity/inventory_entity.dart';
import 'package:myplantapp_ver1/data/entity/pot_entity.dart';
import 'package:myplantapp_ver1/data/entity/user_entity.dart';
import 'package:myplantapp_ver1/data/entity/user_plant_entity.dart';
import 'package:myplantapp_ver1/domain/model/collected.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/model/pot.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';
import 'package:myplantapp_ver1/domain/model/user_plant.dart';

extension UserHiveMapper on UserEntity {
  User toDomain() {
    return User(
      id: id,
      userKey: userKey,
      coins: coins,
      unlockedSlots: unlockedSlots,
      actionFlags: actionFlags,
      rewardFlags: rewardFlags,
      isBgmOn: isBgmOn,
      isSeOn: isSeOn,
      languageCade: languageCade,
    );
  }
}

extension UserDomainMapper on User {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      userKey: userKey,
      coins: coins,
      unlockedSlots: unlockedSlots,
      actionFlags: actionFlags,
      rewardFlags: rewardFlags,
      isBgmOn: isBgmOn,
      isSeOn: isSeOn,
      languageCade: languageCade,
    );
  }
}

extension UserPlantHiveMapper on UserPlantEntity {
  UserPlant toDomain() {
    return UserPlant(
      id: id,
      plantId: plantId,
      variant: variant,
      progress: progress,
      growthBoost: growthBoost,
      lastWatered: lastWatered,
      lastUpdate: lastUpdate,
      plantCondition: plantCondition,
      slotIndex: slotIndex,
    );
  }
}

extension UserPlantDomainMapper on UserPlant {
  UserPlantEntity toEntity() {
    return UserPlantEntity(
      id: id,
      plantId: plantId,
      variant: variant,
      progress: progress,
      growthBoost: growthBoost,
      lastWatered: lastWatered,
      lastUpdate: lastUpdate,
      plantCondition: plantCondition,
      slotIndex: slotIndex,
    );
  }
}

extension InventoryHiveMapper on InventoryEntity {
  Inventory toDomain() {
    return Inventory(
      id: id,
      itemId: itemId,
      itemType: itemType,
      variant: variant,
      attribute: attribute,
      quantity: quantity,
    );
  }
}
extension InventoryDomainMapper on Inventory {
  InventoryEntity toEntity() {
    return InventoryEntity(
      id: id,
      itemId: itemId,
      itemType: itemType,
      variant: variant,
      attribute: attribute,
      quantity: quantity,
    );
  }
}

extension CollectedHiveMapper on CollectedEntity {
  Collected toDomain() {
    return Collected(
      id: id,
      plantId: plantId,
      variant: variant,
      attribute: attribute,
      harvestCount: harvestCount,
      lastHarvestedAt: lastHarvestedAt,
    );
  }
}
extension CollectedDomainMapper on Collected {
  CollectedEntity toEntity() {
    return CollectedEntity(
      id: id,
      plantId: plantId,
      variant: variant,
      attribute: attribute,
      harvestCount: harvestCount,
      lastHarvestedAt: lastHarvestedAt,
    );
  }
}

extension PotHiveMapper on PotEntity {
  Pot toDomain() {
    return Pot(
      id: id,
      slotIndex: slotIndex,
      itemId: itemId,
    );
  }
}
extension PotDomainMapper on Pot {
  PotEntity toEntity() {
    return PotEntity(
      id: id,
      slotIndex: slotIndex,
      itemId: itemId,
    );
  }
}