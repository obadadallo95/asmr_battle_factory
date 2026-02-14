import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/budget_mode.dart';
import '../../../configurator/presentation/providers/battle_config_provider.dart';

class BudgetModeSelector extends ConsumerWidget {
  const BudgetModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch BattleConfig instead of local provider
    final currentMode = ref.watch(battleConfigProvider.select((s) => s.budgetMode));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: BudgetMode.values.where((m) => m != BudgetMode.custom).map((mode) {
           final isSelected = currentMode == mode;
           return Padding(
             padding: EdgeInsets.symmetric(horizontal: 5.w),
             child: ChoiceChip(
               label: Text(
                 mode.label,
                 style: GoogleFonts.cairo(
                   color: isSelected ? Colors.black : Colors.white,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               selected: isSelected,
               onSelected: (selected) {
                 if (selected) {
                   // Update BattleConfig
                   ref.read(battleConfigProvider.notifier).setBudgetMode(mode);
                 }
               },
               selectedColor: _getColor(mode),
               backgroundColor: Colors.white10,
               side: BorderSide.none,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
             ),
           );
        }).toList(),
      ),
    );
  }

  Color _getColor(BudgetMode mode) {
    switch(mode) {
      case BudgetMode.economy: return Colors.greenAccent;
      case BudgetMode.balanced: return Colors.amberAccent;
      case BudgetMode.premium: return Colors.redAccent;
      default: return Colors.grey;
    }
  }
}
