// ==== 詳細ダイアログ ====
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/data/entity/plant_master_entity.dart';
import 'package:myplantapp_ver1/domain/model/collected.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';

class CollectedDetailDialog extends StatefulWidget {
  final List<PlantMasterEntity> variants;
  final List<Collected> collectedList;

  const CollectedDetailDialog({
    super.key,
    required this.variants,
    required this.collectedList,
  });

  @override
  State<CollectedDetailDialog> createState() => _CollectedDetailDialogState();
}

class _CollectedDetailDialogState extends State<CollectedDetailDialog> {

  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final List<PlantMasterEntity> _sortedVariants;

  @override
  void initState() {
    super.initState();
    const order = {
      Variant.NORMAL: 0,
      Variant.GOLD: 1,
      Variant.RAINBOW: 2,
    };
    // ✅ variantが定義外のものは除外
    _sortedVariants = widget.variants
        .where((v) => order.containsKey(v.variant)) // ← 不正データ除外
        .toList()
      ..sort((a, b) => order[a.variant]!.compareTo(order[b.variant]!));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    if (_sortedVariants.isEmpty) {
      return const Dialog(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            "There are no plants data.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }
    final current = _sortedVariants[_currentPage];
    final collect = widget.collectedList.firstWhereOrNull((e) => e.variant == current.variant);
    final isCollected = widget.collectedList.any((c) => c.variant == current.variant);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      //insetPadding: const EdgeInsets.all(16),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ==== ヘッダー ====
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_getHeaderImage(current.variant)),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "No.${current.id} ${current.name}（${current.variant.l10n(context)}）",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4B4B2F),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // ✅ IconButtonの見た目を軽く
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF4B4B2F)),
                  splashRadius: 20,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),



          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_getBodyImage(current.variant)),
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // ==== 画像スライダー ====
                  SizedBox(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            itemCount: _sortedVariants.length,
                            onPageChanged: (index) => setState(() => _currentPage = index),
                            itemBuilder: (context, index) {
                              final plant = _sortedVariants[index];


                              return Image.asset( isCollected ?plant.imageRes[3] :"assets/icons/locked_silver.webp", //todo:画像差し替え
                                fit: BoxFit.contain,
                              );
                            },
                          ),

                          // ◀ 左ボタン
                          Positioned(
                            left: 0,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
                              onPressed: () {
                                if (_currentPage > 0) {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                          ),

                          // ▶ 右ボタン
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios, color: Colors.black54),
                              onPressed: () {
                                if (_currentPage < _sortedVariants.length - 1) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      )


                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${_currentPage + 1} / ${_sortedVariants.length}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Divider(),

                  // ==== 説明 ====
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                        widget.collectedList.any((c) => c.variant == current.variant)
                            ?current.description
                            : "???",
                        textAlign: TextAlign.center),
                  ),
                  const Divider(),

                  // ==== ステータス ====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          widget.collectedList.any((c) => c.variant == current.variant)
                              ? '${l.collected_rarity}: ${"★" * current.rarity}'
                              : "???"),
                    ],
                  ),
                  const Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${l.collected_type}: ${current.attribute.l10n(context)}')
                    ],
                  ),

                  const Divider(),

                  // ==== ステータス ====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${l.collected_harvestCount}: ${collect?.harvestCount ?? 0}'),
                    ],
                  ),

                  const Divider(),
                  SizedBox(height: 10),
                  CancelButton(onTap: () => Navigator.pop(context)),
                  SizedBox(height: 15),
                ]
            ),
          )
        ],
      ),
    );
  }
  String _getHeaderImage(Variant variant) {
    switch (variant) {
      case Variant.NORMAL:
        return 'assets/images/collected/header_normal.png';
      case Variant.GOLD:
        return 'assets/images/collected/header_gold.png';
      case Variant.RAINBOW:
        return 'assets/images/collected/header_rainbow.png';
      default:
        return 'assets/images/collected/header_normal.png';
    }
  }
  String _getBodyImage(Variant variant) {
    switch (variant) {
      case Variant.NORMAL:
        return 'assets/images/collected/body_normal.png';
      case Variant.GOLD:
        return 'assets/images/collected/body_gold.png';
      case Variant.RAINBOW:
        return 'assets/images/collected/body_rainbow.png';
      default:
        return 'assets/images/collected/body_normal.png';
    }
  }
}