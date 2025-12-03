import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';

class GlossyRedBuyButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const GlossyRedBuyButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        SoundManager.playClick();
        onPressed();},
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          // 下地グラデーション（赤の光沢）
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF5F5F), // 明るい赤
              Color(0xFFD50000), // 濃い赤
            ],
          ),
          borderRadius: BorderRadius.circular(12),

          // ✅ 外枠の追加（内側の赤と馴染むトーン）
          border: Border.all(
            width: 2,
            color: Colors.redAccent.shade100, // 光を反射するような淡い赤
          ),

          // 下の影（立体感）
          boxShadow: [
            BoxShadow(
              color: Colors.red.shade900.withOpacity(0.5),
              offset: const Offset(0, 5),
              blurRadius: 8,
            ),
          ],
        ),
        child: Stack(
          children: [
            // 💫 上部のハイライト層（光沢表現）
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 22,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.6),
                      Colors.white.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
            // 🌹 中央のテキストとアイコン
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlossyBuyButton extends StatelessWidget {
  final String text;
  final Color topColor;
  final Color buttomColor;
  final VoidCallback onPressed;

  const GlossyBuyButton({
    required this.text,
    required this.topColor,
    required this.buttomColor,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        SoundManager.playClick();
        onPressed();},
      child: Container(
        width: 70,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              topColor, // 明るい赤（上の光）
              buttomColor, // 濃い赤（下の影）
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.shade900.withOpacity(0.4),
              offset: const Offset(0, 3),
              blurRadius: 5,
            ),
          ],
        ),
        child: Stack(
          children: [
            // 光沢ハイライト
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 16,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.6),
                      Colors.white.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
            // テキスト中央
            Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  shadows: [
                    Shadow(offset: Offset(0, 1), blurRadius: 2, color: Colors.black26),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}