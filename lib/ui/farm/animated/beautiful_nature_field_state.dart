import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// 🦋🐝🌸 背景で蝶・蜂・花びらが舞う豪華アニメーション
class BeautifulNatureField extends StatefulWidget {
  const BeautifulNatureField({super.key});

  @override
  State<BeautifulNatureField> createState() => _BeautifulNatureFieldState();
}

class _BeautifulNatureFieldState extends State<BeautifulNatureField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _rand = Random();

  final List<_Butterfly> _butterflies = [];
  final List<_Bee> _bees = [];
  final List<_Petal> _petals = [];

  // 🖼️ 各種画像
  final List<ui.Image> _butterflyFrames = [];
  ui.Image? _beeImg;
  ui.Image? _petalImg;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 200),
    )..addListener(_update);

    _loadImages();
    _spawnInitial();
    _controller.repeat();
  }

  // 🦋 画像を読み込み
  Future<void> _loadImages() async {
    Future<ui.Image> load(String path) async {
      final data = await DefaultAssetBundle.of(context).load(path);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      return frame.image;
    }

    // 羽ばたきフレーム
    for (final path in [
      'assets/icons/butterfly_1.webp',
      'assets/icons/butterfly_2.webp',
      'assets/icons/butterfly_3.webp',
    ]) {
      _butterflyFrames.add(await load(path));
    }

    _beeImg = await load('assets/icons/bee.webp');
    _petalImg = await load('assets/icons/petal.webp');

    setState(() {});
  }

  // 🌸 初期生成
  void _spawnInitial() {
    for (int i = 0; i < 7; i++) {
      _butterflies.add(_Butterfly(
        x: _rand.nextDouble() * 400,
        y: _rand.nextDouble() * 700,
        angle: _rand.nextDouble() * 2 * pi,
        speed: 0.6 + _rand.nextDouble() * 0.5,
        size: 40 + _rand.nextDouble() * 20,
      ));
    }
    for (int i = 0; i < 4; i++) {
      _bees.add(_Bee(
        x: _rand.nextDouble() * 400,
        y: _rand.nextDouble() * 700,
        angle: _rand.nextDouble() * 2 * pi,
        speed: 1.2 + _rand.nextDouble() * 0.8,
        size: 24 + _rand.nextDouble() * 12,
      ));
    }
    for (int i = 0; i < 20; i++) {
      _petals.add(_Petal(
        x: _rand.nextDouble() * 400,
        y: _rand.nextDouble() * 700,
        vy: 0.4 + _rand.nextDouble() * 0.6,
        vx: (_rand.nextDouble() - 0.5) * 0.3,
        rotation: _rand.nextDouble() * pi * 2,
        rotationSpeed: (_rand.nextDouble() - 0.5) * 0.03,
        size: 10 + _rand.nextDouble() * 18,
      ));
    }
  }

  void _update() {
    for (final b in _butterflies) {
      b.time += 0.016;
      b.x += cos(b.angle) * b.speed;
      b.y += sin(b.angle + sin(b.time)) * b.speed;
      b.angle += sin(b.time * 0.5) * 0.02;

      // 羽ばたきアニメ（1秒8fps）
      b.frameTime += 0.016;
      if (b.frameTime > 0.125) {
        b.frameTime = 0;
        b.frame = (b.frame + 1) % 3;
      }

      if (b.x > 500) b.x = -50;
      if (b.x < -50) b.x = 500;
      if (b.y > 800) b.y = -50;
      if (b.y < -50) b.y = 800;
    }

    for (final bee in _bees) {
      bee.time += 0.016;
      bee.x += cos(bee.angle + sin(bee.time * 2)) * bee.speed;
      bee.y += sin(bee.angle + cos(bee.time * 3)) * bee.speed * 0.7;

      if (bee.x > 500) bee.x = -50;
      if (bee.x < -50) bee.x = 500;
      if (bee.y > 800) bee.y = -50;
      if (bee.y < -50) bee.y = 800;
    }

    for (final p in _petals) {
      p.y += p.vy;
      p.x += p.vx;
      p.rotation += p.rotationSpeed;

      if (p.y > 820) {
        p.y = -20;
        p.x = _rand.nextDouble() * 400;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: CustomPaint(
        painter: _NaturePainter(
          butterflies: _butterflies,
          bees: _bees,
          petals: _petals,
          butterflyFrames: _butterflyFrames,
          beeImg: _beeImg,
          petalImg: _petalImg,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// 🦋 クラス群 ==============================

class _Butterfly {
  double x, y, angle, speed, size, time = 0;
  int frame = 0;
  double frameTime = 0;
  _Butterfly({
    required this.x,
    required this.y,
    required this.angle,
    required this.speed,
    required this.size,
  });
}

class _Bee {
  double x, y, angle, speed, size, time = 0;
  _Bee({
    required this.x,
    required this.y,
    required this.angle,
    required this.speed,
    required this.size,
  });
}

class _Petal {
  double x, y, vx, vy, rotation, rotationSpeed, size;
  _Petal({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.rotation,
    required this.rotationSpeed,
    required this.size,
  });
}

// 🎨 Painter ===============================

class _NaturePainter extends CustomPainter {
  final List<_Butterfly> butterflies;
  final List<_Bee> bees;
  final List<_Petal> petals;
  final List<ui.Image> butterflyFrames;
  final ui.Image? beeImg;
  final ui.Image? petalImg;

  _NaturePainter({
    required this.butterflies,
    required this.bees,
    required this.petals,
    required this.butterflyFrames,
    required this.beeImg,
    required this.petalImg,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;

    // 🌸 花びら
    for (final p in petals) {
      if (petalImg == null) continue;
      canvas.save();
      canvas.translate(p.x, p.y);
      canvas.rotate(p.rotation);
      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: p.size,
        height: p.size,
      );
      paint.color = Colors.white.withValues(alpha: 0.8);
      canvas.drawImageRect(
        petalImg!,
        Rect.fromLTWH(0, 0, petalImg!.width.toDouble(), petalImg!.height.toDouble()),
        rect,
        paint,
      );
      canvas.restore();
    }

    // 🦋 蝶
    if (butterflyFrames.isNotEmpty) {
      for (final b in butterflies) {
        final img = butterflyFrames[b.frame];
        final rect = Rect.fromCenter(
          center: Offset(b.x, b.y),
          width: b.size,
          height: b.size,
        );
        canvas.save();
        canvas.translate(b.x, b.y);
        canvas.rotate(sin(b.time * 0.8) * 0.3);
        canvas.translate(-b.x, -b.y);
        canvas.drawImageRect(
          img,
          Rect.fromLTWH(0, 0, img.width.toDouble(), img.height.toDouble()),
          rect,
          paint,
        );
        canvas.restore();
      }
    }

    // 🐝 蜂
    if (beeImg != null) {
      for (final bee in bees) {
        final rect = Rect.fromCenter(
          center: Offset(bee.x, bee.y),
          width: bee.size,
          height: bee.size,
        );
        canvas.save();
        canvas.translate(bee.x, bee.y);
        canvas.rotate(sin(bee.time * 6) * 0.2);
        canvas.translate(-bee.x, -bee.y);
        canvas.drawImageRect(
          beeImg!,
          Rect.fromLTWH(0, 0, beeImg!.width.toDouble(), beeImg!.height.toDouble()),
          rect,
          paint,
        );
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}



/*

/// 🦋🐝🌸 背景で自然が舞うアニメーション
class BeautifulNatureField extends StatefulWidget {
  const BeautifulNatureField({super.key});

  @override
  State<BeautifulNatureField> createState() => _BeautifulNatureFieldState();
}

class _BeautifulNatureFieldState extends State<BeautifulNatureField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _rand = Random();

  final List<_Particle> _butterflies = [];
  final List<_Particle> _bees = [];
  final List<_Particle> _petals = [];

  ui.Image? _butterflyImg;
  ui.Image? _beeImg;
  ui.Image? _petalImg;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 120),
    )..addListener(_updateParticles);

    _loadImages();
    _spawnInitialParticles();
    _controller.repeat();
  }

  Future<void> _loadImages() async {
    Future<ui.Image> load(String path) async {
      final data = await DefaultAssetBundle.of(context).load(path);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      return frame.image;
    }

    _butterflyImg = await load('assets/icons/coin.png');
    _beeImg = await load('assets/icons/seed.png');
    _petalImg = await load('assets/icons/crown.png');
    setState(() {});
  }

  void _spawnInitialParticles() {
    for (int i = 0; i < 6; i++) {
      _butterflies.add(_randomParticle(0, 1.2));
    }
    for (int i = 0; i < 4; i++) {
      _bees.add(_randomParticle(0, 2.0));
    }
    for (int i = 0; i < 14; i++) {
      _petals.add(_randomParticle(pi / 2, 0.5));
    }
  }

  _Particle _randomParticle(double baseAngle, double speed) {
    return _Particle(
      x: _rand.nextDouble() * 400,
      y: _rand.nextDouble() * 700,
      vx: cos(baseAngle + _rand.nextDouble()) * speed,
      vy: sin(baseAngle + _rand.nextDouble()) * speed,
      size: 20 + _rand.nextDouble() * 40,
      type: _ParticleType.values[_rand.nextInt(3)],
    );
  }

  void _updateParticles() {
    for (final p in [..._butterflies, ..._bees, ..._petals]) {
      p.time += 0.016;
      p.x += p.vx;
      p.y += p.vy + sin(p.time * 1.2) * 0.5;

      if (p.y > 820) p.y = -20;
      if (p.x > 420) p.x = -20;
      if (p.x < -20) p.x = 420;
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
    return IgnorePointer(
      child: CustomPaint(
        painter: _NaturePainter(
          butterflies: _butterflies,
          bees: _bees,
          petals: _petals,
          butterflyImg: _butterflyImg,
          beeImg: _beeImg,
          petalImg: _petalImg,
        ),
      ),
    );
  }
}

enum _ParticleType { butterfly, bee, petal }

class _Particle {
  double x, y, vx, vy, size, time = 0;
  _ParticleType type;
  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.type,
  });
}

class _NaturePainter extends CustomPainter {
  final List<_Particle> butterflies;
  final List<_Particle> bees;
  final List<_Particle> petals;
  final ui.Image? butterflyImg, beeImg, petalImg;

  _NaturePainter({
    required this.butterflies,
    required this.bees,
    required this.petals,
    required this.butterflyImg,
    required this.beeImg,
    required this.petalImg,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;

    // 花びらは奥に（柔らかく透明に）
    for (final p in petals) {
      if (petalImg != null) {
        final opacity = 0.4 + 0.3 * sin(p.time);
        paint.color = Colors.white.withValues(alpha: opacity);
        final rect = Rect.fromCenter(
          center: Offset(p.x, p.y),
          width: p.size,
          height: p.size,
        );
        canvas.drawImageRect(
          petalImg!,
          Rect.fromLTWH(0, 0, petalImg!.width.toDouble(), petalImg!.height.toDouble()),
          rect,
          paint,
        );
      }
    }

    // 🦋 ちょうちょ
    for (final p in butterflies) {
      if (butterflyImg != null) {
        final scale = 1 + 0.1 * sin(p.time * 8);
        final rect = Rect.fromCenter(
          center: Offset(p.x, p.y),
          width: p.size * scale,
          height: p.size * scale,
        );
        canvas.save();
        canvas.translate(p.x, p.y);
        canvas.rotate(sin(p.time) * 0.3);
        canvas.translate(-p.x, -p.y);
        canvas.drawImageRect(
          butterflyImg!,
          Rect.fromLTWH(0, 0, butterflyImg!.width.toDouble(), butterflyImg!.height.toDouble()),
          rect,
          paint,
        );
        canvas.restore();
      }
    }

    // 🐝 蜂（速く小刻みに）
    for (final p in bees) {
      if (beeImg != null) {
        final scale = 1 + 0.2 * sin(p.time * 20);
        final rect = Rect.fromCenter(
          center: Offset(p.x, p.y),
          width: p.size * scale,
          height: p.size * scale,
        );
        canvas.drawImageRect(
          beeImg!,
          Rect.fromLTWH(0, 0, beeImg!.width.toDouble(), beeImg!.height.toDouble()),
          rect,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


 */

