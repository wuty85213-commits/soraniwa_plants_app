import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/domain/model/achievement_list.dart';
import 'package:myplantapp_ver1/domain/model/achievement_model.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/farm/animated/rotatingbackground.dart';
import 'package:myplantapp_ver1/ui/farm/animated/sparkle_field.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';

class AchievementDialog extends ConsumerWidget {
  final Achievement ach;

  const AchievementDialog({
  super.key, required this.ach});

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
            image: AssetImage('assets/images/common/dialog_cream2.png'),
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
              Text(
                "🌿 ${l.getString(ach.titleKey)} 🌿",
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
                      imagePath: 'assets/images/common/sunburst.jpg', // ← あなたの画像
                      scale: 2.5,
                      size: 200,
                      child: Image.asset(
                        'assets/images/achievement/treasure.webp',
                        height: 120,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Divider(height: 24, thickness: 1),
              Text(
                l.ach_achievementReward,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              ...[
                if(ach.reward.coins > 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 40),
                      Image.asset('assets/icons/coin.webp', height: 24),
                      const SizedBox(width: 8),
                      Text("+${ach.reward.coins} ${l.coins}"),
                    ],
                  ),
                  const SizedBox(height: 8),
                ]
              ],

              // ▼ アイテム報酬（List<ItemReward>）
              ...ach.reward.items.map((item) {
                final itemMs = ms.findItemById(item.itemId);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const SizedBox(width: 40),

                      Image.asset(
                        itemMs?.imageRes ?? "assets/icons/item.webp",
                        height: 24,
                      ),

                      const SizedBox(width: 8),

                      Text("+${item.quantity}"),
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