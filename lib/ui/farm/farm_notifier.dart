import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/core/Providers/farm_ticker_provider.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/core/language/locale_notifier.dart';
import 'package:myplantapp_ver1/core/Providers/riverpod.dart';
import 'package:myplantapp_ver1/domain/model/harvest_result_model.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/model/user_plant.dart';
import 'package:myplantapp_ver1/domain/repository/i_user_plant_repository.dart';
import 'package:myplantapp_ver1/ui/collected/collected_notifier.dart';
import 'package:myplantapp_ver1/ui/common/inventory_notifier.dart';
import 'package:myplantapp_ver1/ui/common/user_notifier.dart';
import 'package:myplantapp_ver1/ui/common/user_state.dart';
import 'package:myplantapp_ver1/ui/farm/farm_state.dart';
import 'package:myplantapp_ver1/usecase/seed_item_handler.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';
import 'package:myplantapp_ver1/ui/master/master_data_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'farm_notifier.g.dart';

@riverpod
class FarmNotifier extends _$FarmNotifier {
  final log = AppLogger.tag("FarmNotifier🏆");
  final uuid = Uuid();
  late final IUserPlantRepository _userPlantRepo;
  late final MasterDataState _masterData;
  late final UserState _userState;
  late final UserNotifier _userNf;
  late final CollectedNotifier _collectedNf;
  late final InventoryNotifier _inventoryNf;
  late final  Locale? _locale;

  @override
  Future<FarmState> build() async {

    log.d("🔥 FarmNotifier build()");

    _userPlantRepo = await ref.read(userPlantRepositoryProvider.future);
    _masterData = await ref.read(masterDataNotifierProvider.future);
    _userState = await ref.read(userNotifierProvider.future);
    _userNf = ref.read(userNotifierProvider.notifier);
    _inventoryNf = ref.read(inventoryNotifierProvider.notifier);
    _collectedNf = ref.read(collectedNotifierProvider.notifier);
    _locale = ref.read(localeNotifierProvider).value;


    await _load();

    // 🟩 build 完了後に updatePlantStatuses を 1 回実行！
    Future.microtask(() async {
      try {
        await updatePlantStatuses();
      } catch (e, st) {
        log.e("error : $e\n$st");
      }
    });

    ref.listen<AsyncValue<DateTime>>(
      farmTickerProvider,
          (prev, next) async {
        next.whenData((_) async {
          await updatePlantStatuses();
        });
      },
    );
    return state.requireValue;
  }

  Future<void> _load() async {
    try {
      final userPlant = await _userPlantRepo.getAllUserPlants();
      state = AsyncData(
        FarmState(
          userPlants: userPlant,
        )
      );

    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  //スロット拡張
  Future<bool> plantUnlock() async{
    final user = _userState.user;
    final price = await _userNf.slotPrice();
    log.d('plantUnlock 起動!${price}');

    if(user.unlockedSlots > 5) {
      log.e('これ以上、鉢スロットを増やすことはできません : unlockslot${user.unlockedSlots}');
      return false;
    }
    if(user.coins < price) {
      log.e('コインが不足しています : userCoin(${user.coins}) < slotPrice($price)');
      return false;
    }
    final updated = user.copyWith(
        unlockedSlots: user.unlockedSlots + 1,
        coins: user.coins - price
    );
    _userNf.save(updated);
    return true;
  }

  /// 🌱 植付け
  Future<void> plantSeed({
    required int slotIndex,
    required Inventory seedItem,
    List<Inventory> buffItems = const [],
  }) async {
    //final code = _locale?.languageCode ?? 'ja';
    final existing = state.requireValue.userPlants.firstWhereOrNull((p) => p.slotIndex == slotIndex);
    if(existing != null) {
      log.e('植付エラー！スロットは空ではありませんでした。');
      return;
    }
    final handler = SeedItemHandler();
    final chosenPlant = handler.drawPlant(
      plants: _masterData.plants,
      seedItem: seedItem,
      buffItems: buffItems,
    );
    if (chosenPlant == null) {
      log.e('プラントの選出がうまくいきませんでした。');
      return;}
    final growthBoost = buffItems.any(
          (item) => item.itemType == ItemType.growthBoost,
    ) ? 2 : 1;

    final newUserPlant = UserPlant(
        id: uuid.v4(),
        plantId: chosenPlant.id,
        variant: chosenPlant.variant,
        progress: 0.0,
        growthBoost: growthBoost,
        lastWatered: DateTime.now().millisecondsSinceEpoch,
        lastUpdate: DateTime.now().millisecondsSinceEpoch,
        plantCondition: PlantCondition.wet,
        slotIndex: slotIndex,
    );

    await _userPlantRepo.addPlant(newUserPlant);


    //final time = ( (_growthTimeByRarity(chosenPlant.rarity) * 3)/growthBoost ).floor();
    //await requestExactAlarmPermission();
    //await NotificationService.scheduleHarvestNotification(
     // localeCode: code,
    //  slotIndex: slotIndex,
    //  delayMs: time,
    //);



    await _load();
  }

  /// 💧 水やり
  Future<void> waterPlant(String id) async {
    final plant = state.requireValue.userPlants.firstWhere((p) => p.id == id);
    if (plant.plantCondition != PlantCondition.wither) {
      final update = plant.copyWith(
          lastWatered: DateTime.now().millisecondsSinceEpoch,
          plantCondition: PlantCondition.wet
      );
      await _userPlantRepo.save(update);
    }
    await _load();
  }

  Future<void> removePlant(String id, int slotIndex) async {
    await _userPlantRepo.removePlant(id);
    //await NotificationService.cancel(slotIndex+2000);
    await _load();
  }

  //収穫
  Future<HarvestResult?> harvestPlant(String id) async {
    try {
      final current = state.requireValue;
      final plant = current.userPlants.firstWhere((p) => p.id == id);
      if(plant.stage < 3) return null;

      final master = _masterData.plants.firstWhere((p) =>
      p.id == plant.plantId && p.variant == plant.variant);

      final coins = [0, 30, 50, 100, 3000, 5000][master.rarity];
      final rewardItem = _masterData.items.firstWhere((p) =>
      p.variant == plant.variant && p.attribute == master.attribute);
      final seeds = _getSeedQty(plant.variant);

      // ① UIから plant を即時削除する
      final updatedPlants = current.userPlants.where((p) => p.id != id).toList();

      state = AsyncData(
          current.copyWith(userPlants: updatedPlants)
      );

      await _userPlantRepo.removePlant(id);
      await _userNf.addCoin(coins);
      final addItem = await _inventoryNf.addItem(rewardItem.id, seeds);
      if(addItem == false) { log.e('アイテムが正常に保存できませんでした');}

      await _collectedNf.addCollected(plant.plantId, plant.variant,master.attribute);

      await _load();

      return HarvestResult(
        plant: master,
        item: rewardItem,
        coins: coins,
        seeds: seeds,
      );
    } catch (e,stack) {
      log.e('🌋 収穫処理中にエラー発生: $e\n$stack');
      return null;
    }
  }

  /// 🌿 成長ロジック
  Future<void> updatePlantStatuses() async{
    final value = state.value;
    if(value == null) return;

    final updatedList = <UserPlant>[];
    final masterList = _masterData.plants;
    final now = DateTime.now().millisecondsSinceEpoch;

    const moistDuration = 2 * 60 * 60 * 1000; //2時間
    const oneWeekMillis = 7 * 24 * 60 * 60 * 1000; //7日

    final plants = value.userPlants;

    for (final plant in plants) {
      final master = masterList.firstWhere(
            (m) => m.id == plant.plantId && m.variant == plant.variant,
        orElse: () => masterList.first,
      );
      //log.d("MsName:${master.id},${master.name},${master.variant},${master.rarity}"
         // " UPInfo:${plant.plantId},${plant.variant}");

      final baseGrowth = _growthTimeByRarity(master.rarity);
      final growthTime = max(1,(baseGrowth / plant.growthBoost).floor());

      final moistElapsedNow = (now - plant.lastWatered).clamp(0, moistDuration);
      final moistElapsedPrev = (plant.lastUpdate - plant.lastWatered).clamp(0, moistDuration);

      final deltaMoist = max(0, moistElapsedNow - moistElapsedPrev);

      double progress = plant.progress;
      var updatedPlant = plant;
      //log.d('baseG:${baseGrowth},Rare:${master.rarity},growthtime:${growthTime},mositNow:${moistElapsedNow},moistPv:${moistElapsedPrev}'
         // ',delta:${deltaMoist},lastU:${plant.lastUpdate},lastW:${plant.lastWatered},now:${now}');

      if (plant.plantCondition == PlantCondition.wet) {
        progress +=  deltaMoist / growthTime;
        progress = progress.clamp(0.0, 1.0);

        updatedPlant = updatedPlant.copyWith(
          progress: progress,
          plantCondition: (now - plant.lastWatered >= moistDuration)
              ? PlantCondition.dry
              : PlantCondition.wet,
          lastUpdate: now,
        );
      } else if (plant.plantCondition == PlantCondition.dry) {
        final dryElapsed = max(0, now - (plant.lastWatered + moistDuration));
        log.i('植え付けから${dryElapsed}が経過しています。一週間は(${oneWeekMillis})');
        final newCondition = (dryElapsed >= oneWeekMillis)
            ? PlantCondition.wither
            : PlantCondition.dry;
        updatedPlant = updatedPlant.copyWith(
          plantCondition: newCondition,
          lastUpdate: now,
        );
      }
      await _userPlantRepo.save(updatedPlant);
      updatedList.add(updatedPlant);
      log.d('プラント状態 スロット${updatedPlant.slotIndex} progress: ${updatedPlant.progress}');
    }
    state = AsyncData(
      value.copyWith(userPlants: updatedList),
    );
    log.d('植物の状態を更新しました');
  }

  int _growthTimeByRarity(int rarity) => switch (rarity) {
    1 => 2 * 60 * 60 * 1000,
    2 => 3 * 60 * 60 * 1000,
    3 => 4 * 60 * 60 * 1000,
    4 => 5 * 60 * 60 * 1000,
    5 => 6 * 60 * 60 * 1000,
    _ => 2 * 60 * 60 * 1000,
  };
  
  int _getSeedQty(Variant variant) {
    if (variant == Variant.NORMAL) {
      // 今までの 1〜3 の処理
      return Random().nextInt(3) + 1;
    } else {
      // NORMAL 以外は 10% で 1、90% で 0
      return Random().nextInt(100) < 10 ? 1 : 0;
    }
  }
}