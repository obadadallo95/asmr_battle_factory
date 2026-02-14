import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/marketplace/presentation/providers/marketplace_provider.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';
import '../widgets/function_category_section.dart';
import '../widgets/my_applications_section.dart';

class APIMarketplacePage extends ConsumerStatefulWidget {
  const APIMarketplacePage({super.key});

  @override
  ConsumerState<APIMarketplacePage> createState() => _APIMarketplacePageState();
}

class _APIMarketplacePageState extends ConsumerState<APIMarketplacePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(marketplaceProvider);
    final groupedProviders = <ProviderFunction, List<ProviderCatalogEntry>>{};
    for (final provider in state.filteredProviders) {
      groupedProviders.putIfAbsent(provider.function, () => []).add(provider);
    }
    final availableFunctions = ProviderFunction.values
        .where((function) => groupedProviders.containsKey(function))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF090E1A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF090E1A), Color(0xFF11182A), Color(0xFF0B1324)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: _buildHeader(context, state),
                ),
              ),
              if (state.isLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.filteredProviders.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildEmptyState(context),
                )
              else ...[
                const SliverToBoxAdapter(child: MyApplicationsSection()),
                ...availableFunctions.map(
                  (function) => SliverToBoxAdapter(
                    child: FunctionCategorySection(
                      title: _functionLabel(context, function),
                      function: function,
                      providers: groupedProviders[function]!,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 14)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MarketplaceState state) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1E293B).withValues(alpha: 0.6),
            const Color(0xFF0F172A).withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('marketplace_page.title'),
                      style: GoogleFonts.cairo(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      context.tr('marketplace_page.subtitle'),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.34)),
                ),
                child: Text(
                  '💰 \$0.00',
                  style: GoogleFonts.jetBrainsMono(
                    color: Colors.greenAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => ref.read(marketplaceProvider.notifier).search(val),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: context.tr('marketplace_page.search_hint'),
                    hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.06),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.white38, size: 20),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.tonal(
                onPressed: () => _showFilterSheet(context),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(46, 46),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.zero,
                ),
                child: const Icon(Icons.tune_rounded),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _metaChip(Icons.hub_outlined, '${state.filteredProviders.length}'),
              if (state.selectedFunction != null)
                _metaChip(Icons.category_outlined, _functionLabel(context, state.selectedFunction!)),
              if (state.selectedTier != null)
                _metaChip(Icons.sell_outlined, _tierLabel(context, state.selectedTier!)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metaChip(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white54, size: 14),
          const SizedBox(width: 4),
          Text(
            value,
            style: GoogleFonts.cairo(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off_rounded, color: Colors.white30, size: 44),
            const SizedBox(height: 10),
            Text(
              context.tr('common.no_results'),
              style: GoogleFonts.cairo(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              context.tr('marketplace_page.empty_hint'),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  String _functionLabel(BuildContext context, ProviderFunction function) {
    switch (function) {
      case ProviderFunction.textGeneration:
        return context.tr('marketplace_page.type_text');
      case ProviderFunction.imageGeneration:
        return context.tr('marketplace_page.type_image');
      case ProviderFunction.videoGeneration:
        return context.tr('marketplace_page.type_video');
      case ProviderFunction.audioGeneration:
        return context.tr('marketplace_page.type_audio');
      case ProviderFunction.musicGeneration:
        return context.tr('marketplace_page.type_music');
      case ProviderFunction.voiceCloning:
        return context.tr('marketplace_page.type_voice_clone');
      case ProviderFunction.upscaling:
        return context.tr('marketplace_page.type_upscaling');
      case ProviderFunction.faceSwap:
        return context.tr('marketplace_page.type_face_swap');
      case ProviderFunction.subtitleGeneration:
        return context.tr('marketplace_page.type_subtitles');
    }
  }

  String _tierLabel(BuildContext context, ProviderTier tier) {
    switch (tier) {
      case ProviderTier.free:
        return context.tr('marketplace_page.cost_free');
      case ProviderTier.freemium:
        return context.tr('marketplace_page.cost_freemium');
      case ProviderTier.paid:
        return context.tr('marketplace_page.cost_paid');
      case ProviderTier.openSource:
        return context.tr('marketplace_page.cost_open_source');
    }
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF121A2B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(marketplaceProvider);
          final notifier = ref.read(marketplaceProvider.notifier);

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    context.tr('marketplace_page.filter_title'),
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.tr('marketplace_page.filter_type'),
                    style: GoogleFonts.cairo(color: Colors.white70, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilterChip(
                        label: Text(context.tr('marketplace_page.filter_all')),
                        selected: state.selectedFunction == null,
                        onSelected: (_) => notifier.setFunctionFilter(null),
                      ),
                      FilterChip(
                        label: Text(context.tr('marketplace_page.type_text')),
                        selected: state.selectedFunction == ProviderFunction.textGeneration,
                        onSelected: (s) => notifier.setFunctionFilter(s ? ProviderFunction.textGeneration : null),
                      ),
                      FilterChip(
                        label: Text(context.tr('marketplace_page.type_image')),
                        selected: state.selectedFunction == ProviderFunction.imageGeneration,
                        onSelected: (s) => notifier.setFunctionFilter(s ? ProviderFunction.imageGeneration : null),
                      ),
                      FilterChip(
                        label: Text(context.tr('marketplace_page.type_video')),
                        selected: state.selectedFunction == ProviderFunction.videoGeneration,
                        onSelected: (s) => notifier.setFunctionFilter(s ? ProviderFunction.videoGeneration : null),
                      ),
                      FilterChip(
                        label: Text(context.tr('marketplace_page.type_audio')),
                        selected: state.selectedFunction == ProviderFunction.audioGeneration,
                        onSelected: (s) => notifier.setFunctionFilter(s ? ProviderFunction.audioGeneration : null),
                      ),
                      FilterChip(
                        label: Text(context.tr('marketplace_page.type_music')),
                        selected: state.selectedFunction == ProviderFunction.musicGeneration,
                        onSelected: (s) => notifier.setFunctionFilter(s ? ProviderFunction.musicGeneration : null),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.tr('marketplace_page.filter_cost'),
                    style: GoogleFonts.cairo(color: Colors.white70, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilterChip(
                        label: Text(context.tr('marketplace_page.filter_all')),
                        selected: state.selectedTier == null,
                        onSelected: (_) => notifier.setTierFilter(null),
                      ),
                      FilterChip(
                        label: Text(context.tr('marketplace_page.cost_free')),
                        selected: state.selectedTier == ProviderTier.free,
                        onSelected: (s) => notifier.setTierFilter(s ? ProviderTier.free : null),
                      ),
                      FilterChip(
                        label: Text(context.tr('marketplace_page.cost_freemium')),
                        selected: state.selectedTier == ProviderTier.freemium,
                        onSelected: (s) => notifier.setTierFilter(s ? ProviderTier.freemium : null),
                      ),
                      FilterChip(
                        label: Text(context.tr('marketplace_page.cost_paid')),
                        selected: state.selectedTier == ProviderTier.paid,
                        onSelected: (s) => notifier.setTierFilter(s ? ProviderTier.paid : null),
                      ),
                      FilterChip(
                        label: Text(context.tr('marketplace_page.cost_open_source')),
                        selected: state.selectedTier == ProviderTier.openSource,
                        onSelected: (s) => notifier.setTierFilter(s ? ProviderTier.openSource : null),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(44),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(context.tr('marketplace_page.done')),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
