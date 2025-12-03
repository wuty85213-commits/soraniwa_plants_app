import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/core/config/enums.dart';
import 'package:myplantapp_ver1/domain/model/collected.dart';
import 'package:myplantapp_ver1/domain/repository/i_collected_repository.dart';
import 'package:myplantapp_ver1/service/master_data_cache.dart';
import 'package:myplantapp_ver1/ui/collected/collected_state.dart';

class CollectedViewModel extends StateNotifier<CollectedState>{
  final ICollectedRepository _collectedRepo;
  final MasterDataCache _masterDataCache;
  late final StreamSubscription _subscription;

  CollectedViewModel(this._collectedRepo, this._masterDataCache)
      : super (const CollectedState()) {_listenToHive();}

  Future<void> _listenToHive() async {
    state = state.copyWith(isLoading: true);

    _subscription = _collectedRepo.watchAll().listen(
          (collected) {
        final plants = _masterDataCache.plants;
        final items = _masterDataCache.items;

        final normalPlants = plants
            .where((c) => c.variant == Variant.NORMAL)
            .toList();

        state = state.copyWith(
          collected: collected,
          plants: plants,
          normalPlants: normalPlants,
          items: items,
          isLoading: false,
        );
      },
      onError: (err) {
        state = state.copyWith(
          errorMessage: err.toString(),
          isLoading: false,
        );
      },
    );

    try {
      final collected = _collectedRepo.getAll();
      final plants = _masterDataCache.plants;
      final items = _masterDataCache.items;

      final _normalPlantsUi = plants.where(
              (c) => c.variant == Variant.NORMAL).toList();

      state = state.copyWith(
        collected: collected,
        normalPlants: _normalPlantsUi,
        plants: plants,
        items: items,
        isLoading: false,
      );

    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      );
    }
  }

  String getcompleteImage(List<Collected> collectedList) {
    if(collectedList.any((c) => c.variant == "GOLD")){
      if(collectedList.any((c) => c.variant == "RAINBOW")){
        return "assets/ui/collected/goldrainbow_crown.png";
      } else { return "assets/ui/collected/gold_crown.png";}
    } else if (collectedList.any((c) => c.variant == "RAINBOW")){
      return "assets/ui/collected/rainbow_crown.png";
    } else {
      return "";
    }
  }

  bool isCollected(int plantId) =>
      state.collected.where(
              (i) => i.plantId == plantId).isNotEmpty;

  bool isCollectedVariant(int plantId, Variant variant) =>
      state.collected.where(
              (i) => i.plantId == plantId && i.variant == variant).isNotEmpty;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}