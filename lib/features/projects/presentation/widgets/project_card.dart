import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';
import 'package:asmr_battle_factory/core/utils/responsive_extensions.dart';
import 'package:asmr_battle_factory/features/projects/data/models/battle_project.dart';
import 'package:asmr_battle_factory/features/projects/presentation/providers/projects_provider.dart';
import 'package:asmr_battle_factory/features/projects/presentation/widgets/edit_project_dialog.dart';
import 'package:asmr_battle_factory/features/configurator/presentation/providers/battle_config_provider.dart';
import '../../../../core/widgets/glass_card.dart';

class ProjectCard extends ConsumerWidget {
  final BattleProject project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () => _loadAndNavigate(context, ref),
        borderRadius: context.gBorderRadius(Factor.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThumbnail(context, ref),
            Expanded(
              child: Padding(
                padding: context.gPadding(Factor.xs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleRow(context, ref),
                    SizedBox(height: 0.g),
                    _buildContestantPreview(),
                    const Spacer(),
                    _buildStatsRow(context),
                    SizedBox(height: 1.g),
                    _buildFooterActions(context, ref),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context, WidgetRef ref) {
    return Container(
      height: 1.g,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black26,
        image: project.thumbnailPath != null 
          ? DecorationImage(image: AssetImage(project.thumbnailPath!), fit: BoxFit.cover)
          : null,
      ),
      child: Stack(
        children: [
          if (project.thumbnailPath == null)
            Center(child: Icon(Icons.movie_creation_outlined, color: Colors.white10, size: 3.t)),
          Positioned(
            top: 0.g,
            right: 0.g,
            child: _buildBudgetBadge(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetBadge(BuildContext context) {
    final color = project.budgetMode.name == 'economy' ? Colors.greenAccent : Colors.purpleAccent;
    return Container(
      padding: context.gSymmetricPadding(horizontal: Factor.xs, vertical: Factor.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(GoldenRatio.spacing(null, factor: Factor.xs))),
      ),
      child: Text(
        'budget.${project.budgetMode.name}'.tr().toUpperCase(),
        style: TextStyle(color: color, fontSize: 0.t, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.locale.languageCode == 'ar' ? project.nameAr : project.name,
                style: GoogleFonts.cairo(color: Colors.white, fontSize: 1.t, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                project.description,
                style: TextStyle(color: Colors.white38, fontSize: 0.t),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        _buildPopupMenu(context, ref),
      ],
    );
  }

  Widget _buildPopupMenu(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white24),
      onSelected: (value) async {
        if (value == 'delete') {
          ref.read(projectsProvider.notifier).deleteProject(project.id);
        } else if (value == 'duplicate') {
          ref.read(projectsProvider.notifier).duplicateProject(project.id);
        } else if (value == 'edit') {
          showDialog(context: context, builder: (_) => EditProjectDialog(project: project));
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'edit', child: Text('common.edit'.tr())),
        PopupMenuItem(value: 'duplicate', child: Text('projects.from_history'.tr())), // Duplicating key for now
        PopupMenuItem(value: 'delete', child: Text('common.delete'.tr(), style: const TextStyle(color: Colors.redAccent))),
      ],
    );
  }

  Widget _buildContestantPreview() {
    return Row(
      children: project.contestants.take(4).map((c) => Container(
        margin: EdgeInsets.only(right: 0.g),
        child: Text(c.length > 2 ? c.substring(0, 2) : c, style: TextStyle(fontSize: 1.t)),
      )).toList(),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStat(Icons.play_circle_outline, '${project.generationCount}'),
        _buildStat(Icons.attach_money, '\$${project.totalSpent.toStringAsFixed(2)}'),
        const Spacer(),
      ],
    );
  }

  Widget _buildStat(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 1.t, color: Colors.white24),
        SizedBox(width: 0.g),
        Text(label, style: TextStyle(color: Colors.white54, fontSize: 0.t)),
        SizedBox(width: 1.g),
      ],
    );
  }

  Widget _buildFooterActions(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _loadAndNavigate(context, ref),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purpleAccent.withValues(alpha: 0.1),
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: context.gBorderRadius(Factor.xs)),
            ),
            child: Text('projects.produce'.tr(), style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 1.t)),
          ),
        ),
      ],
    );
  }

  void _loadAndNavigate(BuildContext context, WidgetRef ref) async {
    await ref.read(battleConfigProvider.notifier).loadProject(project);
    if (context.mounted) {
      context.push('/studio');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('projects.loaded_into_studio'.tr(args: [project.name]))),
      );
    }
  }
}
