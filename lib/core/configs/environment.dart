import 'package:flutter/foundation.dart' show debugPrint;

class EnvironmentConfig {
  static EnvironmentConfig? _instance;
  static EnvironmentConfig get instance => _instance ??= EnvironmentConfig._();

  EnvironmentConfig._();

  late final String typicodeApiUrl;
  late final String countryApiUrl;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  void load() {
    if (_isLoaded) return;

    try {
      final Map<String, dynamic> environment = {
        'TYPICODE_API_URL': const String.fromEnvironment(
          'TYPICODE_API_URL',
          defaultValue: '',
        ),
        'COUNTRY_API_URL': const String.fromEnvironment(
          'COUNTRY_API_URL',
          defaultValue: '',
        ),
      };

      _validateEnvironment(environment);

      typicodeApiUrl = environment['TYPICODE_API_URL'];
      countryApiUrl = environment['COUNTRY_API_URL'];

      _isLoaded = true;

      debugPrint('Environment loaded successfully:');
    } catch (e) {
      debugPrint('Error loading environment config:');
      debugPrint(e.toString());
      rethrow;
    }
  }

  void _validateEnvironment(Map<String, dynamic> environment) {
    for (final entry in environment.entries) {
      final key = entry.key;
      final value = entry.value;

      if (key == 'env') continue;

      if (value == null || (value is String && value.isEmpty)) {
        throw Exception('Environment variable [$key] is required.');
      }
    }
  }
}
