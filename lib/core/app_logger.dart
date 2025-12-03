import 'package:logger/logger.dart';
import 'package:myplantapp_ver1/core/config/env.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printTime: true,
    ),
  );

  final String? _tag;
  const AppLogger([this._tag]);

  static AppLogger tag(String tag) => AppLogger(tag);

  bool get _kDebugMode => EnvConfig.isDev;

  void d(dynamic message) {
    if (_kDebugMode) _logger.d(_format(message));
  }

  void i(dynamic message) {
    if (_kDebugMode) _logger.i(_format(message));
  }

  void w(dynamic message) {
    if (_kDebugMode) _logger.w(_format(message));
  }

  void e(dynamic message, [dynamic error, StackTrace? st]) {
    if (!_kDebugMode) return;

    if (error != null || st != null) {
      _logger.e('$message\nError: $error\nStackTrace: $st');
    } else {
      _logger.e(message);
    }
  }
  String _format(dynamic message) {
    return _tag != null ? "[$_tag] $message" : message.toString();
  }
}