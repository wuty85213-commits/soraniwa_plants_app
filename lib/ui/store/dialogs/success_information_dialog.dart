import 'package:flutter/material.dart';

class SuccessInformationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onClose;

  const SuccessInformationDialog({
    super.key,
    required this.title,
    required this.message,
    this.onClose,
  });

  static Future<void> show(
      BuildContext context, {
        required String title,
        required String message,
        VoidCallback? onClose,
      }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, _, __) => Center(
        child: SuccessInformationDialog(title: title, message: message, onClose: onClose),
      ),
      transitionBuilder: (context, anim1, _, child) {
        return Transform.scale(
          scale: Curves.easeOutBack.transform(anim1.value),
          child: Opacity(opacity: anim1.value, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 120),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🟢 上部タイトル部（固定画像）
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ui/dialog/dialog_header.png'),
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
            child: Text(
              title,
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
            ),
          ),

          // 🟤 ボディ部（伸縮対応 + centerSlice）
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/ui/dialog/dialog_body.png'),
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
                // メッセージ部（複数行でも自動対応）
                Flexible(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF4B4B2F),
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // 🔘 ボタン部（固定配置）
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    onClose?.call();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/ui/button/grey.png',
                        width: 120,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                      Transform.translate(
                        offset: Offset(0, -4),
                        child: const Text(
                          "とじる",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 2,
                                color: Colors.black26,
                                offset: Offset(1, -1),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}