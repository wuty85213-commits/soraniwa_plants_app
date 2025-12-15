// 🌿 ストア画面
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/achievememt/achievement_notifier.dart';
import 'package:myplantapp_ver1/ui/achievememt/widget/achievement_card.dart';
import 'package:myplantapp_ver1/ui/achievememt/widget/achievement_filtersheet.dart';
import 'package:myplantapp_ver1/core/ad/banner_ad_widget.dart';

class AchievementScreen extends ConsumerWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final log = AppLogger.tag("Achievement Screen");
    final achievementAsync = ref.watch(achievementNotifierProvider);
    final notifier = ref.read(achievementNotifierProvider.notifier);
    log.d('Achievement Screen build');

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),
      body: SafeArea(
        child: achievementAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Achievement data reading error: $e')),
          data: (achState){
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/bg/bg_achievement.png",
                    fit: BoxFit.cover,
                  )
                ),
                Column(
                  children: [
                    // 🌿 トップバー
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/common/appbar_vine.png'),
                          fit: BoxFit.cover, // ← 画像を全体にフィットさせる
                        ),
                        //color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // 🔹 タイトル（中央固定）
                          Text(
                            l.achievement,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),

                          // 🔹 左上に戻るボタン
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          /*
                          // 🔽 フィルターボタン
                          Align(
                            alignment: Alignment.centerRight,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                popupMenuTheme: const PopupMenuThemeData(
                                    color: Colors.white
                                ),
                                checkboxTheme: CheckboxThemeData(
                                  fillColor: MaterialStatePropertyAll(Colors.white),
                                  checkColor: MaterialStatePropertyAll(Colors.black),
                                  side: const BorderSide(color: Colors.black, width: 1.5),
                                )
                              ),
                              child: PopupMenuButton<int>(
                                icon: const Icon(Icons.filter_list, color: Colors.black87),
                                position: PopupMenuPosition.under,
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 0,
                                    child: StatefulBuilder(
                                      builder: (context, setMenuState) => CheckboxListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(l.ach_unlocked),
                                        value: achState.showUnlocked,
                                        onChanged: (value) {
                                          notifier.toggleShowUnlocked(value!);
                                          setMenuState((){});
                                        },
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 1,
                                    child: StatefulBuilder(
                                      builder: (context, setMenuState) => CheckboxListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(l.ach_locked),
                                        value: achState.showLocked,
                                        onChanged: (value) {
                                          notifier.toggleShowLocked(value!);
                                          setMenuState((){});
                                        },
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: StatefulBuilder(
                                      builder: (context, setMenuState) => CheckboxListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(l.ach_received),
                                        value: achState.showReceived,
                                        onChanged: (value) {
                                          notifier.toggleShowshowReceived(value!);
                                          setMenuState((){});
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ),

                           */

                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.filter_list, color: Colors.black87),
                              style: IconButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,   // ← 波紋（紫塗りつぶし）を無効化
                                highlightColor: Colors.transparent,      // ← 長押しのハイライト色を透明
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: const Color(0xFFFFFDD0).withOpacity(0.95),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  builder: (_) => const AchievementFilterSheet(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🌸 スクロール可能リスト
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16,8,16,36),
                        itemCount: achState.filteredList.length,
                        itemBuilder: (_, index) {
                          final a = achState.filteredList[index];
                          return AchievementCard(
                            achWithFlag: a,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                // 📢 === ここがバナー広告を固定表示する部分 ===
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: BannerAdWidget(),  // ← バナー広告widget
                  ),
                ),
              ],
            );
          },
        )
      ),
    );
  }
}
