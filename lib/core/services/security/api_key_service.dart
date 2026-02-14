import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class APIKeyService {
  final _storage = const FlutterSecureStorage();
  static const String _keyPrefix = 'api_key_';

  /// Save API Key for a specific provider
  Future<void> saveKey(String providerId, String key) async {
    await _storage.write(key: '$_keyPrefix$providerId', value: key);
  }

  /// Get API Key for a specific provider
  Future<String?> getKey(String providerId) async {
    return await _storage.read(key: '$_keyPrefix$providerId');
  }

  /// Remove API Key for a specific provider
  Future<void> removeKey(String providerId) async {
    await _storage.delete(key: '$_keyPrefix$providerId');
  }

  /// Check if provider has a configured key
  Future<bool> isConfigured(String providerId) async {
    final key = await getKey(providerId);
    return key != null && key.isNotEmpty;
  }

  /// Get all configured provider IDs
  Future<List<String>> getConfiguredProviders() async {
    final all = await _storage.readAll();
    return all.keys
        .where((k) => k.startsWith(_keyPrefix))
        .map((k) => k.replaceFirst(_keyPrefix, ''))
        .toList();
  }
}
