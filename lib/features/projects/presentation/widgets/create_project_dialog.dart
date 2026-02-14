import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:asmr_battle_factory/features/projects/data/models/battle_project.dart';
import 'package:asmr_battle_factory/features/budget/domain/models/budget_mode.dart';
import 'package:asmr_battle_factory/features/projects/data/repositories/project_repository.dart';
import 'package:asmr_battle_factory/config/di/injection.dart';
import '../../../../core/theme/golden_ratio.dart';
import '../../../../core/utils/responsive_extensions.dart';

class CreateProjectDialog extends ConsumerStatefulWidget {
  const CreateProjectDialog({super.key});

  @override
  ConsumerState<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends ConsumerState<CreateProjectDialog> {
  final _nameController = TextEditingController();
  BudgetMode _budgetMode = BudgetMode.balanced;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF161625),
      shape: RoundedRectangleBorder(borderRadius: context.gBorderRadius(Factor.md)),
      title: Text(
        'projects.new_project'.tr(),
        style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'projects.name_hint'.tr(),
              labelStyle: const TextStyle(color: Colors.white38),
              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white10)),
            ),
          ),
          SizedBox(height: 2.g),
          _buildBudgetSelector(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('common.cancel'.tr(), style: const TextStyle(color: Colors.white38)),
        ),
        ElevatedButton(
          onPressed: _createProject,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
          child: Text('common.create'.tr(), style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildBudgetSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('budget.budget'.tr(), style: TextStyle(color: Colors.white54, fontSize: 1.t)),
        SizedBox(height: 1.g),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: BudgetMode.values.map((mode) {
           final isSelected = _budgetMode == mode;
           return ChoiceChip(
             label: Text('budget.${mode.name}'.tr()),
             selected: isSelected,
             onSelected: (val) => setState(() => _budgetMode = mode),
             selectedColor: Colors.purpleAccent.withValues(alpha: 0.3),
             backgroundColor: Colors.white.withValues(alpha: 0.05),
             labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.white38),
           );
          }).toList(),
        ),
      ],
    );
  }

  void _createProject() async {
    if (_nameController.text.isEmpty) return;

    final project = BattleProject(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      nameAr: _nameController.text, // Simple fallback for now
      description: 'Custom Battle configuration',
      createdAt: DateTime.now(),
      lastUsed: DateTime.now(),
      contestants: [],
      budgetMode: _budgetMode,
      providerMix: const ProviderMix(useSmartRouting: true),
      videoSettings: const VideoSettings(),
    );

    await getIt<ProjectRepository>().saveProject(project);
    if (mounted) Navigator.pop(context);
  }
}
