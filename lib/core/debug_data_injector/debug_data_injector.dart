import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/env.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/core/Providers/riverpod.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/model/user_plant.dart';
import 'package:myplantapp_ver1/ui/collected/collected_notifier.dart';
import 'package:myplantapp_ver1/ui/common/user_notifier.dart';
import 'package:myplantapp_ver1/ui/farm/farm_notifier.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_data_injector.g.dart';

@riverpod
class DebugDataInjector extends _$DebugDataInjector {
  bool _hasInjected = false;
  final log = AppLogger.tag('DebugDI🧪');

  @override
  Future<void> build() async {
  }

  Future<void> injectIfNeeded() async {
    if (!EnvConfig.isDev) return;

    if (_hasInjected) {
      log.d('⏩ すでにデバッグデータ注入済み（同一セッション）');
      return;
    }

    log.d('開発モード → テストデータ注入開始');

    // ✅ Repository取得（FutureProviderのfuture版）
    final userState = await ref.read(userNotifierProvider.future);
    final userPlantRepo = await ref.read(userPlantRepositoryProvider.future);
    final inventoryRepo = await ref.read(inventoryRepositoryProvider.future);
    final userNf = ref.read(userNotifierProvider.notifier);
    final collNf = ref.read(collectedNotifierProvider.notifier);
    final masterData = ref.read(masterDataNotifierProvider.notifier);
    final now = DateTime.now();
    final twoHoursAgo = now.subtract(const Duration(hours: 2)).millisecondsSinceEpoch;

    //await userNf.addCoin(50000);



    // ✅ サンプル植え付け
    final userPlant = UserPlant(
      id: "debug_1",
      plantId: 2,
      variant: Variant.GOLD,
      progress: 1.0,
      growthBoost: 1,
      lastWatered: twoHoursAgo,
      lastUpdate: 0,
      plantCondition: PlantCondition.dry,
      slotIndex: 0,
    );
    await userPlantRepo.save(userPlant);
    final userPlant2 = UserPlant(
      id: "debug_2",
      plantId: 1,
      variant: Variant.NORMAL,
      progress: 0.8,
      growthBoost: 1,
      lastWatered: twoHoursAgo,
      lastUpdate: 0,
      plantCondition: PlantCondition.dry,
      slotIndex: 1,
    );
    await userPlantRepo.save(userPlant2);
    final userPlant3 = UserPlant(
      id: "debug_3",
      plantId: 1,
      variant: Variant.NORMAL,
      progress: 0.2,
      growthBoost: 1,
      lastWatered: twoHoursAgo,
      lastUpdate: 0,
      plantCondition: PlantCondition.dry,
      slotIndex: 2,
    );
    await userPlantRepo.save(userPlant3);
    log.d('🎁 アイテムを付与しました: PlantId${userPlant.plantId},スロット ${userPlant.slotIndex}'
    'PlantId${userPlant2.plantId},スロット ${userPlant2.slotIndex}');
    // ✅ アイテム追加


      final newObject1 = Inventory(
          id: 'aaa1',
          itemId:500,
          itemType: ItemType.decoration,
          quantity: 1
      );
      await inventoryRepo.save(newObject1);
      final newObject2 = Inventory(
          id: 'aaa2',
          itemId:501,
          itemType: ItemType.decoration,
          quantity: 1
      );
      await inventoryRepo.save(newObject2);

      final newObject3 = Inventory(
          id: 'aaa3',
          itemId:502,
          itemType: ItemType.decoration,
          quantity: 1
      );
      await inventoryRepo.save(newObject3);

    final newObject4 = Inventory(
        id: 'aaa1',
        itemId:101,
        itemType: ItemType.seed,
        variant: Variant.NORMAL,
        attribute: Attribute.leafy,
        quantity: 3
    );
    await inventoryRepo.save(newObject4);

    final updated = userState.user.copyWith(
      coins: 50000,
      unlockedSlots: userState.user.unlockedSlots + 2,
    );
    await userNf.save(updated);

    await collNf.addCollected(2, Variant.NORMAL, Attribute.leafy);
    await collNf.addCollected(3, Variant.NORMAL, Attribute.leafy);
    await collNf.addCollected(4, Variant.NORMAL, Attribute.leafy);
    // await collNf.addCollected(5, Variant.NORMAL, Attribute.leafy);
    await collNf.addCollected(6, Variant.NORMAL, Attribute.leafy);





    log.d('✅ テストデータ注入完了');

    _hasInjected = true;
  }
}