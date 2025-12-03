import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';

@HiveType(typeId: 1)
enum Variant {
  @HiveField(0)
  NORMAL,
  @HiveField(1)
  GOLD,
  @HiveField(2)
  RAINBOW,
  @HiveField(3)
  none,
}

@HiveType(typeId: 2)
enum ItemType {
  @HiveField(0)
  seed,
  @HiveField(1)
  growthBoost,
  @HiveField(2)
  rarerateboostRow,
  @HiveField(3)
  rarerateboostHigh,
  @HiveField(4)
  rarerateboostSuper,
  @HiveField(5)
  decoration,
}

@HiveType(typeId: 3)
enum Attribute {
  @HiveField(0)
  leafy,
  @HiveField(1)
  bloom,
  @HiveField(2)
  tree,
  @HiveField(3)
  fun,
  @HiveField(4)
  odd,
  @HiveField(5)
  none,
}


@HiveType(typeId: 4)
enum PlantCondition {
  @HiveField(0)
  wet,
  @HiveField(1)
  dry,
  @HiveField(2)
  wither,
}

extension VariantLocalize on Variant {
  String l10n(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (this) {
      case Variant.NORMAL:
        return loc.enum_varNOMAL;
      case Variant.GOLD:
        return loc.enum_varGOLD;
      case Variant.RAINBOW:
        return loc.enum_varRAINBOW;
      case Variant.none:
        return loc.enum_varNone;
    }
  }
}

extension AttributeLocalize on Attribute {
  String l10n(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (this) {
      case Attribute.leafy:
        return loc.enum_attrLeafy;
    case Attribute.bloom:
    return loc.enum_attrBloom;
    case Attribute.tree:
    return loc.enum_attrTree;
    case Attribute.fun:
    return loc.enum_attrFun;
    case Attribute.odd:
    return loc.enum_attrOdd;
      case Attribute.none:
    return loc.enum_attrNone;
    }
  }
}

extension ItemTypeLocalize on ItemType {
  String l10n(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (this) {
      case ItemType.seed:
        return loc.enum_ItemTypeSeed;
      case ItemType.growthBoost:
        return loc.enum_ItemTypeGB;
      case ItemType.rarerateboostRow:
        return loc.enum_ItemTypeRBRow;
      case ItemType.rarerateboostHigh:
        return loc.enum_ItemTypeRBHigh;
      case ItemType.rarerateboostSuper:
        return loc.enum_ItemTypeRBSuper;
      case ItemType.decoration:
        return loc.enum_ItemTypeDeco;
    }
  }
}
