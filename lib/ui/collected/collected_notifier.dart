
import 'package:collection/collection.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/core/Providers/riverpod_providers.dart';
import 'package:myplantapp_ver1/domain/model/collected.dart';
import 'package:myplantapp_ver1/domain/repository/i_collected_repository.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'collected_notifier.g.dart';

@riverpod
class CollectedNotifier extends _$CollectedNotifier {
  final log = AppLogger.tag("CollectedNotifier");
  final uuid = Uuid();

  late int normalRate = 0;
  late int goldRate = 0;
  late int rainbowRate = 0;
  late int normalCount = 0;
  late int goldCount = 0;
  late int rainbowCount = 0;

  late final ICollectedRepository _collectedRepo;

  @override
  Future<List<Collected>> build() async {
    _collectedRepo = await ref.read(collectedRepositoryProvider.future);
    // 初回ロード
    await _load();
    return _collectedRepo.getAll();
  }



  Future<void> _load() async {
    final data = _collectedRepo.getAll();
    normalRate = await collectedRate(Variant.NORMAL);
    goldRate = await collectedRate(Variant.GOLD);
    rainbowRate = await collectedRate(Variant.RAINBOW);
    normalCount = await collectedCount(Variant.NORMAL);
    goldCount = await collectedCount(Variant.GOLD);
    rainbowCount = await collectedCount(Variant.RAINBOW);
    state = AsyncData(data);
  }

  // ✅ 例えば再読込を外から呼び出したい時
  Future<void> refresh() async {
    state = const AsyncLoading();
    await _load();
    state = AsyncData(await _collectedRepo.getAll());
  }

  /// 収穫/保存
  Future<void> addCollected(int plantId, Variant variant, Attribute attribute) async {
    log.d('🔥 addCollected 起動!');
    final collected = state.value?.firstWhereOrNull((p) => p.id == plantId && p.variant == variant);
    if(collected != null){
      final update = collected.copyWith(harvestCount: collected.harvestCount + 1);
      _collectedRepo.save(update);
    } else {
    final update = Collected(
    id: uuid.v4(),
    plantId: plantId,
    variant: variant,
    attribute: attribute,
    harvestCount: 1,
    lastHarvestedAt: DateTime.now().millisecondsSinceEpoch
    );
    await _collectedRepo.save(update);
    }
    log.d('✅ (plantId: $plantId,variant: $variant)保存完了しました!');
    // ✅ 再読込
   _load();
  }

  /// 削除
  Future<void> remove(int plantId, Variant variant) async {
    await _collectedRepo.remove(plantId, variant);

    _load();
  }

  /// 全削除（デバッグ）
  Future<void> clear() async {
    await _collectedRepo.clearAll();

    state = const AsyncData([]);
  }

  Future<int> collectedRate(Variant variant) async{
    final masterData = await ref.read(masterDataNotifierProvider.future);
    final mastarCount = masterData.plants.map((p) => p.id).toSet().length;
    final collected = _collectedRepo.getAll().where((p) => p.variant == variant);
    final collectedCount = collected.map((p) => p.id).toSet().length;

    return ((collectedCount/mastarCount) * 100).floor();
  }

  Future<int> collectedCount(Variant variant) async{
    final list = _collectedRepo.getAll();
    final l = list.where((p) => p.variant == variant);
    final collectedCount = l.map((p) => p.id).toSet().length;
    return collectedCount;
  }

  String getcompleteImage(List<Collected> collectedList) {
    if(collectedList.any((c) => c.variant == Variant.GOLD)){
      if(collectedList.any((c) => c.variant == Variant.RAINBOW)){
        return "assets/images/collected/crown_goldrainbow.webp";
      } else { return "assets/images/collected/crown_gold.webp";}
    } else if (collectedList.any((c) => c.variant == Variant.RAINBOW)){
      return "assets/images/collected/crown_rainbow.webp";
    } else {
      return "";
    }
  }

  bool isCollected(int plantId) {
    final list = state.value;
    if (list == null) return false;
    return list.any((i) => i.plantId == plantId);
  }

  bool isCollectedVariant(int plantId, Variant variant) {
    final list = state.value;
    if (list == null) return false;
    return list.any((i) => i.plantId == plantId && i.variant == variant);
  }

  /*
  ///（デバッグ用）
  Future<void> allAdd() async {
    final masterData = await ref.read(masterDataNotifierProvider.future);
    final plants = masterData.plants.where((c) => c.variant == Variant.NORMAL).toList();

    for (final plant in plants) {
      addCollected(plant.id, Variant.NORMAL, plant.attribute);
    }
    log.d('allAdd 完了!${plants.length}');
  }
  */
}