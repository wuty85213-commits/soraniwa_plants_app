import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/language/locale_notifier.dart';
import 'package:myplantapp_ver1/core/sound/sound_setting_notifier.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/home/credit_dialog.dart';

class SettingDialog extends ConsumerWidget {
  const SettingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final soundAsync = ref.watch(soundSettingNotifierProvider);
    final notifier = ref.read(soundSettingNotifierProvider.notifier);
    final localeAsync = ref.watch(localeNotifierProvider);
    final localeNotifier = ref.read(localeNotifierProvider.notifier);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/common/dialog_cream2.png'),
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
        child: soundAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('error: $e'),
          data: (soundState) {
            final (bgmOn, seOn) = soundState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(l.setting,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l.se,
                        style: TextStyle(
                            fontSize: 20
                        )
                    ),
                    Switch(
                        value: seOn,
                        onChanged: (_) => notifier.toggleSe()
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("BGM",
                        style: TextStyle(
                            fontSize: 20
                        )),
                    Switch(
                        value: bgmOn,
                        onChanged: (_) => notifier.toggleBgm()
                    ),
                  ],
                ),
                const Divider(),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l.language,
                        style: TextStyle(fontSize: 20)),
                    localeAsync.when(
                      loading: () => const CircularProgressIndicator(),
                      error: (e, _) => Text('エラー: $e'),
                      data: (locale) {
                        final currentLang = locale.languageCode;
                        final isSelected = [
                          currentLang == 'ja',
                          currentLang == 'en',
                        ];
                        return ToggleButtons(
                          borderRadius: BorderRadius.circular(8),
                          isSelected: isSelected,
                          onPressed: (index) async {
                            final newLang = index == 0 ? 'ja' : 'en';
                            await localeNotifier.switchLocale(newLang);
                          },
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('日本語'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('English'),
                            ),
                          ],
                          );
                      },
                    )
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // 設定ダイアログを閉じる
                    showDialog(
                      context: context,
                      builder: (_) => const CreditDialog(),
                    );
                  },
                  child: Text('📄 ${l.credit}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                CancelButton(onTap: () => Navigator.pop(context))
              ],
            );
          },
        )
      )
    );
  }
}