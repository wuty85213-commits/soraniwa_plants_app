// --------------------------------------------------------------------
// 商品カード（背景画像＋半透明オーバーレイ）
// --------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';
import 'package:myplantapp_ver1/domain/model/achievement_list.dart';
import 'package:myplantapp_ver1/domain/model/achievement_model.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/achievememt/achievement_notifier.dart';
import 'package:myplantapp_ver1/ui/achievememt/dialog/achievement_dialog.dart';
import 'package:myplantapp_ver1/ui/achievememt/widget/ach_with_flags.dart';
import 'package:myplantapp_ver1/ui/common/button.dart';

class AchievementCard extends ConsumerWidget {
  final AchWithFlags achWithFlag;

  const AchievementCard({
    required this.achWithFlag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final achNf = ref.read(achievementNotifierProvider.notifier);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 120,
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  'assets/images/ui/card/card_bg.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.brown.withOpacity(0.15), // 柄をほんのり強調
                  colorBlendMode: BlendMode.multiply,
                ),
              ),
              Padding(padding: const EdgeInsets.all(4),
                child: Image.asset(
                  _getFrameImage(achWithFlag.ach.id),
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              )
            ],
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
                  child: Image.asset(
                      !achWithFlag.unlocked ?"assets/images/achievement/icons/box_grey.png"
                          :achWithFlag.rewarded ?"assets/images/achievement/icons/box_open.png"
                          :"assets/images/achievement/icons/box_close.png"
                  ),
                ),
                const SizedBox(width: 12),

                // テキスト部分
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l.getString(achWithFlag.ach.titleKey),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Flexible(
                          child: Text(
                            l.getString(achWithFlag.ach.descKey),
                            style: const TextStyle(fontSize: 13, color: Colors.black54),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),

                if(achWithFlag.unlocked && !achWithFlag.rewarded)
                  GlossyBuyButton(
                    text: l.claim,
                    topColor: Color(0xFFFF7A7A),
                    buttomColor: Color(0xFFD50000),
                    onPressed: () async{
                      await achNf.rewardReceive(achWithFlag.ach);
                      showDialog(context: context,
                        builder: (_) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            SoundManager.playHarvest();
                          });
                         return AchievementDialog(ach: achWithFlag.ach,);
                        });
                    },
                  )
                else
                  GlossyBuyButton(
                    text: (achWithFlag.rewarded) ?l.claimed :l.claim,
                    topColor: Colors.grey,
                    buttomColor: Colors.grey,
                    onPressed: () async{
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getFrameImage(String){
    if (String.contains("GOLD")){
      return "assets/images/achievement/frame/frame_gold.png";
    } else if (String.contains("RAINBOW")){
      return "assets/images/achievement/frame/frame_rainbow.png";
    } else {
      return "assets/images/achievement/frame/frame_black.png";
    }
  }
}