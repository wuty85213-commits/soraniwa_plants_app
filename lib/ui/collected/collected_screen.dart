import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/collected/collected_notifier.dart';
import 'package:myplantapp_ver1/ui/collected/dialog/collected_detail_dialog.dart';
import 'package:myplantapp_ver1/ui/common/widget/banner_ad_widget.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';

// ==== 図鑑画面 ====
class CollectedScreen extends ConsumerWidget {
  const CollectedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final masterAsync = ref.watch(masterDataNotifierProvider);
    final collectedAsync = ref.watch(collectedNotifierProvider);
    final collectedVM = ref.read(collectedNotifierProvider.notifier);


      return Scaffold(
          backgroundColor: const Color(0xFFF5F8F4),
          body: SafeArea(
            child: masterAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('マスター読み込みエラー: $e')),
              data: (master) {
                final allPlants = master.plants;
                final mastarCount = allPlants.map((p) => p.id).toSet().length;
                final normalPlants = allPlants.where((p) => p.variant == Variant.NORMAL).toList();
                final sortedPlants = [...normalPlants] // コピーを作って元リストを壊さない
                  ..sort((a, b) => a.id.compareTo(b.id));
                return Stack(
                  children: [
                    Positioned.fill(
                        child: Image.asset(
                          'assets/bg/bg_sunlawn.png',
                          fit: BoxFit.cover,
                        )
                    ),
                    Column(
                      children: [
                        // 🌿 トップバー（Storeと統一）
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/common/appbar_vine.png'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // 🔹 タイトル（中央固定）
                              Text(
                                l.collection,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),

                              // 🔹 左上に戻るボタン
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/collected/frame_rich.png'),
                                  fit: BoxFit.fill,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 2),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),

                              child:Column(
                                children: [
                                  Text(
                                    l.collected_collectedRate,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 20,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 60,
                                              child: Image.asset(
                                                "assets/images/collected/ex_normal.webp",
                                              ),
                                            ),
                                            Text(
                                              "${collectedVM.normalRate}％",
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "(${collectedVM.normalCount}/${mastarCount})",
                                              style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 60,
                                              child: Image.asset(
                                                "assets/images/collected/ex_gold.webp",
                                              ),
                                            ),
                                            Text(
                                              "${collectedVM.goldRate}％",
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "(${collectedVM.goldCount}/${mastarCount})",
                                              style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 60,
                                              child: Image.asset(
                                                "assets/images/collected/ex_rainbow.webp",
                                              ),
                                            ),
                                            Text(
                                              "${collectedVM.rainbowRate}％",
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "(${collectedVM.rainbowCount}/${mastarCount})",
                                              style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ),

                        // 🌸 グリッド表示（図鑑リスト）
                        Expanded(
                          child: collectedAsync.when(
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (e, _) => Center(child: Text('Data reading error: $e')),
                                data: (collectedList) {
                                return GridView.builder(
                                  padding: const EdgeInsets.fromLTRB(10,10,10,56),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
                                  itemCount: sortedPlants.length,
                                  itemBuilder: (context, index) {
                                    final plant = sortedPlants[index];
                                    final isCollectedFlag = collectedVM.isCollected(plant.id);
                                    final sameVariants = allPlants.where((p) => p.id == plant.id).toList();
                                    final collectedById = collectedList.where((c) => c.plantId == plant.id).toList();

                                    return GestureDetector(
                                      onTap: () {
                                        if(!isCollectedFlag)return;

                                        showDialog(
                                          context: context,
                                          builder: (_) => Center(
                                            child: CollectedDetailDialog(
                                              variants: sameVariants,
                                              collectedList: collectedById,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Opacity(
                                        opacity: 1.0,
                                        child: Container(
                                          margin: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(isCollectedFlag ?'assets/images/collected/card_cream.png' :'assets/images/collected/card_grey.png'), // ← あなたの背景画像
                                              fit: BoxFit.cover, // カード全体に広げる
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                offset: const Offset(0, 4),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                        decoration: BoxDecoration(
                                                            color: isCollectedFlag ?Color(0xFFFFF5C3) :Colors.grey,
                                                            borderRadius: BorderRadius.circular(8),
                                                            border: Border.all(
                                                              color: isCollectedFlag ?Color(0xFFF0C96A) :Colors.grey,
                                                              width: 1,
                                                            )
                                                        ),
                                                        child: Text(
                                                          "No.${plant.id}",
                                                          style: const TextStyle(
                                                            fontSize: 8, fontWeight: FontWeight.bold,
                                                            color: Color(0xFF6B5A36),
                                                            letterSpacing: 0.5,),
                                                        ),
                                                      ),
                                                    ),

                                                    // 👑 王冠アイコン（存在する場合のみ表示）
                                                    Builder(
                                                      builder: (_) {
                                                        final imagePath = collectedVM.getcompleteImage(collectedById);
                                                        if (imagePath.isEmpty) {
                                                          return const SizedBox(width: 22, height: 22); // 何も描画しない
                                                        }
                                                        return Image.asset(imagePath, width: 22, height: 22);
                                                      },
                                                    ),
                                                  ],
                                                ),

                                                Expanded(
                                                  child: Image.asset(isCollectedFlag ?plant.imageRes[3] :"assets/icons/locked_silver.webp",
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),

                                                SizedBox(height: 12)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              )
                          )
                      ],
                    ),
                    /*
                    // 📢 === ここがバナー広告を固定表示する部分 ===
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: BannerAdWidget(),  // ← バナー広告widget
                      ),
                    ),

                     */
                  ]
                );
              }
            )
          ),
        );
  }
}


/*
class CollectedScreen extends StatefulWidget {
  const CollectedScreen({super.key});

  @override
  State<CollectedScreen> createState() => _CollectedScreenState();
}

class _CollectedScreenState extends State<CollectedScreen> {
  List<PlantMasterEntity> _plants = [];
  List<CollectedEntity> _collectedList = []; // 発見済みvariant情報

  @override
  Widget build(BuildContext context) {
    final collectedVM = context.watch<CollectedViewModel>();
    if (collectedVM.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final masters = collectedVM.plantMasters;

    return Scaffold(
      appBar: AppBar(
        title: const Text("図鑑"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: masters.length,
        itemBuilder: (context, index) {
          final plant = masters[index];
          final isCollected = collectedVM.isCollected(plant.id, plant.variant); // 同種の代表（NORMAL）

          return GestureDetector(
            onTap: () {
              final sameVariants = masters
              .where((p) => p.id == plant.id).toList();

              final collectedList = collectedVM.collected
              .where((c) => c.plantId == plant.id).toList();

              showDialog(
                context: context,
                builder: (_) => CollectedDetailDialog(
                  variants: sameVariants,
                  collectedList: collectedList, // 収穫履歴が未実装なら空でOK
                ),
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Image.asset(
                        plant.imageRes,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      plant.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("レア度: ${"★" * plant.rarity}"),
                    const SizedBox(height: 6),
                    const Icon(Icons.zoom_in, color: Colors.grey),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/