import 'package:logger/logger.dart';

class SharedPrefsLogger {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
    ),
  );

  void logWrite(String key, [dynamic value]) {
    logger.i('''
      📝📝📝📝📝📝 SHARED PREFS WRITE SUCCESS📝📝
      Operation: Write
      Key: $key
      Value: ${_formatValue(value)}
      Timestamp: ${DateTime.now()}
    ''');
  }

  void logRead(String key, dynamic value) {
    logger.d('''
      🔍🔍🔍🔍🔍🔍 SHARED PREFS READ🔍🔍🔍🔍
      Operation: Read
      Key: $key
      Value: ${_formatValue(value)}
      Timestamp: ${DateTime.now()}
    ''');
  }


  void logDelete(String key) {
    logger.w('''
      🗑️🗑️🗑️🗑️🗑️🗑️ SHARED PREFS DELETE🗑️🗑️🗑️🗑️
      Operation: Delete
      Key: $key
      Timestamp: ${DateTime.now()}
    ''');
  }

  void logCheckResult(String operation, dynamic result) {
    logger.d('''
      ✅ ✅ ✅ ✅ ✅ SHARED PREFS CHECK RESULT✅ ✅ ✅ 
      Operation: $operation
      Result: ${_formatValue(result)}
      Timestamp: ${DateTime.now()}
    ''');
  }

  void logBatchOperation(String operation, List<String> keys,
      [List<dynamic>? values]) {
    final valueStr = values != null
        ? '\nValues: ${keys.asMap().entries.map((e) => "${e.key}: ${_formatValue(values.length > e.key ? values[e.key] : null)}").join(', ')}'
        : '';

    logger.i('''
      🔄🔄🔄🔄🔄🔄🔄 SHARED PREFS BATCH SUCCESS🔄🔄🔄🔄🔄🔄
      Operation: $operation
      Keys: ${keys.join(', ')}$valueStr
      Timestamp: ${DateTime.now()}
    ''');
  }

  void logError(String operation, String key, dynamic error) {
    logger.e('''
      ❌❌❌❌❌❌❌ SHARED PREFS ERROR❌❌❌❌❌❌
      Operation: $operation
      Key: $key
      Error: $error
      Timestamp: ${DateTime.now()}
    ''');
  }

  void logBatchError(String operation, List<String> keys, dynamic error) {
    logger.e('''
      ❌❌❌❌❌❌❌ SHARED PREFS BATCH ERROR❌❌❌❌
      Operation: $operation
      Keys: ${keys.join(', ')}
      Error: $error
      Timestamp: ${DateTime.now()}
    ''');
  }

  // Helper method to format values, especially handling sensitive data
  String _formatValue(dynamic value) {
    if (value == null) {
      return 'null';
    }

    // Check if this looks like a token or sensitive data
    if (value is String) {
      if (_isSensitiveKey(value) || value.length > 20) {        
        if (value.length > 10) { // Show first and last few characters with mask in between
          return '${value.substring(0, 4)}...${value.substring(value.length - 4)}';
        } else {
          return '[DATA]';
        }
      }
    }

    if (value is List) {
      if (value.isEmpty) {
        return '[]';
      }
      return '[${value.length} items]';
    }

    if (value is Map) {
      if (value.isEmpty) {
        return '{}';
      }
      return '{${value.length} key-value pairs}';
    }

    return value.toString();
  }

  // Helper method to identify potentially sensitive keys
  bool _isSensitiveKey(String value) {
    final sensitivePatterns = [
      'token',
      'password',
      'secret',
      'key',
      'auth',
      'credential',
      'jwt',
    ];

    return sensitivePatterns
        .any((pattern) => value.toLowerCase().contains(pattern));
  }
}
