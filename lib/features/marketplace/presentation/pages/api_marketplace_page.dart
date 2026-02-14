import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/marketplace/presentation/providers/marketplace_provider.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';
import 'package:asmr_battle_factory/core/utils/responsive_extensions.dart';
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
  Widget build(BuildContext context) {
    final state = ref.watch(marketplaceProvider);
    
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), // Dark background
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: context.gPadding(Factor.sm),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            context.tr('marketplace_page.title'),
                            style: GoogleFonts.cairo(
                              fontSize: 4.t,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: context.gSymmetricPadding(
                            horizontal: Factor.xs,
                            vertical: Factor.xs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: context.gBorderRadius(Factor.sm),
                            border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            '💰 \$0.00',
                            style: GoogleFonts.jetBrainsMono(
                              color: Colors.greenAccent,
                              fontSize: 2.t,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'API Marketplace',
                      style: GoogleFonts.inter(
                        fontSize: 2.t,
                        color: Colors.white38,
                      ),
                    ),
                    SizedBox(height: 1.g),
                    
                    // Search Bar
                    TextField(
                      controller: _searchController,
                      onChanged: (val) => ref.read(marketplaceProvider.notifier).search(val),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: context.tr('marketplace_page.search_hint'),
                        hintStyle: TextStyle(color: Colors.white30, fontSize: 2.t),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.05),
                        border: OutlineInputBorder(
                          borderRadius: context.gBorderRadius(Factor.sm),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: context.gSymmetricPadding(
                          horizontal: Factor.sm,
                          vertical: Factor.sm,
                        ),
                        prefixIcon: const Icon(Icons.search, color: Colors.white30),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.filter_list, color: Colors.white54),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: const Color(0xFF1A1A2E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(context.gSpacing(Factor.sm)),
                                ),
                              ),
                              builder: (context) => Consumer(
                                builder: (context, ref, _) {
                                  final state = ref.watch(marketplaceProvider);
                                  final notifier = ref.read(marketplaceProvider.notifier);
                                  
                                  return Container(
                                    padding: context.gPadding(Factor.sm),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context.tr('marketplace_page.filter_title'),
                                          style: GoogleFonts.cairo(
                                            fontSize: 3.t,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 1.g),
                                        Text(
                                          context.tr('marketplace_page.filter_type'),
                                          style: GoogleFonts.cairo(color: Colors.white70),
                                        ),
                                        Wrap(
                                          spacing: 0.g,
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
                                          ],
                                        ),
                                        SizedBox(height: 1.g),
                                        Text(context.tr('marketplace_page.filter_cost'), style: GoogleFonts.cairo(color: Colors.white70)),
                                        Wrap(
                                          spacing: 0.g,
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
                                          ],
                                        ),
                                        SizedBox(height: 1.g),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF)),
                                            onPressed: () => Navigator.pop(context),
                                            child: Text(context.tr('marketplace_page.done'), style: const TextStyle(color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (state.isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else ...[
              // My Applications Section
              const SliverToBoxAdapter(
                child: MyApplicationsSection(),
              ),

              // Categories
              SliverToBoxAdapter(
                child: FunctionCategorySection(
                  title: context.tr('marketplace_page.type_text'), // Simplified title display
                  function: ProviderFunction.textGeneration,
                  providers: state.filteredProviders.where((p) => p.function == ProviderFunction.textGeneration).toList(),
                ),
              ),
              
              SliverToBoxAdapter(
                child: FunctionCategorySection(
                  title: context.tr('marketplace_page.type_image'),
                  function: ProviderFunction.imageGeneration,
                  providers: state.filteredProviders.where((p) => p.function == ProviderFunction.imageGeneration).toList(),
                ),
              ),

              SliverToBoxAdapter(
                child: FunctionCategorySection(
                  title: context.tr('marketplace_page.type_video'),
                  function: ProviderFunction.videoGeneration,
                  providers: state.filteredProviders.where((p) => p.function == ProviderFunction.videoGeneration).toList(),
                ),
              ),
              
              SliverToBoxAdapter(
                child: FunctionCategorySection(
                  title: context.tr('marketplace_page.type_audio'),
                  function: ProviderFunction.audioGeneration,
                  providers: state.filteredProviders.where((p) => p.function == ProviderFunction.audioGeneration).toList(),
                ),
              ),
              
               SliverToBoxAdapter(child: SizedBox(height: 2.g)),
            ],
          ],
        ),
      ),
    );
  }
}
