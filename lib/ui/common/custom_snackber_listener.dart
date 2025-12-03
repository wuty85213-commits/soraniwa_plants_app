
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/domain/model/achievement_list.dart';
import 'package:myplantapp_ver1/domain/model/achievement_model.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/achievememt/achievement_notifier.dart';

/// 🏆 実績解除を監視してSnackBarを順番に表示する共通関数
void useAchievementCustomSnackListener(WidgetRef ref, BuildContext context) {
  final l = AppLocalizations.of(context)!;
  // SnackBarキューとフラグを保持（画面単位で個別）
  final List<Achievement> snackQueue = [];
  bool isShowingSnack = false;

  void showNextSnack() {
    if (isShowingSnack || snackQueue.isEmpty) return;
    isShowingSnack = true;

    final achievement = snackQueue.removeAt(0);

    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green[600],
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Row(
        children: [
          const Icon(Icons.emoji_events, color: Colors.amber, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '🏆 ${l.achievement}！: ${l.getString(achievement.titleKey)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((_) {
      isShowingSnack = false;
      showNextSnack();
    });
  }

  // Riverpodの実績状態を常時監視
  ref.listen<List<Achievement>>(
    achievementNotifierProvider.select(
          (asyncState) => asyncState.value?.newlyUnlocked ?? const [],
    ),
        (prev, next) {
      if (next.isNotEmpty) {
        snackQueue.addAll(next);
        showNextSnack();
        ref.read(achievementNotifierProvider.notifier).flagClear();
      }
    },
  );
}