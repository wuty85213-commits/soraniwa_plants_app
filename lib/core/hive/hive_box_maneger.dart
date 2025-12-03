import 'package:hive_flutter/hive_flutter.dart';
import 'package:myplantapp_ver1/core/app_logger.dart';
import 'package:myplantapp_ver1/core/config/env.dart';

class HiveBoxManager {
  static final List<String> _openedBoxes = [];
  static final log = AppLogger.tag('HiveBoxManager⚙️');

  static Future<void> init() async {
    await Hive.initFlutter(EnvConfig.hiveDir);
    log.i('📦 Hive initialized → dir: ${EnvConfig.hiveDir}, flavor: ${EnvConfig.flavor}');
  }

  static Future<Box<T>> openBox<T>(String name) async {
    final boxName = '${name}_${EnvConfig.flavor}';

    // すでに開いてるなら openBox() せず直接返す
    if (Hive.isBoxOpen(boxName)) {
      log.i('📂 Box already open → $boxName');
      return Hive.box<T>(boxName);
    }

    log.i('📂 Opening box → $boxName');
    final box = await Hive.openBox<T>(boxName);

    if (!_openedBoxes.contains(boxName)) {
      _openedBoxes.add(boxName);
    }
    log.i('✅ Box opened → $boxName (openedBoxes: $_openedBoxes)');
    return box;
  }

  static Future<void> resetAll() async{
    const boxNames = [
      'userBox_${EnvConfig.flavor}',
      'potBox_${EnvConfig.flavor}',
      'userPlantBox_${EnvConfig.flavor}',
      'inventoryBox_${EnvConfig.flavor}',
      'collectedBox_${EnvConfig.flavor}',
      'plantMasterBox_${EnvConfig.flavor}',
      'itemMasterBox_${EnvConfig.flavor}',
      'rewardBox_${EnvConfig.flavor}',
    ];

    for (final name in boxNames) {
      if (await Hive.boxExists(name)) {
        // 既に開いている場合は一度閉じる
        if (Hive.isBoxOpen(name)) {
          await Hive.box(name).close();
        }
        await Hive.deleteBoxFromDisk(name);
        log.w('🗑️ Deleted old Hive box: $name');
      }
    }
  }

  static Future<void> clearAll() async {
    log.w('⚠️ Clearing ALL hive boxes...');
    for (final boxName in _openedBoxes) {
      if (Hive.isBoxOpen(boxName)) {
        log.i('📦 Reopened box → $boxName');
        await Hive.box(boxName).clear();
      }
    }
    log.w('✅ All boxes cleared');
  }

  static Future<void> closeAll() async {
    log.i('📦 Closing ALL hive boxes...');
    for (final boxName in _openedBoxes) {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).close();
        log.i('🔒 Closed box → $boxName');
      }
    }
    log.i('✅ All boxes closed');
  }
}
