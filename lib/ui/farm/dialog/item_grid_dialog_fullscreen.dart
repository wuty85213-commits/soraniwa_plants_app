import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/inventory_notifier.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';

class ItemGridDialogFullScreen extends ConsumerWidget {
  const ItemGridDialogFullScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final inventoryAsync = ref.watch(inventoryNotifierProvider);
    final masterNf = ref.read(masterDataNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3), // ← 背景半透明
      body: Center(
        child: inventoryAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('Inventoryデータ読込エラー: $e'),
          data: (inventorys) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/ui/dialog/item_dialog_v1.png"),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              height: double.infinity, // ★フルスクリーン
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    l.farm_itemlist,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(4),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1,
                      ),
                      itemCount: inventorys.length,
                      itemBuilder: (context, index) {
                        final inv = inventorys[index];
                        final master = masterNf.findItemById(inv.itemId);

                        return InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Image.asset(
                                    master?.imageRes ?? "assets/images/pot/pot.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                Positioned(
                                  right: 3,
                                  bottom: 3,
                                  child: Text(
                                    "x${inv.quantity}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      shadows: [
                                        Shadow(offset: Offset(-1, -1), color: Colors.white),
                                        Shadow(offset: Offset(1, -1),  color: Colors.white),
                                        Shadow(offset: Offset(-1, 1),  color: Colors.white),
                                        Shadow(offset: Offset(1, 1),   color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )

                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),
                  CancelButton(
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}