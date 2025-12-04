import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/user_notifier.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/farm/dialog/pot_item_grid_dialog.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';

class PotSettingDialog extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final userAsync = ref.watch(userNotifierProvider);
    final master = ref.read(masterDataNotifierProvider.notifier);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40,vertical: 80),
      child: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Userデータ読込エラー: $e')),
        data: (userState) {
          final user = userState.user;
          final pots = userState.pots;
          return Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/common/dialog_cream2.png"),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 6),
                    blurRadius: 10
                )
              ],
            ),
            padding: const EdgeInsets.fromLTRB(24,32,24,32),
            width: double.maxFinite,
            height: 450,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    l.farm_potlist,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: ScrollbarTheme(
                      data: ScrollbarThemeData(
                        thumbColor: MaterialStateProperty.all(
                          const Color(0xFFBFA97A).withOpacity(0.8), // 優しいブラウン
                        ),
                        trackColor: MaterialStateProperty.all(
                          const Color(0xFFFFF8E1).withOpacity(0.5), // うっすら背景トラック
                        ),
                        trackBorderColor: MaterialStateProperty.all(Colors.transparent),
                        radius: const Radius.circular(12),
                        thickness: MaterialStateProperty.all(6),
                      ),
                      child: Scrollbar(
                        thumbVisibility: true,
                        radius: const Radius.circular(12),
                        child: ListView.builder(
                          itemCount: user.unlockedSlots,
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                          itemBuilder: (context, index) {
                            final pot = pots.firstWhereOrNull((e) => e.slotIndex == index);
                            final item = master.findItemById(pot?.itemId ?? 500); //★マスタデータ検索
                            return Card(
                              color: const Color(0xFFFFFCF5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                side: const BorderSide(color: Color(0xFFE7D6A8), width: 1.2),
                              ),
                              elevation: 3,
                              shadowColor: Colors.brown.withOpacity(0.2),
                              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(14),

                                  //画面遷移
                                  onTap: () async {
                                    SoundManager.playClick();
                                    //もし肥料を持っていない場合、終了!
                                    //final fertilizerItems = inventory.where((item) => item.itemType == "fertilizer").toList();
                                    //if(fertilizerItems.isEmpty){ ★plantseedの処理★　return;}
                                    Future.microtask(() {
                                      showDialog(
                                        context: context,
                                        builder: (_) =>
                                            PotItemGridDialog(slotIndex: index)
                                      );
                                    });
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                      child: Row(
                                        children: [
                                          // 🌱 種アイコン
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFF8E1),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color: const Color(0xFFE0C97F), width: 1),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 14), // ← アイコンを下にずらす
                                              child: Image.asset(
                                                item?.imageRes ?? "assets/icons/item.webp",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),

                                          // 🌾 テキスト情報
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${l.pot} ${index + 1}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Color(0xFF4B3E2B),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '${item?.name ?? 'defult'}',
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xFF7A6B50),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Icon(Icons.chevron_right, color: Color(0xFFBFA97A)),
                                        ],
                                      )
                                  )
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CancelButton(
                      onTap: () => Navigator.pop(context,false)
                  ),
                ]
            ),
          );
        }
      )
    );
  }
}