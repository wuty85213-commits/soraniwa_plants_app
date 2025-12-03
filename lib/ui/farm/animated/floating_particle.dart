import 'package:flutter/material.dart';

/// 🌈 粒子が上に舞うアニメーション
class FloatingParticle extends StatefulWidget {
  final int delay;
  final Color color;
  const FloatingParticle({super.key, this.delay = 0, required this.color});

  @override
  State<FloatingParticle> createState() => _FloatingParticleState();
}

class _FloatingParticleState extends State<FloatingParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionY;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _positionY = Tween<double>(begin: 0, end: -60).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _opacity = Tween<double>(begin: 1, end: 0).animate(_controller);
    _scale = Tween<double>(begin: 0.8, end: 1.4).animate(_controller);

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.translate(
          offset: Offset(0, _positionY.value),
          child: Transform.scale(
            scale: _scale.value,
            child: Opacity(
              opacity: _opacity.value,
              child: Icon(Icons.circle, color: widget.color, size: 6),
            ),
          ),
        );
      },
    );
  }
}