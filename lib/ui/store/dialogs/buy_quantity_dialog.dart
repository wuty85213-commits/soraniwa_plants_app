import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/common/widget/red_button.dart';

class BuyQuantityDialog extends StatefulWidget {
  final int maxQuantity;

  const BuyQuantityDialog({
    super.key,
    required this.maxQuantity,
  });

  @override
  State<BuyQuantityDialog> createState() => _BuyQuantityDialogState();
}

class _BuyQuantityDialogState extends State<BuyQuantityDialog> {
  int quantity = 1;

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
            child: Text(l.confirm,
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
            ),
          ),

          // 🟤 ボディ部（伸縮対応 + centerSlice）
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
                Text(
                  l.store_text1,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4B4B2F),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // 数量調整ボタン
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon:
                      const Icon(Icons.remove),
                      onPressed: quantity > 1
                          ? () => setState(
                              () => quantity--)
                          : null,
                    ),

                    Text(
                      "$quantity",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        if (quantity < widget.maxQuantity) {
                          setState(() => quantity++);
                        } else {
                          //todo:効果音やバイブを鳴らす処理
                        }
                      },
                    ),
                  ],
                ),

                // キャンセルボタン
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CancelButton(onTap: () => Navigator.pop(context)),
                    const SizedBox(width: 20),
                    RedButton(label: l.ok, onTap: () => Navigator.pop(context,quantity)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}