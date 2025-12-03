
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/entity/inventory_entity.dart';
import 'package:myplantapp_ver1/data/entity/item_master_entity.dart';
import 'package:myplantapp_ver1/data/entity/user_entity.dart';
import 'package:myplantapp_ver1/domain/model/inventory.dart';
import 'package:myplantapp_ver1/domain/model/user.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/button.dart';

class StoreItemCard extends StatelessWidget {
  final Inventory? ownedItem;
  final ItemMasterEntity sellItem;
  final User user;
  final VoidCallback onBuyPressed;

  const StoreItemCard({
    this.ownedItem,
    required this.sellItem,
    required this.user,
    required this.onBuyPressed,
  });

  @override
  Widget build(BuildContext context) {

    final l = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // 🌿 柔らかい下方向の影
          BoxShadow(
            color: Colors.brown.withOpacity(0.25),
            offset: const Offset(0, 6),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          // 背景画像＋ブレンド（柄を浮かび上がらせる）
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/ui/card/card_bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              color: Colors.brown.withOpacity(0.15), // 柄をほんのり強調
              colorBlendMode: BlendMode.multiply,
            ),
          ),

          // 半透明の和紙オーバーレイ
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.45),
              border: Border.all(
                color: Colors.brown.withOpacity(0.15),
                width: 0.6,
              ),
            ),
          ),

          // コンテンツ（中身）
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // 画像
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12, width: 0.3),
                  ),
                  child: Padding(
                  padding: (sellItem.itemType == ItemType.decoration)
                      ? const EdgeInsets.only(top: 14)
                      : const EdgeInsets.only(top: 0) ,
                  child: sellItem.imageRes != null
                      ? Image.asset(sellItem.imageRes!, fit: BoxFit.contain)
                      : const Icon(Icons.local_florist, size: 32, color: Colors.grey),
                  )
                ),
                const SizedBox(width: 12),

                // テキスト部分
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sellItem.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AutoSizeText(
                        sellItem.description,
                        maxLines: 2,
                        minFontSize: 10,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/coin.webp", // アイコン画像パス
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${sellItem.price}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 購入ボタン
                GlossyBuyButton(
                  text: l.buy,
                  topColor: Color(0xFFFF7A7A),
                  buttomColor: Color(0xFFD50000),
                  onPressed: onBuyPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}