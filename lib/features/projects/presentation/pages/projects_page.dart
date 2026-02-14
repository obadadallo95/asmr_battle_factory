import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';
import 'package:asmr_battle_factory/core/utils/responsive_extensions.dart';
import 'package:asmr_battle_factory/features/projects/presentation/providers/projects_provider.dart';
import 'package:asmr_battle_factory/features/projects/presentation/widgets/project_card.dart';
import 'package:asmr_battle_factory/features/projects/presentation/widgets/create_project_dialog.dart';
import 'package:asmr_battle_factory/features/projects/data/models/battle_project.dart';

class ProjectsPage extends ConsumerWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);
    final searchQuery = ref.watch(projectSearchProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: context.gPadding(Factor.md),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildHeader(context, ref),
                SizedBox(height: 1.g),
                _buildSearchField(context, ref),
                SizedBox(height: 1.g),
              ]),
            ),
          ),
          projects.isEmpty 
            ? SliverFillRemaining(
                hasScrollBody: false,
                child: _buildEmptyState(context, searchQuery.isNotEmpty),
              )
            : SliverPadding(
                padding: context.gSymmetricPadding(horizontal: Factor.md, vertical: Factor.xs),
                sliver: _buildGrid(context, projects),
              ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'projects.my_projects'.tr(),
              style: GoogleFonts.cairo(color: Colors.white, fontSize: 3.t, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => showDialog(context: context, builder: (_) => CreateProjectDialog()),
          icon: const Icon(Icons.add),
          label: Text('projects.new_empty'.tr()),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent, foregroundColor: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context, WidgetRef ref) {
    return TextField(
      onChanged: (val) {
        ref.read(projectSearchProvider.notifier).state = val;
        ref.read(projectsProvider.notifier).search(val);
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'projects.search_hint'.tr(),
        hintStyle: const TextStyle(color: Colors.white24),
        prefixIcon: const Icon(Icons.search, color: Colors.white24),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(borderRadius: context.gBorderRadius(Factor.sm), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<BattleProject> projects) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ScreenUtil().screenWidth > 600 ? 3 : 2,
        crossAxisSpacing: 1.g,
        mainAxisSpacing: 1.g,
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => ProjectCard(project: projects[index])
            .animate()
            .fadeIn(duration: 400.ms, delay: (index * 50).ms)
            .slideY(begin: 0.1, end: 0),
        childCount: projects.length,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isSearch) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isSearch ? Icons.search_off : Icons.movie_filter_outlined, color: Colors.white10, size: 5.t),
          SizedBox(height: 1.g),
          Text(
            isSearch ? 'common.no_results'.tr() : 'history.empty'.tr(),
            style: GoogleFonts.cairo(color: Colors.white38, fontSize: 2.t),
          ),
        ],
      ),
    );
  }
}
