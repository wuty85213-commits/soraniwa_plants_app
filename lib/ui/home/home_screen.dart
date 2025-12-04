import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/language/locale_notifier.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/achievememt/achievement_screen.dart';
import 'package:myplantapp_ver1/ui/collected/collected_screen.dart';
import 'package:myplantapp_ver1/ui/farm/farm_screen.dart';
import 'package:myplantapp_ver1/ui/home/menu_button.dart';
import 'package:myplantapp_ver1/ui/home/setting_dialog.dart';
import 'package:myplantapp_ver1/ui/store/store_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final locale = ref.read(localeNotifierProvider).value;
    final code = locale?.languageCode ?? 'ja';
    final buttons = [
      {'label': l.garden, 'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FarmScreen()),
        );
      }},
      {'label': l.collection, 'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CollectedScreen()),
        );
      }},
      {'label': l.achievement, 'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AchievementScreen()),
        );
      }},
      {'label': l.store, 'onTap': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StoreScreen()),
        );
      }},
    ];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

          Image.asset(
            'assets/bg/bg_farm.png',
            fit: BoxFit.cover,
          ),

          // 本体
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 上のイメージ
                  Image.asset(
                    code == "ja"
                      ? 'assets/bg/home_main_ja.png'
                      : 'assets/bg/home_main_en.png'
                  ),

                  // ボタン群
                  Column(
                    children: buttons.map((btn) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: MenuButton(
                          label: btn['label'] as String,
                          onTap: btn['onTap'] as VoidCallback,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          // 設定アイコン
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.black, size: 40),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SettingDialog(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 背景画像
          Image.asset(
            'assets/ui/collect/collect_bg.png', // ←差し替え
            fit: BoxFit.cover,
          ),

          // 中央に縦配置のボタン群
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20), // 画面下からの余白

                child: Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/bamboo_1.png', // ←差し替え
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/ui/button/grey.png',
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                            Transform.translate(
                              offset: Offset(0, -9),
                              child: const Text(
                                "お庭",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Colors.black26,
                                      offset: Offset(1, -1),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/ui/button/grey.png',
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                            Transform.translate(
                              offset: Offset(0, -9),
                              child: const Text(
                                "図鑑",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Colors.black26,
                                      offset: Offset(1, -1),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/ui/button/grey.png',
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                            Transform.translate(
                              offset: Offset(0, -9),
                              child: const Text(
                                "実績",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Colors.black26,
                                      offset: Offset(1, -1),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // 🔘 ボタン部（固定配置）
                      GestureDetector(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/ui/button/grey.png',
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                            Transform.translate(
                              offset: Offset(0, -9),
                              child: const Text(
                                "ショップ",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Colors.black26,
                                      offset: Offset(1, -1),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),

          // 歯車アイコン（左上）
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.black, size: 40),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => SettingDialog()
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label tapped')),
    );
  }
}

class ImageButton extends StatelessWidget {
  const ImageButton({
    super.key,
    required this.imagePath,
    required this.onTap,
    this.borderRadius = 20,
    this.elevation = 6,
  });

  final String imagePath;
  final VoidCallback onTap;
  final double borderRadius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Ink.image(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          width: double.infinity,
          height: 80, // ボタン高さ（必要に応じて変更）
        ),
      ),
    );
  }
}

 */