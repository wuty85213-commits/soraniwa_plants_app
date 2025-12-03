import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/entity/inventory_entity.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/common/widget/red_button.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';

class FertilizerSelectDialog extends ConsumerStatefulWidget {
  //final List<InventoryEntity> fertilizerList;　肥料所持リスト
  final int slotIndex;
  final dynamic seed;
  final List<Inventory> fertilizerData;

  const FertilizerSelectDialog({
    super.key,
    required this.slotIndex,
    required this.seed,
    required this.fertilizerData,
  });

  @override
  FertilizerSelectDialogState createState() => FertilizerSelectDialogState();
}
class FertilizerSelectDialogState extends ConsumerState<FertilizerSelectDialog> {
  Inventory? solidFertilizer;
  Inventory? liquidFertilizer;
  Inventory? luckyFertilizer;

  //final List<String> solidOptions = ["なし", "小型固形肥料", "高品質固形肥料"];
  //final List<String> liquidOptions = ["なし", "通常液体肥料", "特濃液体肥料"];
  //final List<String> luckyOptions = ["なし", "幸運の肥料", "超幸運の肥料"];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    // 各タイプごとに抽出
    final solidOptions = widget.fertilizerData
        .where((f) => f.itemType == ItemType.growthBoost)
        .toList();
    final liquidOptions = widget.fertilizerData
        .where((f) => f.itemType == ItemType.rarerateboostRow ||
        f.itemType == ItemType.rarerateboostHigh)
        .toList();
    final luckyOptions = widget.fertilizerData
        .where((f) => f.itemType == ItemType.rarerateboostSuper)
        .toList();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30,vertical: 80),
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

        child: Padding(
          padding: const EdgeInsets.fromLTRB(24,32,24,32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.farm_text3,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4B4B2F),
                ),
              ),
              const SizedBox(height: 16),

              //if(solidList.isNotEmpty)todo:レンダリングエラー対策で改行可能にする
              //固形肥料
              if(solidOptions.isNotEmpty)...[
                Row(
                  children: [
                    Image.asset('assets/icons/coin.png', width: 22, height: 22),
                    const SizedBox(width: 6),
                    Text(l.enum_ItemTypeGB, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                DropdownButtonFormField<Inventory>(
                  value: solidFertilizer,
                  hint: const Text(
                    "なし",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  decoration: _dropdownDecoration(),
                  dropdownColor: const Color(0xFFFFFBEA), // 展開時のリスト背景
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF6B5A36)),
                  items: solidOptions
                      .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item.itemType.l10n(context)),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() => solidFertilizer = value),
                ),

                const SizedBox(height: 12),
              ],

              if(liquidOptions.isNotEmpty)...[
                // 液体肥料
                Row(
                  children: [
                    Image.asset('assets/icons/coin.png', width: 22, height: 22),
                    const SizedBox(width: 6),
                    Text(l.enum_ItemTypeRBRow, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                DropdownButtonFormField<Inventory>(
                  value: liquidFertilizer,
                  hint: const Text(
                    "なし",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  decoration: _dropdownDecoration(),
                  dropdownColor: const Color(0xFFFFFBEA), // 展開時のリスト背景
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF6B5A36)),
                  items: liquidOptions
                      .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item.itemType.l10n(context)),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() => liquidFertilizer = value),
                ),
                const SizedBox(height: 12),
              ],

              if(luckyOptions.isNotEmpty)...[
                // 幸運の肥料
                Row(
                  children: [
                    Image.asset('assets/icons/coin.png', width: 22, height: 22),
                    const SizedBox(width: 6),
                    Text(l.enum_ItemTypeRBSuper, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                DropdownButtonFormField<Inventory>(
                  value: luckyFertilizer,
                  hint: Text(
                    l.none,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  decoration: _dropdownDecoration(),
                  dropdownColor: const Color(0xFFFFFBEA), // 展開時のリスト背景
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF6B5A36)),
                  items: luckyOptions
                      .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item.itemType.l10n(context))
                  ))
                      .toList(),
                  onChanged: (value) => setState(() => luckyFertilizer = value),
                ),
                const SizedBox(height: 24),
              ],

              // キャンセルボタン
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CancelButton(onTap: () => Navigator.pop(context)),
                  const SizedBox(width: 20),
                  RedButton(
                      label: l.ok,
                      onTap: () {
                        Navigator.pop(context,(solidFertilizer, liquidFertilizer, luckyFertilizer));
                        //Future.microtask(() {
                        //  widget.onNext(solidFertilizer, liquidFertilizer, luckyFertilizer);
                        //});
                      }
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFFFF8E1), // クリーム色背景
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFF0C96A), width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD6A84A), width: 2),
      ),
    );
  }
}