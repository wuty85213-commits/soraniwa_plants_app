import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:myplantapp_ver1/core/language/locale_notifier.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';
import 'package:myplantapp_ver1/domain/model/item_amount.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/dialog/reward_dialog.dart';
import 'package:myplantapp_ver1/ui/common/inventory_notifier.dart';
import 'package:myplantapp_ver1/ui/common/user_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmTutorialScreen extends ConsumerWidget {

  const FarmTutorialScreen({super.key});

  Future<void> _completeTutorial(BuildContext context, WidgetRef ref) async {
    final userNf = ref.read(userNotifierProvider.notifier);
    final ivNf = ref.read(inventoryNotifierProvider.notifier);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("tutorial_farm_done", true);

    // Farm画面に戻る
    Navigator.pop(context);

    await userNf.addCoin(500);
    final addItems = [ItemAmount(101, 3),ItemAmount(500, 1)];
    await ivNf.addItems(addItems);

    // pop直後にダイアログを出す
    Future.microtask(() {
      showDialog(
        context: context,
        builder: (_) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SoundManager.playHarvest();
          });
          return RewardDialog(
              title: 'チュートリアル達成報酬',
              coins: 500,
              items: [(101, 3), (500, 1)]
          );
        }
      );

    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.read(localeNotifierProvider).value;
    final code = locale?.languageCode ?? 'ja';
    final l = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight * 0.7;
    return IntroductionScreen(
      globalBackgroundColor: const Color(0xFFF5F8F4),
      pages: [
        PageViewModel(
          titleWidget: const SizedBox(),
          bodyWidget:Container(
            child: Stack(
                children: [
                  Image.asset(
                      (code == 'ja')
                          ?'assets/images/ui/bg/tutorial1_ja.png'
                          :'assets/images/ui/bg/tutorial1_en.png',
                      width: screenWidth * 0.65),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F8F4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey, // ボーダーの色
                        width: 2,           // ボーダーの太さ
                      ),
                    ),  // ← テキストの後ろが白くなる
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      l.farm_tutorial1,
                      style: GoogleFonts.notoSansJp(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2), blurRadius: 3, color: Colors.black12,),
                        ],
                      ),
                    ),
                  )
                ]
            ),
          )
        ),
        PageViewModel(
          titleWidget: const SizedBox(),
          bodyWidget:Container(
            child: Stack(
                children: [
                  Image.asset(
                      (code == 'ja')
                          ?'assets/images/ui/bg/tutorial2_ja.png'
                          :'assets/images/ui/bg/tutorial2_en.png',
                      width: screenWidth * 0.65),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F8F4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey, // ボーダーの色
                        width: 2,           // ボーダーの太さ
                      ),
                    ),  // ← テキストの後ろが白くなる
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      l.farm_tutorial2,
                      style: GoogleFonts.notoSansJp(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2), blurRadius: 3, color: Colors.black12,),
                        ],
                      ),
                    ),
                  )
                ]
            ),
          )
          //body: "水をあげると植物が育ちます。少しずつ大きくなっていきます！",
        ),
        PageViewModel(
          titleWidget: const SizedBox(),
          bodyWidget:Container(
            child: Stack(
                children: [
                  Image.asset(
                      (code == 'ja')
                          ?'assets/images/ui/bg/tutorial3_ja.png'
                          :'assets/images/ui/bg/tutorial3_en.png',
                      width: screenWidth * 0.65),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F8F4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey, // ボーダーの色
                        width: 2,           // ボーダーの太さ
                      ),
                    ),  // ← テキストの後ろが白くなる
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      l.farm_tutorial3,
                      style: GoogleFonts.notoSansJp(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2), blurRadius: 3, color: Colors.black12,),
                        ],
                      ),
                    ),
                  )
                ]
            ),
          )
          //body: "育ち切ったら収穫できます！コインや報酬をゲットしよう！",
        ),
      ],
      showSkipButton: true,
      skip: Text(l.skip),
      next: const Icon(Icons.arrow_forward),
      done: Text(l.start),
      onDone: () => _completeTutorial(context,ref),
    );
  }
}