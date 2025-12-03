import 'package:flutter/material.dart';

/// 💧 水滴が下に落ちるアニメーション
class WaterDrop extends StatefulWidget {
  final int delay;
  const WaterDrop({super.key, this.delay = 0});

  @override
  State<WaterDrop> createState() => _WaterDropState();
}

class _WaterDropState extends State<WaterDrop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _position;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _position = Tween<double>(begin: 0, end: 120).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _opacity = Tween<double>(begin: 1, end: 0).animate(_controller);

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
          offset: Offset(0, _position.value),
          child: Opacity(
            opacity: _opacity.value,
            child: const Icon(Icons.water_drop, color: Colors.lightBlueAccent, size: 16),
          ),
        );
      },
    );
  }
}