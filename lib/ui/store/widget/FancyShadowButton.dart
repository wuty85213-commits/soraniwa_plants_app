import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FancyShadowButton extends StatelessWidget {
  const FancyShadowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // 🌑 外側の黒いドロップシャドウ
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 🟥 背景ボタン（SVG）
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SvgPicture.asset(
              'assets/images/ui/button/red_v1.svg',
              width: 120,
              height: 48,
            ),
          ),

          // 💡 内側に白のインナーシャドウを再現
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.6),
                  offset: const Offset(0, -2), // 上方向に光るように
                  blurRadius: 4,
                  spreadRadius: -2, // spreadを負にして内側方向にぼかす！
                ),
              ],
            ),
          ),

          // 📝 テキスト（完全中央）
          const Center(
            child: Text(
              "決定",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    offset: Offset(0, 2),
                    blurRadius: 3,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}