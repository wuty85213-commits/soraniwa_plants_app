import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/core/Providers/riverpod.dart';
import 'package:myplantapp_ver1/domain/repository/i_user_repository.dart';
import 'package:myplantapp_ver1/ui/master/master_data_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_notifier.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  late final IUserRepository _repo;

  @override
  Future<Locale> build() async {
    _repo = await ref.read(userRepositoryProvider.future);
    final user = _repo.getUser();
    //final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale; (海外向けリリース時に切り替え)
    //final localeCode = user.languageCade ?? deviceLocale.languageCode ?? 'ja'; // Hiveに保存された言語設定
    final localeCode = user.languageCade ?? 'ja';
    if (user.languageCade == null) {
      final updated = user.copyWith(languageCade: localeCode);
      await _repo.save(updated);
    }
    return Locale(localeCode);
  }

  Future<void> switchLocale(String code) async {
    state = AsyncData(Locale(code));

    final user = _repo.getUser();
    final updated = user.copyWith(languageCade:code);
    await _repo.save(updated);

    // ③ 🌍 MasterDataNotifierに通知
    // 言語切り替え時にマスターを再読み込みさせる
    final masterNotifier = ref.read(masterDataNotifierProvider.notifier);
    await masterNotifier.reload(localeCode: code);
  }
}