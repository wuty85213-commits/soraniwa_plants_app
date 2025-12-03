import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/ad/ad.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/dialog/reward_dialog.dart';
import 'package:myplantapp_ver1/ui/common/dialog/simple_inform_dialog.dart';
import 'package:myplantapp_ver1/ui/common/inventory_notifier.dart';
import 'package:myplantapp_ver1/ui/common/user_notifier.dart';
import 'package:myplantapp_ver1/ui/store/dialogs/buy_quantity_dialog.dart';
import 'package:myplantapp_ver1/ui/store/dialogs/confirm_buy_dialog.dart';
import 'package:myplantapp_ver1/ui/store/dialogs/confirm_sell_dialog.dart';
import 'package:myplantapp_ver1/ui/store/dialogs/sell_dialog.dart';
import 'package:myplantapp_ver1/ui/store/dialogs/success_buy_dialog.dart';
import 'package:myplantapp_ver1/ui/store/dialogs/success_sell_dialog.dart';
import 'package:myplantapp_ver1/ui/store/store_notifier.dart';
import 'package:myplantapp_ver1/usecase/async_combine.dart';
import 'package:myplantapp_ver1/ui/store/widget/store_Itemcard.dart';

// 🌿 ストア画面
class StoreScreen extends ConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final log = AppLogger.tag("StoreScreen");
    final userAsync = ref.watch(userNotifierProvider);
    final storeAsync = ref.watch(storeNotifierProvider);
    final inventoryAsync = ref.watch(inventoryNotifierProvider);
    final combined = combineAsyncValues3(userAsync, storeAsync, inventoryAsync);

    final notifier = ref.read(storeNotifierProvider.notifier);
    return combined.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Data reading error: $e')),
      data: (tuple){
        final userState = tuple.$1;
        final store = tuple.$2;
        final ownedItems = tuple.$3;
        final user = userState.user;
        final displayableItems = store.displayableItems;
        return
          Scaffold(
            backgroundColor: const Color(0xFFF5F8F4),
            body: SafeArea(
              child:Stack(
                children: [
                  Positioned.fill(
                      child: Image.asset(
                        "assets/images/ui/bg/bg_store.png",
                        fit: BoxFit.cover,
                      )
                  ),
                  Column(
                    children: [
                      // 🌿 トップバー
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: const BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/ui/appbar/appbar_vine.png'),
                            fit: BoxFit.cover, // ← 画像を全体にフィットさせる
                          ),
                          //color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text(
                              l.store,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.amber[100],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/coin.webp", // アイコン画像パス
                                    width: 22,
                                    height: 22,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${user?.coins ?? 0}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 🌸 スクロール可能リスト
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                          itemCount: displayableItems.length,
                          itemBuilder: (context, index) {
                            final item = displayableItems[index];
                            final ownedItem = ownedItems.firstWhereOrNull((p) => p.itemId == item.id);
                            return StoreItemCard(
                                ownedItem: ownedItem,
                                sellItem: item,
                                user: user,
                                onBuyPressed:() async{
                                  final maxQty = (item.itemType != ItemType.decoration)
                                      ? (user.coins/item.price).floor()
                                      : 1;
                                  final selectedQty = await showDialog<int>(
                                      context: context,
                                      builder: (_) => BuyQuantityDialog(
                                        maxQuantity: maxQty,
                                      )
                                  );

                                  if(selectedQty == null || selectedQty <= 0) {
                                    return;
                                  }

                                  // 確認ダイアログ
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (_) => ConfirmBuyDialog(
                                      sellItem: item,
                                      selectedQty: selectedQty,
                                    ),
                                  );

                                  if (confirmed != true) return;

                                  // ✅ 購入処理はここで！
                                  final success = await notifier.buyItem(itemId: item.id, quantity: selectedQty);

                                  if (success) {
                                    await showDialog(
                                      context: context,
                                      builder: (_) => SuccessBuyDialog(
                                        user: user,
                                        ownedItem: ownedItem,
                                        sellItem: item,
                                        quantity: selectedQty,
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            SimpleInfoDialog(title: l.error,message: l.text1,)
                                    );
                                  }
                                }
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: GestureDetector(
                      onTap: () async {
                        final nf = await ref.read(storeNotifierProvider.notifier);
                        // Reward Ad 開始
                        if (!await canWatchAd()) {
                          showDialog(
                              context: context,
                              builder: (_) => SimpleInfoDialog(
                                  title: l.message,
                                  message: l.store_text7)
                          );
                          return;
                        }
                        await showRewardAd(() async {
                          // アイテム付与など
                          await increaseCount();
                          final itemId = await nf.adReward();
                          showDialog(
                            context: context,
                            builder: (_) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                SoundManager.playHarvest();
                              });
                              return RewardDialog(
                                  title: l.store_adReward,
                                  subTitle: l.reward,
                                  items: [(itemId,1)]
                              );
                            }
                          );
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/ui/button/ad.png'),
                            fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.withOpacity(0.3),
                              offset: const Offset(0, 4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              l.store_ad,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                            Image.asset(
                              "assets/icons/item.webp", // アイコン画像パス
                              width: 24,
                              height: 24,
                            ),
                          ]
                        )
                      ),
                    ),
                  ),
                ],
              )
            ),
            floatingActionButton: GestureDetector(
              onTap: () async {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  SoundManager.playClick();
                });
                final ownedItems2 = ownedItems.where((n) => n.itemType != ItemType.decoration).toList();
                final result = await showDialog<(Inventory,ItemMasterEntity,int)>(
                  context: context,
                  builder: (_) => SellDialog(
                    user: user,
                    ownedItems: ownedItems2,
                    itemMasterList: store.itemsMasters,
                  ),
                );
                if(result == null) return;
                final (ownedItem, owendItemMs,selectedQty) = result;

                // 確認ダイアログ
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (_) => ConfirmSellDialog(
                    soldItem: owendItemMs,
                    quantity: selectedQty,
                  ),
                );

                if (confirmed != true) return;

                final success = await notifier.sellItem(itemId: owendItemMs.id,quantity: selectedQty);
                debugPrint('アイテムの売却${success}！');

                if (success) {
                  debugPrint("🎁売却: ${ownedItem.itemId}, $selectedQty 個");
                  await showDialog(
                    context: context,
                    builder: (_) => SuccessSellDialog(
                      user: user,
                      item: ownedItem,
                      soldItem: owendItemMs,
                      quantity: selectedQty,
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/ui/button/skyblue.png'),
                    fit: BoxFit.fill, // ← 画像を全体にフィットさせる
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.3),
                      offset: const Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l.sell,
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

// --------------------------------------------------------------------
// 商品データ
// --------------------------------------------------------------------
class ItemData {
  final String name;
  final String description;
  final int price;
  final String? imagePath;

  ItemData(this.name, this.description, this.price, this.imagePath);
}