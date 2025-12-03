import 'dart:math';

import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';

class SeedItemHandler {
  final log = AppLogger.tag("ItemHandler");
  final Random _rng = Random();

  PlantMasterEntity? drawPlant({
    required List<PlantMasterEntity> plants,
    required Inventory seedItem,
    required List<Inventory> buffItems,
  }) {
    log.d('seedInfo:${seedItem.itemId},${seedItem.variant},${seedItem.attribute}');
    // GOLD/RAINBOW種
    if (seedItem.variant == Variant.GOLD || seedItem.variant == Variant.RAINBOW) {
      final pool = plants.where(
            (p) =>
        p.attribute == seedItem.attribute &&
            p.variant == seedItem.variant,
      );
      if (pool.isEmpty) {
        log.w('プラントデータが存在しません: var_${seedItem.variant}');
        return null;
      }
      return pool.elementAt(_rng.nextInt(pool.length));
    }

    // NORMAL種
    final pool = plants
        .where((p) => p.attribute == seedItem.attribute)
        .toList();

    if (pool.isEmpty) {
      log.w('プラントデータが存在しません: var_${seedItem.variant}');
      return null;
    }

    Map<int, double> rates = {1: .5, 2: .3, 3: .15, 4: .04, 5: .01};

    if (buffItems.any((i) => i.itemType == ItemType.rarerateboostRow)) {
      rates = {1: .3, 2: .5, 3: .15, 4: .04, 5: .01};
    }
    if (buffItems.any((i) => i.itemType == ItemType.rarerateboostHigh)) {
      rates = {1: .15, 2: .3, 3: .5, 4: .04, 5: .01};
    }
    if (buffItems.any((i) => i.itemType == ItemType.rarerateboostSuper)) {
      rates[4] = rates[4]! * 2;
      rates[5] = rates[5]! * 2;
      final total = rates.values.reduce((a, b) => a + b);
      rates = rates.map((k, v) => MapEntry(k, v / total));
    }

    final roll = _rng.nextDouble();
    double cumulative = 0;
    int chosenRarity = 1;
    for (final entry in rates.entries) {
      cumulative += entry.value;
      if (roll <= cumulative) {
        chosenRarity = entry.key;
        break;
      }
    }

    final candidates = pool.where((p) => p.rarity == chosenRarity).toList();
    if (candidates.isEmpty) return null;

    final selected = candidates[_rng.nextInt(candidates.length)];
    log.d('roll:${roll},selected:${selected.name},${selected.variant},${selected.attribute},${selected.rarity}');

    return selected;
  }
}