import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:asmr_battle_factory/config/di/injection.dart';
import '../../domain/entities/provider_catalog_entry.dart';
import '../../domain/repositories/provider_repository.dart';
import '../../../../core/services/security/biometric_vault.dart';

// State class
class MarketplaceState {
  final List<ProviderCatalogEntry> allProviders;
  final List<ProviderCatalogEntry> filteredProviders;
  final bool isLoading;
  final String searchQuery;
  final ProviderFunction? selectedFunction;
  final ProviderTier? selectedTier;

  const MarketplaceState({
    this.allProviders = const [],
    this.filteredProviders = const [],
    this.isLoading = true,
    this.searchQuery = '',
    this.selectedFunction,
    this.selectedTier,
  });

  MarketplaceState copyWith({
    List<ProviderCatalogEntry>? allProviders,
    List<ProviderCatalogEntry>? filteredProviders,
    bool? isLoading,
    String? searchQuery,
    ProviderFunction? selectedFunction,
    ProviderTier? selectedTier,
  }) {
    return MarketplaceState(
      allProviders: allProviders ?? this.allProviders,
      filteredProviders: filteredProviders ?? this.filteredProviders,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFunction: selectedFunction ?? this.selectedFunction,
      selectedTier: selectedTier ?? this.selectedTier,
    );
  }
}

// Provider
final marketplaceProvider = StateNotifierProvider<MarketplaceNotifier, MarketplaceState>((ref) {
  return MarketplaceNotifier(getIt<IProviderRepository>());
});

final providerKeyExistsProvider = Provider.family<bool, String>((ref, providerId) {
  final futureValue = ref.watch(providerKeyFutureProvider(providerId));
  return futureValue.value ?? false;
});

final providerKeyFutureProvider = FutureProvider.family<bool, String>((ref, providerId) async {
  final vault = getIt<BiometricVault>();
  return await vault.hasApiKey(providerId);
});

final marketplaceRepositoryProvider = Provider<IProviderRepository>((ref) {
  return getIt<IProviderRepository>();
});

// For default providers per function
final defaultProvidersProvider = StateNotifierProvider<DefaultProvidersNotifier, Map<ProviderFunction, String>>((ref) {
  return DefaultProvidersNotifier();
});

class DefaultProvidersNotifier extends StateNotifier<Map<ProviderFunction, String>> {
  DefaultProvidersNotifier() : super({});

  void setDefault(ProviderFunction function, String providerId) {
    state = {...state, function: providerId};
  }
}

class MarketplaceNotifier extends StateNotifier<MarketplaceState> {
  final IProviderRepository _repository;

  MarketplaceNotifier(this._repository) : super(const MarketplaceState()) {
    loadProviders();
  }

  Future<void> loadProviders() async {
    state = state.copyWith(isLoading: true);
    try {
      // Ensure initialized if not already (repository implementation should handle this check)
      await _repository.initialize(); 
      final providers = _repository.getAll();
      state = state.copyWith(
        allProviders: providers,
        filteredProviders: providers,
        isLoading: false,
      );
    } catch (e) {
      // Handle error
      state = state.copyWith(isLoading: false);
    }
  }

  void search(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void setFunctionFilter(ProviderFunction? function) {
    if (state.selectedFunction == function) {
      state = state.copyWith(selectedFunction: null); // This line is slightly buggy with standard copyWith if null is ignored, but we assume it works or we'll fix later
      // A better way if copyWith ignores nulls:
      // state = MarketplaceState(..., selectedFunction: null, ...);
      // But let's rely on standard copyWith behavior for now or fix if needed. 
      // Actually, frozen objects copyWith usually treats null as "do not change" unless leveraging "undefined" sentinel. state_notifier usually just replaces.
      // Re-instantiating is safer.
       state = MarketplaceState(
        allProviders: state.allProviders,
        filteredProviders: state.filteredProviders,
        isLoading: state.isLoading,
        searchQuery: state.searchQuery,
        selectedFunction: null,
        selectedTier: state.selectedTier,
      );
    } else {
      state = state.copyWith(selectedFunction: function);
    }
    _applyFilters();
  }

  void setTierFilter(ProviderTier? tier) {
     if (state.selectedTier == tier) {
        state = MarketplaceState(
        allProviders: state.allProviders,
        filteredProviders: state.filteredProviders,
        isLoading: state.isLoading,
        searchQuery: state.searchQuery,
        selectedFunction: state.selectedFunction,
        selectedTier: null,
      );
     } else {
       state = state.copyWith(selectedTier: tier);
     }
    _applyFilters();
  }

  void _applyFilters() {
    var result = state.allProviders;

    // Search
    if (state.searchQuery.isNotEmpty) {
      final q = state.searchQuery.toLowerCase();
      result = result.where((p) => 
        p.name.toLowerCase().contains(q) || 
        p.nameAr.contains(q) ||
        p.supportedModels.any((m) => m.toLowerCase().contains(q))
      ).toList();
    }

    // Function
    if (state.selectedFunction != null) {
      result = result.where((p) => p.function == state.selectedFunction).toList();
    }

    // Tier
    if (state.selectedTier != null) {
      result = result.where((p) => p.tier == state.selectedTier).toList();
    }

    state = state.copyWith(filteredProviders: result);
  }
}
