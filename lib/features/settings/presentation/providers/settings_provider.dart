import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/settings_service.dart';
import '../../../../core/services/security/biometric_vault.dart';
import '../../../../config/di/injection.dart';

class SettingsState {
  final ThemeMode themeMode;
  final bool biometricLockEnabled;
  final String searchQuery;

  const SettingsState({
    required this.themeMode,
    required this.biometricLockEnabled,
    this.searchQuery = '',
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? biometricLockEnabled,
    String? searchQuery,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      biometricLockEnabled: biometricLockEnabled ?? this.biometricLockEnabled,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  final SettingsService _settingsService;
  final BiometricVault _biometricVault;

  SettingsNotifier(this._settingsService, this._biometricVault)
      : super(SettingsState(
          themeMode: _parseThemeMode(_settingsService.themeMode),
          biometricLockEnabled: false, // Initial state, will sync in init
        )) {
    _init();
  }

  Future<void> _init() async {
    // Check biometric state if needed, here we just assume it's a toggle for demonstration
    // In a real app, you might check if the vault is configured
  }

  static ThemeMode _parseThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await _settingsService.setThemeMode(mode.name);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  Future<void> toggleBiometricLock() async {
    // In a real scenario, this would authenticate first
    final authenticated = await _biometricVault.authenticate(
      reason: 'Confirm to change security settings',
    );
    if (authenticated) {
      state = state.copyWith(biometricLockEnabled: !state.biometricLockEnabled);
    }
  }

  Future<void> clearCache() async {
    await _settingsService.clearCache();
    // Reset state to defaults
    state = state.copyWith(
      themeMode: ThemeMode.dark,
      biometricLockEnabled: false,
    );
  }

  Future<void> resetToDefaults() async {
    await clearCache();
    // Additional reset logic if any
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final service = getIt<SettingsService>();
  final vault = getIt<BiometricVault>();
  return SettingsNotifier(service, vault);
});

// Additional providers for health/status
final connectedProvidersCountProvider = Provider<int>((ref) {
  // Logic to count providers with keys
  return 4; // Placeholder for now, match diagnostic
});

final apiHealthProvider = Provider<APIHealth>((ref) {
  return const APIHealth(connected: 4, total: 5);
});

class APIHealth {
  final int connected;
  final int total;
  const APIHealth({required this.connected, required this.total});
}

final averageLatencyProvider = Provider<int>((ref) => 45);
final settingsSearchProvider = StateProvider<String>((ref) => '');
