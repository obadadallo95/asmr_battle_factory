import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
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
        borderRadius: BorderRadius.circular(14),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final dense = constraints.maxWidth < 130;
            final compact = constraints.maxWidth < 165;

            final thumbnailHeight = constraints.maxHeight * (dense ? 0.29 : 0.33);
            final pad = constraints.maxWidth * (dense ? 0.05 : 0.07);
            final titleSize = constraints.maxWidth * (dense ? 0.11 : 0.09);
            final metaSize = constraints.maxWidth * 0.075;
            final buttonHeight = constraints.maxHeight * (dense ? 0.12 : 0.14);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: thumbnailHeight,
                  width: double.infinity,
                  child: _buildThumbnail(context, dense: dense),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(pad),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleRow(
                          context,
                          ref,
                          titleSize: titleSize,
                          metaSize: metaSize,
                          showDescription: !dense,
                          showMenu: !compact,
                        ),
                        if (!dense) ...[
                          SizedBox(height: constraints.maxHeight * 0.015),
                          _buildContestantPreview(metaSize: metaSize),
                        ],
                        const Spacer(),
                        _buildStatsRow(metaSize: metaSize, dense: dense),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        _buildFooterActions(
                          context,
                          ref,
                          height: buttonHeight,
                          dense: dense,
                          titleSize: titleSize,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context, {required bool dense}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        image: project.thumbnailPath != null
            ? DecorationImage(image: AssetImage(project.thumbnailPath!), fit: BoxFit.cover)
            : null,
      ),
      child: Stack(
        children: [
          if (project.thumbnailPath == null)
            Center(child: Icon(Icons.movie_creation_outlined, color: Colors.white10, size: dense ? 18 : 22)),
          Positioned(
            top: 0,
            right: 0,
            child: _buildBudgetBadge(context, dense: dense),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetBadge(BuildContext context, {required bool dense}) {
    final color = project.budgetMode.name == 'economy' ? Colors.greenAccent : Colors.purpleAccent;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: dense ? 6 : 8, vertical: dense ? 3 : 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10)),
      ),
      child: Text(
        dense ? '💰' : 'budget.${project.budgetMode.name}'.tr(),
        style: TextStyle(color: color, fontSize: dense ? 9 : 10, fontWeight: FontWeight.w700),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildTitleRow(
    BuildContext context,
    WidgetRef ref, {
    required double titleSize,
    required double metaSize,
    required bool showDescription,
    required bool showMenu,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.locale.languageCode == 'ar' ? project.nameAr : project.name,
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: titleSize.clamp(10.0, 15.0),
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (showDescription)
                Text(
                  project.description,
                  style: TextStyle(color: Colors.white38, fontSize: metaSize.clamp(9.0, 12.0)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        if (showMenu) _buildPopupMenu(context, ref),
      ],
    );
  }

  Widget _buildPopupMenu(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white24, size: 18),
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
        PopupMenuItem(value: 'duplicate', child: Text('projects.from_history'.tr())),
        PopupMenuItem(value: 'delete', child: Text('common.delete'.tr(), style: const TextStyle(color: Colors.redAccent))),
      ],
    );
  }

  Widget _buildContestantPreview({required double metaSize}) {
    if (project.contestants.isEmpty) {
      return Text('—', style: TextStyle(color: Colors.white30, fontSize: metaSize.clamp(9.0, 11.0)));
    }

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: project.contestants.take(4).map((c) {
        final short = c.length > 2 ? c.substring(0, 2) : c;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            short,
            style: TextStyle(color: Colors.white70, fontSize: metaSize.clamp(8.5, 10.5)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatsRow({required double metaSize, required bool dense}) {
    final textStyle = TextStyle(color: Colors.white54, fontSize: metaSize.clamp(8.5, 11.0));

    if (dense) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('▶ ${project.generationCount}', style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
          Text('\$${project.totalSpent.toStringAsFixed(2)}', style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        _statChip(Icons.play_circle_outline, '${project.generationCount}', textStyle),
        _statChip(Icons.attach_money, project.totalSpent.toStringAsFixed(2), textStyle),
      ],
    );
  }

  Widget _statChip(IconData icon, String label, TextStyle style) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: style.fontSize! + 1, color: Colors.white30),
          const SizedBox(width: 4),
          Text(label, style: style, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildFooterActions(
    BuildContext context,
    WidgetRef ref, {
    required double height,
    required bool dense,
    required double titleSize,
  }) {
    return SizedBox(
      width: double.infinity,
      height: height.clamp(28.0, 44.0),
      child: ElevatedButton(
        onPressed: () => _loadAndNavigate(context, ref),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purpleAccent.withValues(alpha: 0.14),
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          dense ? '▶' : 'projects.produce'.tr(),
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w800,
            fontSize: titleSize.clamp(9.5, 13.0),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
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
