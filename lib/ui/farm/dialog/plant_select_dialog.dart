import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';
import 'package:myplantapp_ver1/data/entity/inventory_entity.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/farm/dialog/confirm_plant_dialog.dart';
import 'package:myplantapp_ver1/ui/farm/dialog/fertilozer_select_dialog.dart';

class PlantSelectDialog extends StatelessWidget {
  final int slotIndex;
  final List<Inventory> seedList;
  final List<Inventory> fertilizerData;
  final List<ItemMasterEntity> itemMasterList;

  const PlantSelectDialog({
    super.key,
    required this.slotIndex,
    required this.seedList,
    required this.fertilizerData,
    required this.itemMasterList,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40,vertical: 80),
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/ui/dialog/item_dialog_v2.png'),
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
        width: double.maxFinite,
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.farm_text3,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: seedList.isEmpty
                  ? Center(child: Text(l.farm_text4))
                  : ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.all(
                    const Color(0xFFBFA97A).withOpacity(0.8), // 優しいブラウン
                  ),
                  trackColor: MaterialStateProperty.all(
                    const Color(0xFFFFF8E1).withOpacity(0.5), // うっすら背景トラック
                  ),
                  trackBorderColor: MaterialStateProperty.all(Colors.transparent),
                  radius: const Radius.circular(12),
                  thickness: MaterialStateProperty.all(6),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  radius: const Radius.circular(12),
                  child: ListView.builder(
                    itemCount: seedList.length,
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    itemBuilder: (context, index) {
                      final seed = seedList[index];
                      final masterseed = itemMasterList.firstWhere((e) => e.id == seed.itemId); //★マスタデータ検索
                      return Card(
                        color: const Color(0xFFFFFCF5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(color: Color(0xFFE7D6A8), width: 1.2),
                        ),
                        elevation: 3,
                        shadowColor: Colors.brown.withOpacity(0.2),
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),

                          //画面遷移
                          onTap: () async {
                            SoundManager.playClick();
                            Navigator.pop(context, seed);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Row(
                              children: [
                                // 🌱 種アイコン
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF8E1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFFE0C97F), width: 1),
                                  ),
                                  child: Image.asset(
                                    masterseed.imageRes,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // 🌾 テキスト情報
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${masterseed.name} ×${seed.quantity}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xFF4B3E2B),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'タイプ: ${seed.variant?.l10n(context) ?? '???'}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF7A6B50),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right, color: Color(0xFFBFA97A)),
                              ],
                            )
                          )
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            Align(
              alignment: Alignment.bottomCenter,
              child:
              CancelButton(onTap: () => Navigator.pop(context)),
            ),
          ]
        ),
      ),
    );
  }
}



