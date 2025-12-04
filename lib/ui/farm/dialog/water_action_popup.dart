import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';

class WaterActionPopup extends StatefulWidget {
  final Offset position;
  final int growthStage;
  final PlantCondition plantCondition;
  final VoidCallback onWater;
  final VoidCallback onRemove;
  final VoidCallback onHarvest;

  const WaterActionPopup({
    super.key,
    required this.position,
    required this.growthStage,
    required this.plantCondition,
    required this.onWater,
    required this.onRemove,
    required this.onHarvest,
  });

  @override
  State<WaterActionPopup> createState() => _WaterActionPopupState();
}

class _WaterActionPopupState extends State<WaterActionPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isWaterDisabled = widget.plantCondition == PlantCondition.wet ||
        widget.plantCondition == PlantCondition.wither ||
        widget.growthStage == 3;

    return Positioned(
      left: widget.position.dx + 20,
      top: widget.position.dy - 60, // 🌿 少し上に調整
      child: Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // 🪴 背景カード画像（吹き出し）
            Image.asset(
              "assets/images/collected/card_cream.png",
              width: 148,
              fit: BoxFit.contain,
            ),

            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 💧 水やりボタン
                    GestureDetector(
                      onTap: isWaterDisabled ? null
                          : (){
                        SoundManager.playClick();
                        widget.onWater();
                        },
                      child: Container(
                        width: 112,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          // 🌑 外側の黒いドロップシャドウ
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2,       // ← ぼかしの強さ（大きいほど柔らかい影）
                              offset: const Offset(0, 4), // ← 影の位置（x方向, y方向）
                            ),
                          ],
                        ),

                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              isWaterDisabled
                                  ? 'assets/images/common/bt_grey.png'
                                  : 'assets/images/common/bt_lightblue.png',
                              width: 112,
                              height: 32,
                              fit: BoxFit.fill,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.water_drop,
                                  size: 18,
                                  color: isWaterDisabled
                                      ? Colors.white
                                      : Colors.white,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  l.farm_water,
                                  style: TextStyle(
                                    color: isWaterDisabled
                                        ? Colors.white
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                    const SizedBox(height: 10),

                    // 🍎 収穫ボタン（オレンジ系）
                    GestureDetector(
                      onTap: widget.growthStage == 3
                          ? (){
                        SoundManager.playClick();
                        widget.onHarvest();}
                          : null,
                      child: Container(
                        width: 112,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          // 🌑 外側の黒いドロップシャドウ
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2,       // ← ぼかしの強さ（大きいほど柔らかい影）
                              offset: const Offset(0, 4), // ← 影の位置（x方向, y方向）
                            ),
                          ],
                        ),
                        child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                widget.growthStage == 3
                                    ? 'assets/images/common/bt_red.png'
                                    : 'assets/images/common/bt_grey.png',
                                width: 112,
                                height: 32,
                                fit: BoxFit.fill,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.grass, size: 18, color: Colors.white),
                                  const SizedBox(width: 6),
                                  Text(
                                    l.farm_harvest,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ]
                        ),
                      )
                    ),
                    const SizedBox(height: 10),

                    // 🗑 撤去ボタン（赤系ボタン）
                    GestureDetector(
                      onTap: (){
                        SoundManager.playClick();
                        widget.onRemove();
                      },
                      child: Container(
                        width: 112,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          // 🌑 外側の黒いドロップシャドウ
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2,       // ← ぼかしの強さ（大きいほど柔らかい影）
                              offset: const Offset(0, 4), // ← 影の位置（x方向, y方向）
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/images/common/bt_brown.png',
                              width: 112,
                              height: 32,
                              fit: BoxFit.fill,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.delete, size: 16, color: Colors.white),
                                SizedBox(width: 6),
                                Text(
                                  l.farm_remove,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),

            // ⬇ 吹き出しの三角形
            Positioned(
              bottom: -6,
              left: 70,
              child: Transform.rotate(
                angle: 3.14 / 4,
                child: Container(
                  width: 12,
                  height: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}