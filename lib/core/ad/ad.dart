import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:myplantapp_ver1/core/config/env.dart';

RewardedAd? _rewardedAd;

void loadRewardedAd() {
  RewardedAd.load(
    adUnitId: Platform.isAndroid
        ? "ca-app-pub-3940256099942544/5224354917"
        : "ca-app-pub-3940256099942544/1712485313",
    request: const AdRequest(),
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (ad) {
        _rewardedAd = ad;
        debugPrint('RewardedAd loaded');
      },
      onAdFailedToLoad: (error) {
        debugPrint('Failed to load RewardedAd: $error');
        _rewardedAd = null;
      },
    ),
  );
}

Future<void> showRewardAd(Future<void> Function() rewardCallback) async{
  if (_rewardedAd == null) {
    debugPrint("RewardAd is not ready");
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