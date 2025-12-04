import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/data/entity/inventory_entity.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/common/widget/red_button.dart';

class ConfirmPlantDialog extends StatelessWidget {
  final int slotIndex;
  final dynamic seed;
  final Inventory? solid;
  final Inventory? liquid;
  final Inventory? lucky;
  final List<ItemMasterEntity> itemMasterList;

  const ConfirmPlantDialog({
    super.key,
    required this.slotIndex,
    required this.seed,
    this.solid,
    this.liquid,
    this.lucky,
    required this.itemMasterList,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final masterSeed = itemMasterList.firstWhere((e) => e.id == seed.itemId);
    final  masterItems = [
    if (solid != null) itemMasterList.firstWhereOrNull((e) => e.id == solid!.itemId),
    if (liquid != null) itemMasterList.firstWhereOrNull((e) => e.id == liquid!.itemId),
    if (lucky != null) itemMasterList.firstWhereOrNull((e) => e.id == lucky!.itemId),
    ].whereType<ItemMasterEntity>().toList();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 120),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/common/dialog_header.png'),
                fit: BoxFit.fill,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25), // 🔹影の色と透明度
                  offset: const Offset(0, 8),             // 🔹影の方向
                  blurRadius: 10,                         // 🔹ぼかし量
                  spreadRadius: 0.5, // 🔹影の広がり
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text('確認',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 3,
                    color: Colors.black26,
                    offset: Offset(1, 2),
                  )
                ],
              ),
            )
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/common/dialog_body.png'),
                fit: BoxFit.fill,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25), // 🔹影の色と透明度
                  offset: const Offset(0, 8),             // 🔹影の方向
                  blurRadius: 10,                         // 🔹ぼかし量
                  spreadRadius: 0.5, // 🔹影の広がり
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: [

                Text(l.farm_plantSeed,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 10),
                if (masterSeed != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 30),
                      Image.asset(masterSeed.imageRes, width: 24, height: 24),
                      const SizedBox(width: 10),
                      Text(masterSeed.name,
                          style: const TextStyle(
                            fontSize: 13, color: Color(0xFF4B3E2B), fontWeight: FontWeight.w500,)),
                    ],
                  ),

                const SizedBox(height: 15),

                // ---- 使用するアイテム ----
                Text(l.farm_userdItem,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 10),

                if (masterItems.isEmpty)
                  Text(l.none, style: TextStyle(color: Color(0xFF7A6B50)))
                else
                  Column(
                    children: masterItems
                        .map((m) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 30),
                          Image.asset(m.imageRes, width: 24, height: 24),
                          const SizedBox(width: 10),
                          Text(m.name,
                            style: const TextStyle(
                              fontSize: 13, color: Color(0xFF4B3E2B), fontWeight: FontWeight.w500,
                            )
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CancelButton(
                        onTap: () => Navigator.pop(context,false)
                    ),
                    const SizedBox(width: 20),
                    RedButton(
                      label: l.ok,
                      onTap: (){
                      Navigator.pop(context,true);
                      }
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}