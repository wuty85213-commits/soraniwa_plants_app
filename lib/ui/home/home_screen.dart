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