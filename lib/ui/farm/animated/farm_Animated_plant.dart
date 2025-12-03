import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';
import 'package:myplantapp_ver1/domain/model/user_plant.dart';
import 'package:myplantapp_ver1/ui/farm/animated/floating_particle.dart';
import 'package:myplantapp_ver1/ui/farm/animated/plant_gauge.dart';
import 'package:myplantapp_ver1/ui/farm/animated/water_drop.dart';
import 'package:myplantapp_ver1/ui/farm/farm_notifier.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';

class AnimatedPlant extends ConsumerStatefulWidget {
  final int slotIndex;
  final VoidCallback onAnimationEnd;

  const AnimatedPlant({
    super.key,
    required this.slotIndex,
    required this.onAnimationEnd,
  });

  @override
  AnimatedPlantState createState() => AnimatedPlantState();
}

class AnimatedPlantState extends ConsumerState<AnimatedPlant>
    with TickerProviderStateMixin {

  late AnimationController _harvestController;
  late AnimationController _waterController;
  late AnimationController _removeController;
  bool _showWaterDrops = false;
  bool _showParticles = false;

  late Animation<double> _scale;
  late Animation<double> _opacity;
  late Animation<double> _opacity_remove;
  late Animation<double> _growY; // 水やりアニメーションの縦伸縮


  @override
  void initState() {
    super.initState();

    // 🍎 収穫アニメーション
    _harvestController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 0.0), weight: 2),
    ]).animate(CurvedAnimation(
      parent: _harvestController,
      curve: SafeCurve(Curves.easeInOutBack),
    ));

    _opacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _harvestController, curve: SafeCurve(Curves.easeOut)),
    );

    // 💧 水やりアニメーション
    _waterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _growY = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _waterController,
      curve: SafeCurve(Curves.easeInOutBack),
    ));

    _removeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacity_remove = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _removeController, curve: SafeCurve(Curves.easeOut)),
    );


    // ✅ デバッグ出力
    _removeController.addListener(() {
      // 値が変化したら毎フレーム出力
      debugPrint("💧 growY: ${_opacity_remove.value.toStringAsFixed(3)}");
    });
  }

  @override
  void dispose() {
    _harvestController.dispose();
    _waterController.dispose();
    _removeController.dispose();
    super.dispose();
  }

  /// 🍎 収穫アニメーション
  Future<void> playHarvestAnimation() async {
    debugPrint("🍎 playHarvestAnimation start");
    setState(() => _showParticles = true);
    await _harvestController.forward(from: 0);
    await Future.delayed(const Duration(seconds: 1));
    _harvestController.reset();
    setState(() => _showParticles = false);
    widget.onAnimationEnd();
  }

  /// 💧 水やりアニメーション
  Future<void> playWaterAnimation() async {
    debugPrint("💧 playWaterAnimation called");
    SoundManager.playWaterOnce();
    if (!_waterController.isAnimating) {
      setState(() => _showWaterDrops = true);
      await _waterController.forward(from: 0);
      await _waterController.forward(from: 0);
      await Future.delayed(const Duration(seconds: 1));
      setState(() => _showWaterDrops = false);
    }
  }

  ///撤去アニメーション
  Future<void> playRemoveAnimation() async {
    debugPrint("🍎 playRemoveAnimation start");
    await _removeController.forward(from: 0);
    await Future.delayed(const Duration(seconds: 1));
    _removeController.reset();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("FarmAnimatedPlant build (slot${widget.slotIndex})");
    final farmAsync = ref.watch(farmNotifierProvider);

    return farmAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Farm reading error: $e')),
      data: (farm){
        final msNf = ref.read(masterDataNotifierProvider.notifier);
        final plant = farm.userPlants.firstWhereOrNull(
                (p) => p.slotIndex == widget.slotIndex);
        final ms = msNf.findPlant(plant?.plantId ?? 1, plant?.variant ?? Variant.NORMAL);
        final imagePath = ms?.imageRes[plant?.stage ?? 0] ?? "assets/images/plants/st0.webp";
        return LayoutBuilder(
          builder: (context, constraints){
            return AnimatedBuilder(
              animation: Listenable.merge([_harvestController, _waterController,_removeController]),
              builder: (context, child) {
                final animeWidth = (constraints.maxWidth / 3).floor();

                // 収穫時のスケールとフェード
                print('SizedBox.expand constraints: ${constraints.maxWidth} x ${constraints.maxHeight}');
                debugPrint(
                    "opacity = ${_opacity.value.toStringAsFixed(2)} , "
                        "remove = ${_opacity_remove.value.toStringAsFixed(2)}"
                );
                return SizedBox.expand(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // 🌿 植物本体
                        Opacity(
                          opacity: _opacity.value * _opacity_remove.value,
                          child:
                          Transform(
                            alignment: Alignment.bottomCenter,
                            transform: Matrix4.identity()
                              ..scaleByDouble(
                                1.0, // 横幅は固定
                                _growY.value * _scale.value, // 縦方向にだけ伸縮
                                1.0,
                                1.0,
                              ),
                            child: Image.asset(
                              imagePath,
                              width: constraints.maxWidth * 0.8 ,
                              height: constraints.maxHeight * 0.8,
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                        ),

                        if (_showWaterDrops) ...List.generate(3, (i) {
                          final random = Random();
                          return Positioned(
                            top: 0,
                            left: animeWidth + random.nextInt(animeWidth).toDouble(),
                            child: WaterDrop(delay: i * 200),
                          );
                        }),

                        /*
                        // 💧 水滴アニメーション
                        if (_showWaterDrops) ...List.generate(3, (i) {
                          final random = Random();
                          return Positioned(
                            top: 0,
                            left: 60 + random.nextInt(40).toDouble(),
                            child: WaterDrop(delay: i * 200),
                          );
                        }),

                         */

                        // 🌈 収穫時の粒子アニメーション
                        if (_showParticles)
                          ...List.generate(10, (i) {
                            final random = Random();
                            return Positioned(
                              bottom: 0,
                              left: animeWidth + random.nextInt(animeWidth).toDouble(),
                              child: FloatingParticle(
                                delay: i * 100,
                                color: Colors.yellowAccent.withOpacity(0.8),
                              ),
                            );
                          }),

                        Positioned(
                            top: 0,
                            child: Builder(
                                builder: (context) {
                                  final progress = plant?.progress ?? 0.0;
                                  final isDone = progress >= 1.0;
                                  final condition = plant?.plantCondition ?? PlantCondition.dry;

                                  // 💧 水滴アイコンの切替
                                  String waterIcon;
                                  switch (condition) {
                                    case PlantCondition.wet:
                                      waterIcon = 'assets/icons/drop.webp'; // 通常青アイコン
                                      break;
                                    case PlantCondition.dry || PlantCondition.wither:
                                      waterIcon = 'assets/icons/drop_grey.webp'; // 灰色アイコン
                                      break;
                                    default:
                                      waterIcon = 'assets/icons/drop.webp';
                                  }

                                  // 枯れた場合は灰色バーを表示
                                  if (condition == PlantCondition.wither) {
                                    return Opacity(
                                      opacity: 0.7,
                                      child: Image.asset(
                                        'assets/images/ui/gauge/body_green.png', // ← 枯れ専用ゲージがあればこちらに
                                        width: 80,
                                        height: 16,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  }

                                  // 🌱 通常ゲージ
                                  return
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8), // 半透明の白背景
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.black26, // 薄い影のような縁
                                            width: 0.6,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 3,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child:
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // 💧 水滴アイコン
                                            Image.asset(
                                              waterIcon,
                                              width: 20,
                                              height: 20,
                                            ),

                                            // 🌿 成長ゲージ
                                            PlantGauge(
                                              progress: progress,
                                              width: 80,
                                              height: 12,
                                            ),
                                          ],
                                        )
                                    );
                                }
                            )
                        ),
                      ],
                    )
                );
              },
            );
          }
          );
        }
    );
  }
}


class SafeCurve extends Curve {
  final Curve inner;
  const SafeCurve(this.inner);

  @override
  double transform(double t) {
    final v = inner.transform(t);
    return v.clamp(0.0, 1.0); // 👈 強制クランプ！
  }
}