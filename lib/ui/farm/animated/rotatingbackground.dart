import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/ui/farm/animated/sparkle_field.dart';

class RotatingClippedBackground extends StatefulWidget {
  final String imagePath;
  final Widget child;
  final double size;
  final double scale;

  const RotatingClippedBackground({
    super.key,
    required this.imagePath,
    required this.child,
    this.size = 200,
    this.scale = 2.0, // ← 背景拡大倍率
  });

  @override
  State<RotatingClippedBackground> createState() =>
      _RotatingClippedBackgroundState();
}

class _RotatingClippedBackgroundState extends State<RotatingClippedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24), // ← 丸みを出したい場合
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 🌞 背景画像（拡大＋回転）
            RotationTransition(
              turns: _controller,
              child: Transform.scale(
                scale: widget.scale, // ← 拡大倍率
                child: Opacity(
                  opacity: 0.9,
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // 🌟 きらきらエフェクトを重ねる（任意）
            const Positioned.fill(child: IgnorePointer(child: SparkleField())),

            // 🌿 中央キャラ
            widget.child,
          ],
        ),
      ),
    );
  }
}