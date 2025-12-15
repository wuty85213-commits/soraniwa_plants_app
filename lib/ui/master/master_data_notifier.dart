import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/core/Providers/riverpod_providers.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/ui/master/master_data_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'master_data_notifier.g.dart';

@Riverpod(keepAlive: true)
class MasterDataNotifier extends _$MasterDataNotifier {
  final log = AppLogger.tag("MaterDataNotifier📚");

  @override
  Future<MasterDataState> build() async {
    log.i('🔥 MasterDataNotifier build()');
    final result = await _load();
    log.i('✅ MasterData loaded: plants=${result.plants.length}, items=${result.items.length}');
    return result;
  }

  Future<MasterDataState> _load({String localeCode = 'ja'}) async {

    final plantRepo = await ref.read(plantMasterRepositoryProvider.future);
    final itemRepo  = await ref.read(itemMasterRepositoryProvider.future);

    try {
      log.d('plant&itemMasterRepository,Load_Start!');
      await Future.wait([
        plantRepo.loadAll(localeCode: localeCode),
        itemRepo.loadAll(localeCode: localeCode),
      ]);
      log.d('plant&itemMasterRepository,Load_Success!');
      return MasterDataState(
        plants: plantRepo.getAll(),
        items: itemRepo.getAll(),
        loading: false,
      );
    } catch (e) {
      return MasterDataState(
        plants: [],
        items: [],
        loading: false,
        error: e.toString(),
      );
    }
  }

  PlantMasterEntity? findPlant(int id, Variant variant){
    final repoFuture = ref.read(plantMasterRepositoryProvider);
    return repoFuture.when(
      data: (repo) => repo.findByIdAndVariant(id,variant),
      loading: () => null,
      error: (_, __) => null,
    );
  }

  ItemMasterEntity? findItemById(int id) {
    final repoFuture = ref.read(itemMasterRepositoryProvider);
    return repoFuture.when(
      data: (repo) => repo.findById(id),
      loading: () => null,
      error: (_, __) => null,
    );
  }

  /// 🔄 マスターを再読み込みしたい時 (デバッグ/アップデート)
  Future<void> reload({String localeCode = 'ja'}) async {
    final plantRepo = await ref.read(plantMasterRepositoryProvider.future);
    final itemRepo  = await ref.read(itemMasterRepositoryProvider.future);

    await plantRepo.reloadFromJson(localeCode: localeCode);
    await itemRepo.reloadFromJson(localeCode: localeCode);

    state = AsyncData(await _load(localeCode: localeCode));
  }
}