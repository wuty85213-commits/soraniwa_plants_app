import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';

/// 🌿 背景画像付きカスタム通知ダイアログ
class SimpleInfoDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onClose;

  const SimpleInfoDialog({
    super.key,
    required this.title,
    required this.message,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 120),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
            child: Text(title,
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
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/ui/dialog/dialog_body.png'),
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
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),

                Text(message,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4B4B2F),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                CancelButton(onTap: () => Navigator.pop(context))
              ],
            ),
          ),
        ],
      )
    );
  }
}