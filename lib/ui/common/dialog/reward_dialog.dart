import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/farm/animated/rotatingbackground.dart';
import 'package:myplantapp_ver1/ui/farm/animated/sparkle_field.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';

class RewardDialog extends ConsumerWidget {
  final String title;
  final String? subTitle;
  final int? coins;
  final List<(int, int)> items;

  const RewardDialog({
    super.key, required this.title, this.subTitle, this.coins, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final ms = ref.read(masterDataNotifierProvider.notifier);
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/ui/dialog/item_dialog_v2.png'),
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24,32,24,32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                title,
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 🌈 キャラ画像 + キラキラ
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Positioned.fill(child: SparkleField()) ,
                    RotatingClippedBackground(
                      imagePath: 'assets/images/ui/bg/sunburst.jpg', // ← あなたの画像
                      scale: 2.5,
                      size: 200,
                      child: Image.asset(
                        'assets/images/achievement/treasure.webp', //todo 画像差し替える
                        height: 120,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Divider(height: 24, thickness: 1),
              Text(
                subTitle ?? l.ach_achievementReward,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              ...[
                if(coins != 0 && coins != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //const SizedBox(width: 80),
                      Image.asset('assets/icons/coin.png', height: 24),
                      const SizedBox(width: 8),
                      Text("+${coins} ${l.coins}"),
                    ],
                  ),
                  const SizedBox(height: 8),
                ]
              ],

              // ▼ アイテム報酬（List<ItemReward>）
              ...items.map((item) {
                final itemMs = ms.findItemById(item.$1);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //const SizedBox(width: 80),

                      // アイテム画像（itemId からマスター検索することが多い）
                      Image.asset(
                        itemMs?.imageRes ?? "assets/icons/coin.png",   //todo デフォルトitemアイコンを追加する
                        height: 24,
                      ),

                      const SizedBox(width: 8),

                      Text("+${item.$2}"),
                    ],
                  ),
                );
              }).toList(),

              const SizedBox(height: 24),

              CancelButton(onTap: () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }
}