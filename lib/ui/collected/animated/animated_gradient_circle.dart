import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedGradientCircle extends StatelessWidget {
  final double targetPercent; // 0.0〜1.0
  final double size;
  final Duration duration;

  const AnimatedGradientCircle({
    super.key,
    required this.targetPercent,
    this.size = 120,
    this.duration = const Duration(seconds: 1),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: targetPercent),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return CustomPaint(
          painter: _GradientCirclePainter(value),
          child: SizedBox(
            height: size,
            width: size,
            child: Center(
              child: Text(
                "${(value * 100).toInt()}%",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF3CAC),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GradientCirclePainter extends CustomPainter {
  final double progress;

  _GradientCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 10.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    // 🔘 背景リング
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // 🌈 グラデーションリング
    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: math.pi * 1.5,
      colors: const [
        Color(0xFF6A5AE0),
        Color(0xFFFF3CAC),
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // 🌀 進行リング
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // 上から開始
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _GradientCirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}