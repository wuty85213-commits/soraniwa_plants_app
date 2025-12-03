
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/domain/model/achievement_list.dart';
import 'package:myplantapp_ver1/domain/model/achievement_model.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/achievememt/achievement_notifier.dart';

/// 🏆 実績解除を監視してSnackBarを順番に表示する共通関数
void useAchievementSnackListener(WidgetRef ref, BuildContext context) {
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

  void showAchievementOverlay() {
    if (isShowingSnack || snackQueue.isEmpty) return;
    isShowingSnack = true;

    if (!context.mounted) return;

    final achievement = snackQueue.removeAt(0);
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final ticker = TickerProviderImpl(); // 独自の tickerProvider を一時的に作る

    final animationController = AnimationController(
      vsync: ticker,
      duration: const Duration(milliseconds: 400),
    );

    final slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // ✅ 右端からスライドイン
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutCubic,
    ));

    final fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 24,
        right: 24,
        child: Material(
          color: Colors.transparent,
          child:
          SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  // 💎 黒を基調にした透明感のあるグラデーション
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1A1A1A),
                      Color(0xFF2A2A2A),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.amberAccent.withOpacity(0.7), // ゴールドの縁取り
                    width: 1.2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.emoji_events_rounded,
                      color: Colors.amberAccent,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${l.achievement}！',
                            style: TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l.getString(achievement.titleKey),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ),
      ),
    );

    overlay.insert(entry);

    animationController.forward();
    Future.delayed(const Duration(seconds: 5), () async {

      if (!context.mounted) {
        entry.remove();
        animationController.dispose();
        ticker.dispose();
        return;
      }

      try {
        // dispose前であればアニメーションを逆再生
        await animationController.reverse();
      } catch (e) {
        // すでにdisposeされていた場合などは無視
      }

      // entryを削除してリソースを解放
      entry.remove();
      animationController.dispose();
      ticker.dispose();
      isShowingSnack = false;

      // 次の実績があれば少し待ってから表示
      if (snackQueue.isNotEmpty) {
        await Future.delayed(const Duration(milliseconds: 300));
        showAchievementOverlay();
      }
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
        showAchievementOverlay();
        ref.read(achievementNotifierProvider.notifier).flagClear();
      }
    },
  );
}
/// ✅ 一時的なTickerProvider実装
class TickerProviderImpl extends TickerProvider {
  final List<Ticker> _tickers = [];
  @override
  Ticker createTicker(TickerCallback onTick) {
    final ticker = Ticker(onTick);
    _tickers.add(ticker);
    return ticker;
  }

  void dispose() {
    for (final ticker in _tickers) {
      ticker.dispose();
    }
  }
}