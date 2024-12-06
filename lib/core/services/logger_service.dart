import 'package:logging/logging.dart';

class LoggerService {
  static final Logger _logger = Logger('EcoTycoon');
  static bool _initialized = false;

  static void init() {
    if (_initialized) return;
    
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      String emoji = _getLogEmoji(record.level);
      print('${record.time}: $emoji ${record.level.name}: ${record.message}');
    });
    
    _initialized = true;
  }

  static String _getLogEmoji(Level level) {
    switch (level) {
      case Level.FINEST:
        return '🔍';
      case Level.FINER:
        return '🔎';
      case Level.FINE:
        return '📝';
      case Level.CONFIG:
        return '⚙️';
      case Level.INFO:
        return '✨';
      case Level.WARNING:
        return '⚠️';
      case Level.SEVERE:
        return '🚨';
      case Level.SHOUT:
        return '📢';
      default:
        return '📋';
    }
  }

  static void finest(String message) => _logger.finest(message);
  static void finer(String message) => _logger.finer(message);
  static void fine(String message) => _logger.fine(message);
  static void config(String message) => _logger.config(message);
  static void info(String message) => _logger.info(message);
  static void warning(String message) => _logger.warning(message);
  static void severe(String message) => _logger.severe(message);
  static void shout(String message) => _logger.shout(message);
}
