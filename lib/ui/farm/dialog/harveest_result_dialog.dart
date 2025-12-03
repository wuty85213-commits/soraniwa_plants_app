import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/domain/model/harvest_result_model.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/farm/animated/rotatingbackground.dart';
import 'package:myplantapp_ver1/ui/farm/animated/sparkle_field.dart';

class HarvestResultDialog extends StatefulWidget {
  final HarvestResult result;

  const HarvestResultDialog({Key? key, required this.result}) : super(key: key);

  @override
  State<HarvestResultDialog> createState() => _HarvestResultDialogState();
}

class _HarvestResultDialogState extends State<HarvestResultDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _sparkleController;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // ✨ ループで常にキラキラ
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/ui/dialog/item_dialog_v2.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24,32,24,32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l.farm_harvestTitle,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 🌈 キャラ画像 + キラキラ
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Positioned.fill(child: SparkleField()) ,
                    RotatingClippedBackground(
                      imagePath: 'assets/images/ui/bg/sunburst.jpg', // ← あなたの画像
                      scale: 2.5,
                      size: 200,
                      child: Image.asset(
                        widget.result.plant.imageRes[3] ?? 'assets/images/bamboo_1.png',
                        height: 120,
                      ),
                    ),
                    // ✨ キラキラ（ランダムに配置）
                    AnimatedBuilder(
                      animation: _sparkleController,
                      builder: (context, _) {
                        return Stack(
                          children: List.generate(8, (i) {
                            final progress = (_sparkleController.value + i / 8) % 1.0;
                            final angle = 2 * pi * i / 8;
                            final radius = 50 + sin(progress * pi) * 20;
                            final dx = cos(angle) * radius;
                            final dy = sin(angle) * radius;
                            final opacity = (1 - progress).clamp(0.0, 1.0);

                            return Positioned(
                              left: 80 + dx,
                              top: 80 + dy,
                              child: Opacity(
                                opacity: opacity,
                                child: Transform.scale(
                                  scale: 0.5 + progress * 0.8,
                                  child: Icon(
                                    Icons.star_rounded,
                                    size: 12,
                                    color: Colors.yellowAccent.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Text(
                "No.${widget.result.plant.id}　${widget.result.plant.name}",
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Divider(height: 24, thickness: 1),
              Text(l.farm_harvestReward,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //const SizedBox(width: 30),
                  Image.asset('assets/icons/coin.png', height: 24),
                  const SizedBox(width: 8),
                  Text("+${widget.result.coins}"),
                ],
              ),
              const SizedBox(height: 8),

              if (widget.result.seeds > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //SizedBox(width: 30),
                    Image.asset(widget.result.item.imageRes, height: 24),
                    const SizedBox(width: 8),
                    Text("+${widget.result.seeds}"),
                  ],
                ),

              const SizedBox(height: 24),

              CancelButton(onTap: () => Navigator.of(context).pop()),
            ],
          ),
        ),
      ),
    );
  }
}