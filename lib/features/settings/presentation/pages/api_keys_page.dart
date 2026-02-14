import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/di/injection.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../features/marketplace/domain/entities/provider_catalog_entry.dart';
import '../../../../features/marketplace/domain/repositories/provider_repository.dart';
import '../providers/settings_provider.dart';
import '../widgets/secure_api_field.dart';

final apiKeyCatalogProvider = FutureProvider<List<ProviderCatalogEntry>>((ref) async {
  final repo = getIt<IProviderRepository>();
  await repo.initialize();
  final providers = repo.getAll().where((p) => p.requiresKey).toList();
  providers.sort((a, b) => a.id.compareTo(b.id));
  return providers;
});

class APIKeysPage extends ConsumerWidget {
  const APIKeysPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(apiKeyCatalogProvider);
    final configuredCountAsync = ref.watch(connectedProvidersCountProvider);
    final configuredCount = configuredCountAsync.value ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('settings.api_vault.title'.tr(), style: GoogleFonts.cairo(fontWeight: FontWeight.w800)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              context.go('/app/settings');
            }
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(apiKeyCatalogProvider);
          ref.invalidate(configuredProviderIdsProvider);
          await ref.read(apiKeyCatalogProvider.future);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          children: [
            GlassCard(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'settings.api_vault.subtitle'.tr(),
                    style: GoogleFonts.cairo(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'settings.api_vault.connected'.tr(args: ['$configuredCount']),
                    style: GoogleFonts.cairo(color: Colors.greenAccent, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            catalogAsync.when(
              data: (providers) => Column(
                children: providers.map((provider) {
                  final name = context.locale.languageCode == 'ar' ? provider.nameAr : provider.name;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SecureApiKeyField(
                      providerId: provider.id,
                      label: name,
                      hint: 'settings.api_vault.key_hint'.tr(args: [provider.id]),
                    ),
                  );
                }).toList(),
              ),
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'common.error'.tr(args: ['$e']),
                    style: const TextStyle(color: Colors.redAccent),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

