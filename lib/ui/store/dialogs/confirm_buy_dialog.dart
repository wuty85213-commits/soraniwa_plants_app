import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/data/entity/inventory_entity.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/user_entity.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/common/widget/red_button.dart';
import 'package:myplantapp_ver1/ui/store/dialogs/success_buy_dialog.dart';

class ConfirmBuyDialog extends StatelessWidget {
  final ItemMasterEntity sellItem;
  final int selectedQty;

  const ConfirmBuyDialog({
    super.key,
    required this.sellItem,
    required this.selectedQty,
  });

  @override
  Widget build(BuildContext context) {

    final l = AppLocalizations.of(context)!;
    return Dialog(

      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 120),
      child: Column(

        mainAxisSize: MainAxisSize.min,
        children: [
        // 🟢 上部タイトル部（固定画像）
        Container(
          height: 60,
            width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ui/dialog/dialog_header.png'),
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
          child: Text(
            l.confirm,
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
          // 🟤 ボディ部（伸縮対応 + centerSlice）
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/ui/dialog/dialog_body.png'),
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
                Text(
                  l.store_text2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4B4B2F),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(sellItem.imageRes ?? 'assets/icons/coin.png',
                        width: 30, height: 30),
                    const SizedBox(width: 10),
                    Text( "${sellItem.name}   × ${selectedQty}",
                        style: const TextStyle(
                          fontSize: 15, color: Color(0xFF4B3E2B), fontWeight: FontWeight.w500,)),
                  ],
                ),

                const SizedBox(height: 8),
                // 🔹 ボーダー線
                const Divider(
                  color: Colors.brown,     // 線の色
                  thickness: 1.5,          // 線の太さ
                  indent: 0,               // 左側の余白
                  endIndent: 0,            // 右側の余白
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/coin.png',
                        width: 30, height: 30),
                    const SizedBox(width: 10),
                    Text( "${sellItem.price * selectedQty} （${l.coinsConsumed}）",
                        style: const TextStyle(
                          fontSize: 15, color: Color(0xFF4B3E2B), fontWeight: FontWeight.w500,)),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CancelButton(onTap:  () => Navigator.pop(context, false)),
                    const SizedBox(width: 20),
                    RedButton(
                        label: l.ok,
                        onTap: () => Navigator.pop(context, true),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]
      )
    );
    /*
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 120),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/dialog_bg_confirm.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(32, 80, 32, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "この内容で購入してもよいですか？",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B4B2F),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // ---- 種 ----
            /*const Text("購入アイテム",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 15),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 30),
                  Image.asset(sellItem.imageRes ?? 'assets/icons/coin.png',
                      width: 30, height: 30),
                  const SizedBox(width: 10),
                  Text( "${sellItem.name}   × ${quantity}",
                      style: const TextStyle(
                        fontSize: 15, color: Color(0xFF4B3E2B), fontWeight: FontWeight.w500,)),
                ],
              ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/button_bg.png',
                        width: 120,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () async{
                    Navigator.pop(context);
                    if(context.mounted){
                      await Future.microtask(() => onConfirm(sellItem, quantity));
                      await showDialog(
                          context: context,
                          builder: (_) => SuccessSampleDialog(
                            title:  "通知",
                            message: "${sellItem.name}を${quantity}個購入しました。",
                          )
                      );
                    }

                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/button_bg_red.png',
                        width: 120,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

     */
  }
}