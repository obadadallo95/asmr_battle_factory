// Lines: 25/300
import 'package:logger/logger.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppLogger {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  void d(String message) => _logger.d('🐛 $message');
  void i(String message) => _logger.i('ℹ️ $message');
  void w(String message) => _logger.w('⚠️ $message');
  void e(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e('❌ $message', error: error, stackTrace: stackTrace);
}

/// Static wrapper for AppLogger for convenience
class AppLog {
  static final AppLogger _logger = AppLogger();

  static void debug(String message) => _logger.d(message);
  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);
  static void error(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);
}
