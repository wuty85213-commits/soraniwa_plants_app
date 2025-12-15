import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final _bgmPlayer = AudioPlayer();
  static final _sePlayer = AudioPlayer();

  static bool _bgmOn = true;
  static bool _seOn = true;

  static Future<void> playBgm() async {
    if (!_bgmOn) return;
    await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
    await _bgmPlayer.play(AssetSource('sounds/farm_bg.mp3'));
  }

  static Future<void> stopBgm() async => _bgmPlayer.stop();

  static Future<void> playClick() async {
    if (!_seOn) return;
    await _sePlayer.play(AssetSource('sounds/sample_1.mp3'));
  }

  static Future<void> playHarvest() async {
    if (!_seOn) return;
    await _sePlayer.play(AssetSource('sounds/success.mp3'));
  }

  static Future<void> playWaterFade() async {
    if (!_seOn) return;
    final player = AudioPlayer();

    await player.play(AssetSource("sounds/water.mp3"));

    Future.delayed(const Duration(milliseconds: 300), () {
      player.setVolume(0.0);
      player.stop();
    });
  }

  static Future<void> playWaterOnce() async {
    if (!_seOn) return;
    final player = AudioPlayer();

    await player.play(AssetSource("sounds/water.mp3"));

    await Future.delayed(const Duration(seconds: 1));
    player.stop();
  }

  static void setBgmEnabled(bool enabled) {
    _bgmOn = enabled;
  }

  static void setSeEnabled(bool enabled) {
    _seOn = enabled;
  }
}