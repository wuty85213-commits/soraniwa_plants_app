import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';
import 'package:myplantapp_ver1/domain/model/pot.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/inventory_notifier.dart';
import 'package:myplantapp_ver1/ui/common/user_notifier.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';
import 'package:myplantapp_ver1/usecase/async_combine.dart';

class PotItemGridDialog extends ConsumerWidget {
  final int slotIndex;

  const PotItemGridDialog({
    super.key,
    required this.slotIndex
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final userAsync = ref.watch(userNotifierProvider);
    final inventoryAsync = ref.watch(inventoryNotifierProvider);
    final masterNf = ref.read(masterDataNotifierProvider.notifier);
    final combined = combineAsyncValues2(userAsync,inventoryAsync);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      backgroundColor: Colors.transparent,
      child:combined.when(
        loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('User or Inventoryデータ読込エラー: $e')),
          data: (tuple){
          final userState = tuple.$1;
          final inventorys = tuple.$2;
          final pots = inventorys.where((e) => e.itemType == ItemType.decoration).toList();
          final selectedPot = userState.pots.firstWhere((e) => e.slotIndex == slotIndex,
          orElse: () => Pot(id:"11111tt", slotIndex: slotIndex, itemId: 500));
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 16),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/ui/dialog/item_dialog_v2.png"),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  l.farm_text3,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // 🔥 ここがカードグリッド
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,     // ← 3列グリッド
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1, // カードの縦横比
                    ),
                    itemCount: pots.length,
                    itemBuilder: (context, index) {
                      final pot = pots[index];
                      final master = masterNf.findItemById(pot.itemId);
                      final bool isSelected = selectedPot.itemId == pot.itemId;

                      return Card(
                        color: isSelected
                        ? const Color(0xFFFFF3D8) : Colors.white,
                        elevation: isSelected ? 6 : 3,
                        shadowColor: Colors.brown.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.orange.shade600
                                : const Color(0xFFE0D4B0),
                            width: isSelected ? 3 : 1.2,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {
                            SoundManager.playClick();
                            final userNf = ref.read(userNotifierProvider.notifier);
                            userNf.potSave(slotIndex, pot.itemId);
                            Navigator.pop(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(isSelected)
                                Text(
                                    l.farm_selected,
                                  style: TextStyle(fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,)
                                )
                              else SizedBox(height: 12),
                              const SizedBox(height: 6),
                              if(master != null)
                                Image.asset(master.imageRes , height: 48)
                              else  SizedBox(height: 48)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                CancelButton(
                    onTap: () => Navigator.pop(context,false)
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        }
      )
    );
  }
}