import 'dart:math';
import 'package:flutter/material.dart';

class SparkleField extends StatefulWidget {
  const SparkleField({super.key});

  @override
  State<SparkleField> createState() => _SparkleFieldState();
}

class _SparkleFieldState extends State<SparkleField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_SparkleParticle> _particles = [];
  final Random _rand = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(_updateParticles);

    // 初期生成
    _spawnParticles(40);
    _controller.repeat();
  }

  void _spawnParticles(int count) {
    for (var i = 0; i < count; i++) {
      final angle = _rand.nextDouble() * 2 * pi;
      final speed = 20 + _rand.nextDouble() * 40;
      final lifetime = 1.0 + _rand.nextDouble() * 1.5;

      _particles.add(
        _SparkleParticle(
          x: 0,
          y: 0,
          vx: cos(angle) * speed,
          vy: sin(angle) * speed,
          lifetime: lifetime,
          color: [
            Colors.yellowAccent,
            Colors.white,
            Colors.lightBlueAccent,
            Colors.orangeAccent
          ][_rand.nextInt(4)],
          size: 2 + _rand.nextDouble() * 3,
        ),
      );
    }
  }

  void _updateParticles() {
    const dt = 1 / 60;
    for (var p in _particles) {
      p.age += dt;
      p.x += p.vx * dt;
      p.y += p.vy * dt;
    }

    // 消えた粒を削除
    _particles.removeWhere((p) => p.age > p.lifetime);

    // 新しい粒を補充
    if (_particles.length < 40) {
      _spawnParticles(5);
    }

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SparklePainter(_particles),
      size: const Size(double.infinity, double.infinity),
    );
  }
}

class _SparkleParticle {
  double x, y;
  double vx, vy;
  double age = 0;
  double lifetime;
  double size;
  Color color;

  _SparkleParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.lifetime,
    required this.color,
    required this.size,
  });
}

class _SparklePainter extends CustomPainter {
  final List<_SparkleParticle> particles;
  _SparklePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    for (var p in particles) {
      final progress = (p.age / p.lifetime).clamp(0.0, 1.0);
      final fade = (1.0 - progress);

      // 徐々に上昇しながら拡散する
      final offset = center.translate(p.x, p.y - progress * 20);

      paint.color = p.color.withValues(alpha: fade);
      canvas.drawCircle(offset, p.size * fade, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SparklePainter oldDelegate) => true;
}