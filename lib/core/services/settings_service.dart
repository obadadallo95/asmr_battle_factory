// Lines: 85/300
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class SettingsService {
  static const String _boxName = 'settings_box';
  static const String _themeKey = 'theme_mode';
  static const String _localeKey = 'locale';
  
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  late Box _box;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    // Hive.initFlutter() is called in main.dart
    _box = await Hive.openBox(_boxName);
  }

  // --- Theme ---
  String get themeMode => _box.get(_themeKey, defaultValue: 'dark');
  Future<void> setThemeMode(String mode) => _box.put(_themeKey, mode);

  // --- Locale ---
  String get locale => _box.get(_localeKey, defaultValue: 'ar');
  Future<void> setLocale(String languageCode) => _box.put(_localeKey, languageCode);

  // --- API Keys (Secure) ---
  // --- API Keys (Using Hive for stability on all devices) ---
  Future<void> saveApiKey(String provider, String key) async {
    // Storing in Hive instead of SecureStorage to avoid Keychain/Keystore issues on some emulators/devices
    await _box.put('api_key_$provider', key);
  }

  Future<String?> getApiKey(String provider) async {
    return _box.get('api_key_$provider');
  }

  // --- Onboarding ---
  bool get hasSeenOnboarding => _box.get('hasSeenOnboarding', defaultValue: false);
  Future<void> setHasSeenOnboarding(bool value) => _box.put('hasSeenOnboarding', value);

  Future<void> clearCache() async {
    await _box.clear();
    await _secureStorage.deleteAll();
  }
}
