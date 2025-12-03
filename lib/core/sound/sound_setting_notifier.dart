import 'package:myplantapp_ver1/core/Providers/riverpod.dart';
import 'package:myplantapp_ver1/core/sound/sound_manager.dart';
import 'package:myplantapp_ver1/domain/repository/i_user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'sound_setting_notifier.g.dart';

@riverpod
class SoundSettingNotifier extends _$SoundSettingNotifier {
  late final IUserRepository _repo;
  @override
  Future<(bool, bool)> build() async {

    _repo = await ref.read(userRepositoryProvider.future);
    final user = _repo.getUser();
    return (user.isBgmOn, user.isSeOn); // 初期値（Hiveから読み込み）
  }

  Future<void> toggleBgm() async {
    final value = state.value ?? (true, true);
    final newBgm = !value.$1;
    state = AsyncData((newBgm, value.$2));
    await _save((newBgm, value.$2));
    SoundManager.setBgmEnabled(newBgm);
  }

  Future<void> toggleSe() async {
    final value = state.value ?? (true, true);
    final newSe = !value.$2;
    state = AsyncData((value.$1, newSe));
    await _save((value.$1, newSe));
    SoundManager.setSeEnabled(newSe);
  }

  Future<void> _save((bool, bool) newState) async {
    final user = _repo.getUser();
    final updated = user.copyWith(
      isBgmOn: newState.$1,
      isSeOn: newState.$2,
    );
    await _repo.save(updated);
  }
}