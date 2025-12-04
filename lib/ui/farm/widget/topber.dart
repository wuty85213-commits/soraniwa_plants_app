import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/farm/dialog/item_grid_dialog_fullscreen.dart';
import 'package:myplantapp_ver1/ui/farm/dialog/pot_setting_dialog.dart';

Widget buildTopBar(BuildContext context){
  final l = AppLocalizations.of(context)!;
  return
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/common/appbar_vine.png'),
          fit: BoxFit.cover, // ← 画像を全体にフィットさせる
        ),
        //color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            l.garden,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // ≡ メニューボタン（右寄せ）
          Align(
            alignment: Alignment.centerRight,
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.black87),
              onSelected: (value) {
                switch (value) {
                  case 'items':
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: '',
                      barrierColor: Colors.black54,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (_, __, ___) {
                        return const ItemGridDialogFullScreen();
                      },
                    );
                    break;
                  case 'settings':
                    showDialog(
                        context: context,
                        builder: (_) => PotSettingDialog()
                    );
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'items',
                  child: Text(l.item),
                ),
                PopupMenuItem(
                  value: 'settings',
                  child: Text(l.pots),
                ),
              ],
            ),
          ),
        ],
      )
    );
}