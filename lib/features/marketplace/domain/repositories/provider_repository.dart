import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';

abstract class IProviderRepository {
  Future<void> initialize();
  List<ProviderCatalogEntry> getAll();
  ProviderCatalogEntry? getById(String id);
  List<ProviderCatalogEntry> getByFunction(ProviderFunction function);
  List<ProviderCatalogEntry> getByTier(ProviderTier tier);
  List<ProviderCatalogEntry> getFreeProviders();
  List<ProviderCatalogEntry> getAvailableInRegion({bool syria = false});
  List<ProviderCatalogEntry> search(String query);
  List<ProviderCatalogEntry> sortByQuality(List<ProviderCatalogEntry> providers);
  List<ProviderCatalogEntry> sortByCost(List<ProviderCatalogEntry> providers);
  List<ProviderCatalogEntry> sortBySpeed(List<ProviderCatalogEntry> providers);
  Future<bool> testProviderConnection(String id);
}
