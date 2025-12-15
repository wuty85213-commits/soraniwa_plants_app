import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/env.dart';

RewardedAd? _rewardedAd;

void loadRewardedAd() {
  final log = AppLogger.tag("ad📺");
  RewardedAd.load(
    adUnitId: Platform.isAndroid
        ? "ca-app-pub-3940256099942544/5224354917"
        : "ca-app-pub-3940256099942544/1712485313", //test Id

    // Myapp ca-app-pub-1156628205301218/2992026239
    request: const AdRequest(),
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (ad) {
        _rewardedAd = ad;
        log.d('RewardedAd loaded');
      },
      onAdFailedToLoad: (error) {
        log.e('Failed to load RewardedAd: $error');
        _rewardedAd = null;
      },
    ),
  );
}

Future<void> showRewardAd(Future<void> Function() rewardCallback) async{
  final log = AppLogger.tag("ad📺");
  if (_rewardedAd == null) {
    log.d("RewardAd is not ready");
    return;
  }

  _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
    onAdDismissedFullScreenContent: (ad) {
      ad.dispose();
      loadRewardedAd();   // 再読み込み
    },
  );

  await _rewardedAd!.show(
    onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
      await rewardCallback(); // ⭐ 正しく待機する
    },
  );
}

Future<bool> canWatchAd() async {
  final box = Hive.box('rewardBox_${EnvConfig.flavor}');

  final today = DateFormat('yyyyMMdd').format(DateTime.now());
  final lastDate = box.get("lastRewardDate", defaultValue: "") as String;
  int count = box.get("rewardCount", defaultValue: 0) as int;

  // 日付が変わっていたらリセット
  if (lastDate != today) {
    await box.put("lastRewardDate", today);
    await box.put("rewardCount", 0);
    return true;
  }

  return count < 3; // 3回未満なら視聴可能
}

Future<void> increaseCount() async {
  final box = Hive.box('rewardBox_${EnvConfig.flavor}');
  int count = box.get("rewardCount", defaultValue: 0);
  await box.put("rewardCount", count + 1);
}