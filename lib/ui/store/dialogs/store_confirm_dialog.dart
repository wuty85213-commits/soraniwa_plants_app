import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/common/widget/dialog_header.dart';
import 'package:myplantapp_ver1/ui/common/widget/red_button.dart';

class StoreConfirmDialog extends StatelessWidget {
  final ItemMasterEntity item;
  final int quantity;
  final int price;
  final String text;

  const StoreConfirmDialog({
    super.key,
    required this.item,
    required this.quantity,
    required this.price,
    required this.text,
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
              DialogHeader(label: l.confirm),
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
                      l.store_text4,
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
                        Image.asset(item.imageRes,
                            width: 30, height: 30),
                        const SizedBox(width: 10),
                        Text( "${item.name}   × ${quantity}",
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
                        Image.asset('assets/icons/coin.webp',
                            width: 30, height: 30),
                        const SizedBox(width: 10),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              text,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF4B3E2B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // キャンセルボタン
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CancelButton(
                            onTap: () => Navigator.pop(context,false)
                        ),
                        const SizedBox(width: 20),
                        RedButton(
                            label: l.ok,
                            onTap: () =>
                                Navigator.of(context, rootNavigator: true).pop(true)
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]
        )
    );
  }
}