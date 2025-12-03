import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const MenuButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final btnWidth = width * 0.4;   // 画面の 70%
    final btnHeight = btnWidth * 0.30; // 画像の縦横比に合わせる
    return GestureDetector(
      onTap: (){
        SoundManager.playClick();
        onTap();},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/ui/button/brown.png',
            height: btnHeight,
            width: btnWidth,
            fit: BoxFit.contain,
          ),
          Transform.translate(
            offset: const Offset(0, -0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: btnWidth * 0.12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 3,
                    color: Colors.black26,
                    offset: Offset(1, -1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}