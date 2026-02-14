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

class EditProjectDialog extends ConsumerStatefulWidget {
  final BattleProject project;
  const EditProjectDialog({super.key, required this.project});

  @override
  ConsumerState<EditProjectDialog> createState() => _EditProjectDialogState();
}

class _EditProjectDialogState extends ConsumerState<EditProjectDialog> {
  late TextEditingController _nameController;
  late BudgetMode _budgetMode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: context.locale.languageCode == 'ar' ? widget.project.nameAr : widget.project.name);
    _budgetMode = widget.project.budgetMode;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF161625),
      shape: RoundedRectangleBorder(borderRadius: context.gBorderRadius(Factor.md)),
      title: Text(
        'common.edit'.tr(),
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
          onPressed: _saveChanges,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
          child: Text('common.save'.tr(), style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildBudgetSelector() {
    return Wrap(
      spacing: 0.5.g,
      runSpacing: 0.5.g,
      children: BudgetMode.values.map((mode) {
        return ChoiceChip(
          label: Text('budget.${mode.name}'.tr()),
          selected: _budgetMode == mode,
          onSelected: (val) => setState(() => _budgetMode = mode),
        );
      }).toList(),
    );
  }

  void _saveChanges() async {
    final updated = widget.project.copyWith(
      name: context.locale.languageCode == 'en' ? _nameController.text : widget.project.name,
      nameAr: context.locale.languageCode == 'ar' ? _nameController.text : widget.project.nameAr,
      budgetMode: _budgetMode,
    );
    await getIt<ProjectRepository>().saveProject(updated);
    if (mounted) Navigator.pop(context);
  }
}
