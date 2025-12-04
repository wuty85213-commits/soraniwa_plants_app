import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/achievememt/achievement_notifier.dart';

class AchievementFilterSheet extends ConsumerWidget {
  const AchievementFilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final notifier = ref.read(achievementNotifierProvider.notifier);
    final state = ref.watch(achievementNotifierProvider).value!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l.filter,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          CheckboxListTile(
            title: Text(l.ach_locked),
            value: state.showLocked,
            activeColor: Colors.black,      // ← 塗りつぶし色を変える
            checkColor: Colors.white,
            onChanged: (v) => notifier.toggleShowLocked(v!),
          ),

          CheckboxListTile(
            title: Text(l.ach_unlocked),
            value: state.showUnlocked,
            activeColor: Colors.black,      // ← 塗りつぶし色を変える
            checkColor: Colors.white,
            onChanged: (v) => notifier.toggleShowUnlocked(v!),
          ),

          CheckboxListTile(
            title: Text(l.ach_received),
            value: state.showReceived,
            activeColor: Colors.black,      // ← 塗りつぶし色を変える
            checkColor: Colors.white,
            onChanged: (v) => notifier.toggleShowshowReceived(v!),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}