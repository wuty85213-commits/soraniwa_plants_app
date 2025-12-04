import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';

class SellDialog extends StatelessWidget {
  final User user;
  final List<Inventory>? ownedItems;
  final List<ItemMasterEntity> itemMasterList;

  const SellDialog({
    super.key,
    required this.user,
    this.ownedItems,
    required this.itemMasterList,
  });


  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/common/dialog_cream2.png"),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 6),
                blurRadius: 10
            )
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24,32,24,32),
          width: MediaQuery.of(context).size.width - 20,
        height: 470,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.farm_text3,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: (ownedItems == null || ownedItems!.isEmpty)
                ? Center(child: Text(
                l.store_text6,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )
              )
                  : ListView.builder(
                itemCount: ownedItems!.length,
                itemBuilder: (context, index) {
                  final owned = ownedItems![index];
                  final item = itemMasterList.firstWhere((p) => p.id == owned.itemId);
                  if (owned.quantity <= 0) return const SizedBox();

                  int quantity = 1;

                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/images/common/card_paper.png"),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${l.store_owned}: ${owned.quantity}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: quantity > 1
                                            ? () => setState(() => quantity--)
                                            : null,
                                      ),
                                      Text("$quantity", style: const TextStyle(fontSize: 16)),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: quantity < owned.quantity
                                            ? () => setState(() => quantity++)
                                            : null,
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      SoundManager.playClick();
                                      Navigator.pop(context, (owned, item, quantity));},
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/common/bt_red.png',
                                          width: 100,
                                          fit: BoxFit.fill,
                                        ),
                                        // 🔥 Textの幅をボタン幅に合わせる
                                        SizedBox(
                                          width: 80,
                                          child: Text(
                                            '${item.sellPrice * quantity} ${l.coins}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: CancelButton(onTap: () => Navigator.of(context).pop())
            )
          ],
        ),
      ),
    );
  }
}