import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/dialog/simple_inform_dialog.dart';
import 'package:myplantapp_ver1/ui/common/user_notifier.dart';
import 'package:myplantapp_ver1/ui/farm/dialog/slot_unlock_dialog.dart';

class LockedSlot extends ConsumerWidget {
  const LockedSlot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final nf = ref.read(userNotifierProvider.notifier);

    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = constraints.maxHeight * 0.3; // 高さの3/10

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // 背景となるロックコンテナ
            // 🔽 画像（ボトムセンター固定）
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async{
                  final potPrice = await nf.slotPrice();
                  final decision = await showDialog<bool>(
                      context: context,
                      builder: (_) => SlotUnlockDialog(potPrice: potPrice)
                  );
                  if(decision == true) {
                    final success = await nf.plantUnlock();
                    if(success){
                      //成功ダイアログ
                      showDialog(
                          context: context,
                          builder: (_) =>
                              SimpleInfoDialog(title: l.success,message: l.farm_text2,)
                      );
                    } else {
                      //失敗ダイアログ
                      showDialog(
                          context: context,
                          builder: (_) =>
                              SimpleInfoDialog(title: l.error,message: l.farm_text1,)
                      );
                    }
                  }
                },
                child: Image.asset(
                  'assets/images/items/pot_grey.webp', // ← 任意の画像パス
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}