import 'package:flutter/material.dart';

class DialogHeader extends StatelessWidget {
  final String label;           // ボタンに表示するテキスト

  const DialogHeader({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ui/dialog/dialog_header.png'),
            fit: BoxFit.fill,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25), // 🔹影の色と透明度
              offset: const Offset(0, 8),             // 🔹影の方向
              blurRadius: 10,                         // 🔹ぼかし量
              spreadRadius: 0.5, // 🔹影の広がり
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 3,
                color: Colors.black26,
                offset: Offset(1, 2),
              )
            ],
          ),
        )
      );
  }
}