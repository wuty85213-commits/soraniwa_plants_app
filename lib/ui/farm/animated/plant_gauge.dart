import 'package:flutter/material.dart';

class PlantGauge extends StatelessWidget {
  final double progress;
  final double width;
  final double height;

  const PlantGauge({
    super.key,
    required this.progress,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    final isFull = clamped >= 1.0;

    // ゲージ画像を切り替え（緑と黄色）
    final gaugeImage = isFull
        ? 'assets/images/common/gauge_yellow.png'   // ← 黄色ゲージ
        : 'assets/images/common/gauge_green.png'; // ← 緑ゲージ
    final frameImage = 'assets/images/common/gauge_frame.png'; // ← 枠（下敷き）

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Image.asset(frameImage, width: width, height: height, fit: BoxFit.fill),
          ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              widthFactor: clamped,
              child: Image.asset(
                gaugeImage,
                width: width,
                height: height,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}