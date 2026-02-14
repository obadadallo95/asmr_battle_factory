import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';

import 'package:asmr_battle_factory/features/marketplace/domain/repositories/provider_repository.dart';

@Singleton(as: IProviderRepository)
class ProviderDatabase implements IProviderRepository {
  List<ProviderCatalogEntry> _providers = [];
  bool _isLoaded = false;

  /// Load providers from JSON asset
  @override
  Future<void> initialize() async {
    if (_isLoaded) return;
    
    try {
      final jsonString = await rootBundle.loadString('assets/data/provider_catalog.json');
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final providersList = jsonData['providers'] as List;
      
      _providers = providersList
          .map((p) => ProviderCatalogEntry.fromJson(p as Map<String, dynamic>))
          .toList();
      
      _isLoaded = true;
    } catch (e) {
      throw Exception('Failed to load provider catalog: $e');
    }
  }

  @override
  List<ProviderCatalogEntry> getAll() {
    _ensureLoaded();
    return List.unmodifiable(_providers);
  }

  @override
  ProviderCatalogEntry? getById(String id) {
    _ensureLoaded();
    try {
      return _providers.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  List<ProviderCatalogEntry> getByFunction(ProviderFunction function) {
    _ensureLoaded();
    return _providers.where((p) => p.function == function).toList();
  }

  @override
  List<ProviderCatalogEntry> getByTier(ProviderTier tier) {
    _ensureLoaded();
    return _providers.where((p) => p.tier == tier).toList();
  }

  @override
  List<ProviderCatalogEntry> getFreeProviders() {
    _ensureLoaded();
    return _providers.where((p) => p.tier == ProviderTier.free || p.tier == ProviderTier.freemium).toList();
  }

  @override
  List<ProviderCatalogEntry> getAvailableInRegion({bool syria = false}) {
    _ensureLoaded();
    if (syria) {
      return _providers.where((p) => p.availableInSyria).toList();
    }
    return _providers;
  }

  @override
  List<ProviderCatalogEntry> search(String query) {
    _ensureLoaded();
    final lowerQuery = query.toLowerCase();
    return _providers.where((p) =>
      p.name.toLowerCase().contains(lowerQuery) ||
      p.nameAr.contains(query) ||
      p.id.toLowerCase().contains(lowerQuery)
    ).toList();
  }

  @override
  List<ProviderCatalogEntry> sortByQuality(List<ProviderCatalogEntry> providers) {
    final sorted = List<ProviderCatalogEntry>.from(providers);
    sorted.sort((a, b) => b.qualityRating.compareTo(a.qualityRating));
    return sorted;
  }

  @override
  List<ProviderCatalogEntry> sortByCost(List<ProviderCatalogEntry> providers) {
    final sorted = List<ProviderCatalogEntry>.from(providers);
    sorted.sort((a, b) => b.costEfficiencyRating.compareTo(a.costEfficiencyRating));
    return sorted;
  }

  @override
  List<ProviderCatalogEntry> sortBySpeed(List<ProviderCatalogEntry> providers) {
    final sorted = List<ProviderCatalogEntry>.from(providers);
    sorted.sort((a, b) => b.speedRating.compareTo(a.speedRating));
    return sorted;
  }

  @override
  Future<bool> testProviderConnection(String id) async {
    // Simulate API ping or key check
    await Future.delayed(const Duration(seconds: 1));
    return true; // Simplified for now
  }

  void _ensureLoaded() {
    if (!_isLoaded) {
      throw StateError('ProviderDatabase not initialized. Call initialize() first.');
    }
  }
}
