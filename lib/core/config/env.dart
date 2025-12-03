enum AppEnvironment { development, production }

class EnvConfig {
  static const flavor =
  String.fromEnvironment('FLAVOR', defaultValue: 'development');

  static AppEnvironment get current =>
      flavor == 'production'
          ? AppEnvironment.production
          : AppEnvironment.development;

  static bool get isDev => current == AppEnvironment.development;
  static bool get isProd => current == AppEnvironment.production;

  /// Hiveディレクトリ
  static String get hiveDir => isDev ? "hive_dev" : "hive_prod";
}