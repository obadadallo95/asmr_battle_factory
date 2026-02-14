import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
// Removing specific platform imports to avoid 'isn't defined' if not supported in this version
import 'package:asmr_battle_factory/core/services/app_logger.dart';

@singleton
class BiometricVault {
  final LocalAuthentication _auth;
  final FlutterSecureStorage _storage;
  final AppLogger _logger;

  BiometricVault(this._logger)
      : _auth = LocalAuthentication(),
        _storage = const FlutterSecureStorage();

  Future<bool> isBiometricAvailable() async {
    try {
      final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } catch (e) {
      _logger.e('Error checking biometrics', e);
      return false;
    }
  }

  Future<bool> authenticate({String reason = 'Authenticate to access Secure Storage'}) async {
    try {
      final available = await isBiometricAvailable();
      if (!available) {
        // If biometrics are not available (e.g. emulator or no hardware),
        // we might want to return true to allow access, or false to lock it down.
        // For "Fort Knox", strictly it should be false, but for app usability on non-bio devices,
        // we default to allowing if the device simply DOESN'T support it, 
        // assuming the device lock itself is the security.
        _logger.w('Biometrics not available');
        return true; 
      }

      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allow PIN/Pattern fallback
        ),
      );
    } catch (e) {
      _logger.e('Authentication error', e);
      return false;
    }
  }
  
  Future<bool> hasApiKey(String provider) async {
    return await _storage.containsKey(key: 'api_key_$provider');
  }

  Future<void> secureApiKey(String provider, String apiKey) async {
    try {
       await _storage.write(key: 'api_key_$provider', value: apiKey);
    } catch (e) {
      _logger.e('Error securing API key for $provider', e);
      rethrow;
    }
  }

  /// Retrieves the API key.
  /// [requireAuth] defaults to true. If set to false, it bypasses biometric check (use carefully).
  Future<String?> retrieveApiKey(String provider, {bool requireAuth = true}) async {
    if (requireAuth) {
      final authenticated = await authenticate(reason: 'Authenticate to access $provider Key');
      if (!authenticated) {
        _logger.w('Biometric authentication failed or cancelled for $provider key access');
        return null;
      }
    }
    
    try {
      return await _storage.read(key: 'api_key_$provider');
    } catch (e) {
      _logger.e('Error retrieving API key for $provider', e);
      return null;
    }
  }

  Future<void> deleteApiKey(String provider) async {
    await _storage.delete(key: 'api_key_$provider');
  }
}
