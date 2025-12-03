import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myplantapp_ver1/core/ad/ad.dart';
import 'package:myplantapp_ver1/core/debug_data_injector/debug_data_injector.dart';
import 'package:myplantapp_ver1/core/hive/hive_adapters.dart';
import 'package:myplantapp_ver1/core/language/locale_notifier.dart';
import 'package:myplantapp_ver1/core/Providers/riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplantapp_ver1/ui/home/home_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //tz.initializeTimeZones();
  //tz.setLocalLocation(tz.getLocation("Asia/Tokyo"));
  await MobileAds.instance.initialize();
  loadRewardedAd();
  // ✅ Hive初期化
  await Hive.initFlutter();
  // ✅ Hiveアダプタ登録
  registerAllHiveAdapters();
  // ✅ Riverpod有効化

  final container = ProviderContainer();
  await container.read(hiveInitProvider.future);
  //await container.read(debugDataInjectorProvider.notifier).injectIfNeeded();

  await AudioPlayer.global.setAudioContext(
    AudioContextConfig(
      focus: AudioContextConfigFocus.mixWithOthers, // ← これ！！
      // 必要なら
    ).build(),
  );

  runApp(
    UncontrolledProviderScope(
      container: container, // 同じコンテナをアプリ全体で使う
      child: const MyApp(),
    ),
  );
}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hiveReady = ref.watch(hiveInitProvider);
    final localeAsync = ref.watch(localeNotifierProvider);

    return hiveReady.when(
      loading: () => const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (e, _) => MaterialApp(
        home: Scaffold(body: Center(child: Text('Hive init error: $e'))),
      ),
      data: (_) {
        // ✅ Hiveが開けた後にLocaleProviderを監視してApp構築
        return localeAsync.when(
          loading: () => const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          ),
          error: (e, _) => MaterialApp(
            home: Scaffold(body: Center(child: Text('Locale error: $e'))),
          ),
          data: (locale) {
            return MaterialApp(
              title: 'Farm App',
              debugShowCheckedModeBanner: false,
              locale: locale,
              supportedLocales: const [
                Locale('ja'),
                Locale('en'),
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: ThemeData.light(),
              home: const HomeScreen(),
            );
          },
        );
      },
    );
  }
}

class _AppLoaded extends StatelessWidget {
  const _AppLoaded();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveBoxManager.init();

  final app = AppInitializer.instance;
  await app.initialize();

  // --- 確認用ログ ---

  // ✅ Debugデータ注入 (Env.isDev時のみ)
  await DebugDataInjector.injectIfNeeded(
    masterCache: app.masterDataCache,
    userRepo: app.userRepository,
    userPlantRepo: app.userPlantRepository,
    inventoryRepo: app.inventoryRepository,
  );

  runApp(MyApp(app));
}

class MyApp extends StatelessWidget {
  final AppInitializer app;
  const MyApp(this.app, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IUserRepository>(create: (_) => app.userRepository),
        Provider<IUserPlantRepository>(create: (_) => app.userPlantRepository),
        Provider<IInventoryRepository>(create: (_) => app.inventoryRepository),
        Provider<ICollectedRepository>(create: (_) => app.collectedRepository),
        Provider<MasterDataCache>(create: (_) => app.masterDataCache),
        Provider<FarmService>(create: (_) => app.farmService),
        Provider<StoreService>(create: (_) => app.storeService),
        Provider<AchievementService>(create: (_) => app.achievementService),


        ChangeNotifierProvider<FarmViewModel>(create: (_) => app.farmViewModel),
        ChangeNotifierProvider<StoreViewModel>(create: (_) => app.storeViewModel),
        ChangeNotifierProvider<CollectedViewModel>(create: (_) => app.collectedViewModel),
        ChangeNotifierProvider<AchievementViewModel>(create: (_) => app.achievementViewModel),

      ],
      child: const MaterialApp(
        title: 'Farm App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen()
      ),
    );
  }
}

 */