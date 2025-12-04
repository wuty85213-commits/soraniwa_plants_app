import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/model/item_amount.dart';
import 'package:myplantapp_ver1/domain/model/user_plant.dart';
import 'package:myplantapp_ver1/ui/achievememt/achievement_notifier.dart';
import 'package:myplantapp_ver1/ui/common/achievement_snackber_listener.dart';
import 'package:myplantapp_ver1/ui/common/inventory_notifier.dart';
import 'package:myplantapp_ver1/ui/common/user_notifier.dart';
import 'package:myplantapp_ver1/ui/common/widget/banner_ad_widget.dart';
import 'package:myplantapp_ver1/ui/farm/dialog/confirm_plant_dialog.dart';
import 'package:myplantapp_ver1/ui/farm/dialog/fertilozer_select_dialog.dart';
import 'package:myplantapp_ver1/ui/farm/farm_notifier.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/ui/farm/animated/beautiful_nature_field_state.dart';
import 'package:myplantapp_ver1/ui/farm/animated/farm_Animated_plant.dart';
import 'package:myplantapp_ver1/ui/farm/dialog/harveest_result_dialog.dart';
import 'package:myplantapp_ver1/ui/farm/dialog/plant_select_dialog.dart';
import 'package:myplantapp_ver1/ui/farm/dialog/water_action_popup.dart';
import 'package:myplantapp_ver1/ui/farm/farm_tutorial_screen.dart';
import 'package:myplantapp_ver1/ui/farm/widget/locked_slot.dart';
import 'package:myplantapp_ver1/ui/farm/widget/topber.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';
import 'package:myplantapp_ver1/usecase/async_combine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmScreen extends ConsumerStatefulWidget {
  const FarmScreen({super.key});

  @override
  ConsumerState<FarmScreen> createState() => _FarmScreenState();
}

class _FarmScreenState extends ConsumerState<FarmScreen> with WidgetsBindingObserver{
  final log = AppLogger.tag("FarmScreen");
  late List<GlobalKey> slotKeys;
  late List<GlobalKey<AnimatedPlantState>> plantKeys;

  @override
  void initState() {
    super.initState();

    slotKeys = List.generate(6, (_) => GlobalKey());
    plantKeys = List.generate(6, (_) => GlobalKey<AnimatedPlantState>());

    WidgetsBinding.instance.addObserver(this);

    _initBgm();
    _checkTutorial();
  }

  /// 🎵 BGM初期化とループ設定
  Future<void> _initBgm() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SoundManager.playBgm(); // 🔁 BGMをループ再生
    });
  }

  @override
  void dispose() {
    log.d('farm screen dispose!');
    SoundManager.stopBgm(); // ✅ メモリリーク防止
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// 🌙 アプリライフサイクル(閉じた/戻ったなど)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!mounted) return;

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // 🔻 アプリ閉じた・他アプリへ → BGM停止
      SoundManager.stopBgm();
      log.d('アプリ閉じたため、StopBGM!');
    }
    else if (state == AppLifecycleState.resumed) {
      // 🔺 アプリに戻ったが、Farm画面にいる場合のみ再生
      SoundManager.playBgm();
    }
  }

  Future<void> _checkTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool("tutorial_farm_done") ?? false;

    if (!done) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FarmTutorialScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext) {
    useAchievementSnackListener(ref, context);
    final farmAsync = ref.watch(farmNotifierProvider);
    final userAsync = ref.watch(userNotifierProvider);
    final inventoryAsync = ref.watch(inventoryNotifierProvider);
    final masterAsync = ref.watch(masterDataNotifierProvider);
    final combined = combineAsyncValues4(farmAsync, userAsync, inventoryAsync, masterAsync);
    final notifier = ref.read(farmNotifierProvider.notifier);
    final masterNf = ref.read(masterDataNotifierProvider.notifier);
    final ivNf = ref.read(inventoryNotifierProvider.notifier);


    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),
      body: SafeArea(
        child: combined.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('data reading error: $e')),
          data: (tuple) {
            log.d('farmScreen build');
            final farm = tuple.$1;
            final userState = tuple.$2;
            final inventory = tuple.$3;
            final masterData = tuple.$4;

            final userPlants = farm.userPlants;
            final plantMasters = masterData.plants;
            final itemMasters = masterData.items;

            final user = userState.user;
            final pots = userState.pots;

            final seedItems = inventory.where((p) => p.itemType == ItemType.seed).toList();
            final fertilizerItems = inventory.where(
                    (p) => p.itemType == ItemType.growthBoost
                    || p.itemType == ItemType.rarerateboostRow
                    || p.itemType == ItemType.rarerateboostHigh
                    || p.itemType == ItemType.rarerateboostSuper
            ).toList();

            //デバック用
            final debug = plantMasters.firstWhereOrNull((p) => p.id == 13 && p.variant == Variant.NORMAL);
            log.d('id_13 : ${debug?.id ?? 'null'},${debug?.attribute ?? 'null'},${user.unlockedSlots} ');

            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/bg/bg_farm.png',
                    fit: BoxFit.cover,
                  )
                ),
                const BeautifulNatureField(),
                Column(
                  children: [
                    buildTopBar(context),
                    // 🌸 スクロール可能リスト
                    Expanded(
                      child: Center(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap:true,
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            childAspectRatio: 1,
                          ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            final slotkey = slotKeys[index];
                            final plantKey = plantKeys[index];
                            final pot = pots.firstWhereOrNull((e) => e.slotIndex == index);
                            final potMs = masterNf.findItemById(pot?.itemId ?? 500);
                            final potPath = potMs?.imageRes ?? 'assets/images/items/pot.webp';
                            if (index >= user.unlockedSlots) {
                              return LockedSlot();
                            }

                            final plant = userPlants.firstWhereOrNull(
                                    (p) => p.slotIndex == index
                            );
                            if (plant == null) {
                              log.e('🪴 Slot[$index]: ❌ plant = null （userPlantsに一致するスロットがありません）');
                            }
                            final plantMS = plantMasters
                                .firstWhereOrNull(
                                    (m) => m.id == plant?.plantId && m.variant == plant?.variant);
                            //log.d("Slot[$index] プラントマスターデータ[${plantMS?.name ?? 'null'}${plantMS?.variant ?? 'null'}] ");

                            return InkWell(
                              key: slotkey,
                              borderRadius: BorderRadius.circular(12),
                              onTap: () async{
                                if (plant == null) {
                                  final seed = await showDialog<Inventory>(
                                    context: context,
                                    builder: (_) =>
                                      PlantSelectDialog(
                                        slotIndex: index,
                                        seedList: seedItems,
                                        fertilizerData: fertilizerItems,
                                        itemMasterList: itemMasters,
                                      )
                                  );
                                  if(seed == null) return;

                                  Inventory? solid;
                                  Inventory? liquid;
                                  Inventory? lucky;

                                  if(fertilizerItems.isNotEmpty){
                                    final result = await showDialog(
                                      context: context,
                                      builder: (_) => FertilizerSelectDialog(
                                        slotIndex: index,
                                        seed: seed,
                                        fertilizerData: fertilizerItems,
                                      ),
                                    );

                                    if(result == null) return;
                                    (solid, liquid, lucky) = result;
                                  }

                                  final selected = [solid, liquid, lucky].whereType<Inventory>().toList();

                                  final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (_) => ConfirmPlantDialog(
                                        slotIndex: index,
                                        seed: seed,
                                        solid: solid,
                                        liquid: liquid,
                                        lucky: lucky,
                                        itemMasterList: itemMasters,
                                      )
                                  );

                                  if(confirm != true) return;

                                  final amounts = [seed, solid, liquid, lucky,]
                                      .whereType<Inventory>()                   // null を除外
                                      .map((item) => ItemAmount(item.itemId, 1)) // 数量1でセット
                                      .toList();

                                  await ivNf.reduceItems(amounts);
                                  log.d('reduceItems 呼び出し：${amounts.length}アイテム削除');

                                  //await ivNf.reduceItem(seed.itemId, 1);
                                  //log.d('reduceItem ${seed.itemId}:1');
                                  await notifier.plantSeed(
                                      slotIndex: index,
                                      seedItem: seed,
                                      buffItems: selected
                                  );

                                  log.d('プラントを植え付けました');

                                } else {
                                  log.d('プラントがタップされました！');
                                  _showPlantPopup(
                                      context, slotkey, plantKey,
                                      plant,index);
                                }
                              },
                              child: AnimatedContainer(
                                  duration: const Duration(
                                      milliseconds: 250),
                                  child: _buildSlotContent(
                                      plant, plantMS, index, plantKey, potPath)
                              ),
                            );
                          },
                        ),
                      )
                    ),
                  ],
                ),
                // 📢 === ここがバナー広告を固定表示する部分 ===
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: BannerAdWidget(),  // ← バナー広告widget
                  ),
                ),
              ],
            );
          },
        )
      ),
    );
  }
  Widget _buildSlotContent(
      UserPlant? plant,
      PlantMasterEntity? master,
      int index,
      GlobalKey<AnimatedPlantState> plantKey,
      String imagePath
      ) {


    if (plant==null) {
      return _buildEmptySlot(index, imagePath);
    } else if (master == null){
      return const Center(child: Text("不明な植物"));
    } else{
      return _buildPlantSlot(plantKey, index);
    }
  }

  Widget _buildLockedSlot() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black26),
      ),
      child: const Center(child: Text("🔒 未開放")),
    );
  }

  Widget _buildEmptySlot(int index, String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 🌿 植物部分（上7/10）
        Expanded(
          flex: 7,
          child: SizedBox(),
        ),

        // 🪴 鉢部分（下3/10）
        Expanded(
          flex: 3,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            alignment: Alignment.topCenter, // 上端を基準に表示（接地ライン）
          ),
        ),
      ],
    );
  }

  Widget _buildPlantSlot(GlobalKey<AnimatedPlantState> plantKey, int index) {
    final userAsync = ref.watch(userNotifierProvider);
    return userAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Farmデータ読込エラー: $e')),
      data: (userState){
        final pot = userState.pots.firstWhereOrNull((e) => e.slotIndex == index);
        final masterNf = ref.read(masterDataNotifierProvider.notifier);
        final potMaster = masterNf.findItemById(pot?.itemId ?? 500);
        return LayoutBuilder(
          builder: (context, constraints) {
            //log.d('Grid slot constraints: ${constraints.maxWidth} x ${constraints.maxHeight}');
            //log.d('Slot[$index] InkWell constraints: ${constraints}');

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 🌿 植物部分（上7/10）
                Expanded(
                  flex: 7,
                  child: AnimatedPlant(
                    key: plantKey,
                    slotIndex: index,
                    onAnimationEnd: () {
                      setState(() {});
                    },
                  ),
                ),

                // 🪴 鉢部分（下3/10）
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    potMaster?.imageRes ?? 'assets/images/items/pot.webp',
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter, // 上端を基準に表示（接地ライン）
                  ),
                ),
              ],
            );
          },
        );
      }
    );
  }

  // 🌱 植物の上にポップアップを表示
  void _showPlantPopup(
      BuildContext context,
      GlobalKey slotkey,
      GlobalKey<AnimatedPlantState> plantKey,
      UserPlant plant, int slotIndex) {

    final renderBox = slotkey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (_) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.transparent),
            ),
            WaterActionPopup(
              position: offset,
              growthStage: plant.stage,
              plantCondition: plant.plantCondition,
              onWater: () async{
                final notifier = ref.read(farmNotifierProvider.notifier);
                Navigator.pop(context);
                // 🌊 まずアニメーションを実行
                final state = plantKey.currentState;
                if (state != null && state.mounted) {
                  await state.playWaterAnimation(); // アニメーションが終わるまで待機
                }
                await notifier.waterPlant(plant.id);
              },
              onRemove: () async{
                final notifier = ref.read(farmNotifierProvider.notifier);
                Navigator.pop(context);
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  final state = plantKey.currentState;
                  if (state != null && mounted) {
                    await state.playRemoveAnimation(); // ← ここで確実に待機
                    await notifier.removePlant(plant.id,slotIndex);
                  } else {
                    // fallback: ウィジェットが消えてた場合も削除処理を走らせる
                    await notifier.removePlant(plant.id,slotIndex);
                  }
                });
              },
              onHarvest: () async {
                log.d('onHarvest start');
                final rootContext = context;

                final notifier = ref.read(farmNotifierProvider.notifier);
                final achieveNotifier = ref.read(achievementNotifierProvider.notifier);

                Navigator.pop(context);
                await Future.delayed(const Duration(milliseconds: 50));
                final state = plantKey.currentState;
                log.d('${state}');
                if (state != null && state.mounted) {
                  log.d('animation start');
                  await state.playHarvestAnimation(); // アニメーションが終わるまで待機
                }

                final result = await notifier.harvestPlant(plant.id);
                if(result != null) {
                  log.d('Let show dialog!');
                  showDialog(
                      context: rootContext,
                      builder: (_) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          SoundManager.playHarvest();
                        });
                        return HarvestResultDialog(result: result);
                      }
                  );
                  achieveNotifier.checkAchievements();
                } else {
                  log.d('収穫処理にエラーが発生しました！');
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

