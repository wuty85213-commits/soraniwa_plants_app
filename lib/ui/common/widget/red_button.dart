import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';

class RedButton extends StatelessWidget {
  final String label;           // ボタンに表示するテキスト
  final VoidCallback onTap;     // タップ時の処理
  final double widthRatio;           // ボタン幅（任意）
  final double heightRatio;

  const RedButton({
    super.key,
    required this.label,
    required this.onTap,
    this.widthRatio = 0.28,
    this.heightRatio = 0.06,
  });

  @override
  Widget build(BuildContext context) {
    // 📱 画面サイズ取得
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 📐 比率を元に幅・高さを計算
    final buttonWidth = screenWidth * widthRatio;
    final buttonHeight = screenHeight * heightRatio;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          SoundManager.playClick();
          onTap();}, // 👈 引数で受け取った処理を呼ぶ
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: buttonWidth,
          height: buttonHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            // 🌑 外側の黒いドロップシャドウ
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,       // ← ぼかしの強さ（大きいほど柔らかい影）
                offset: const Offset(0, 4), // ← 影の位置（x方向, y方向）
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/common/bt_red.png',
                width: buttonWidth,
                height: buttonHeight,
                fit: BoxFit.fill,
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}