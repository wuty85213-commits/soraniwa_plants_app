import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/ui/common/inventory_notifier.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';

class ItemGridDialog extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryAsync = ref.watch(inventoryNotifierProvider);
    final masterNf = ref.read(masterDataNotifierProvider.notifier);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      backgroundColor: Colors.transparent,
      child: inventoryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text('Inventoryデータ読込エラー: $e')),
        data: (inventorys) {
          return Container(
            padding:
            const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image:
                AssetImage("assets/images/collected/card_cream.png"),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "アイテム一覧",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // 🔥 アイテムグリッド
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(4),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1,
                    ),
                    itemCount: inventorys.length,
                    itemBuilder: (context, index) {
                      final inv = inventorys[index];
                      final master =
                      masterNf.findItemById(inv.itemId);

                      return InkWell(
                        onTap: () {
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          child: Stack(
                            children: [
                              // アイテム画像
                              Center(
                                child: Image.asset(
                                  master?.imageRes ?? "assets/icons/item.webp",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                ),
                              ),

                              // 右下：数量
                              Positioned(
                                right: 1,
                                bottom: 1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  child: Text(
                                    "x${inv.quantity}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // 文字色
                                      shadows: [
                                        Shadow(offset: Offset(-1, -1), color: Colors.white, blurRadius: 1),
                                        Shadow(offset: Offset(1, -1),  color: Colors.white, blurRadius: 1),
                                        Shadow(offset: Offset(-1, 1),  color: Colors.white, blurRadius: 1),
                                        Shadow(offset: Offset(1, 1),   color: Colors.white, blurRadius: 1),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),
                CancelButton(
                    onTap: () => Navigator.pop(context, false)),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}