import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/vault/data/models/saved_scenario.dart';

class ScenarioPickerSheet extends StatefulWidget {
  final List<SavedScenario> scenarios;
  final Function(SavedScenario) onSelected;

  const ScenarioPickerSheet({
    super.key, 
    required this.scenarios, 
    required this.onSelected,
  });

  @override
  State<ScenarioPickerSheet> createState() => _ScenarioPickerSheetState();
}

class _ScenarioPickerSheetState extends State<ScenarioPickerSheet> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 30.h),
          Expanded(
            child: PageView.builder(
              itemCount: widget.scenarios.length,
              controller: PageController(viewportFraction: 0.8),
              onPageChanged: (index) => setState(() => _selectedIndex = index),
              itemBuilder: (context, index) {
                final scenario = widget.scenarios[index];
                return _buildScenarioCard(scenario, index == _selectedIndex);
              },
            ),
          ),
          SizedBox(height: 30.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2.r))),
        SizedBox(height: 20.h),
        Text(
          'configurator.picker.title'.tr(),
          style: GoogleFonts.cairo(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        Text(
          'configurator.picker.subtitle'.tr(),
          style: GoogleFonts.cairo(color: Colors.white38, fontSize: 13.sp),
        ),
      ],
    );
  }

  Widget _buildScenarioCard(SavedScenario scenario, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: isSelected ? 0 : 20.h),
      padding: EdgeInsets.all(25.w),
      decoration: BoxDecoration(
        color: isSelected ? Colors.purpleAccent.withValues(alpha: 0.12) : const Color(0xFF1C1C2D),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: isSelected ? Colors.purpleAccent : Colors.white10, width: isSelected ? 2 : 1),
        boxShadow: isSelected ? [BoxShadow(color: Colors.purpleAccent.withValues(alpha: 0.2), blurRadius: 20)] : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('configurator.picker.option_label'.tr(args: [(_selectedIndex + 1).toString()]), style: TextStyle(color: isSelected ? Colors.purpleAccent : Colors.white24, fontWeight: FontWeight.bold)),
              Icon(Icons.auto_awesome, color: isSelected ? Colors.purpleAccent : Colors.white10),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            scenario.titleAr,
            style: GoogleFonts.cairo(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          Text(
            scenario.briefDescriptionAr,
            style: GoogleFonts.cairo(color: Colors.white70, fontSize: 14.sp),
          ),
          const Spacer(),
          _infoRow(Icons.emoji_events_outlined, 'configurator.picker.potential_winner'.tr(), scenario.suggestedWinnerId ?? '---'),
          SizedBox(height: 10.h),
          _infoRow(Icons.bolt, 'configurator.picker.twist_level'.tr(), '${scenario.twistLevel}/10'),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: Colors.white38),
        SizedBox(width: 8.w),
        Text(label, style: GoogleFonts.cairo(color: Colors.white38, fontSize: 12.sp)),
        SizedBox(width: 8.w),
        Text(value, style: GoogleFonts.cairo(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white10),
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text('configurator.picker.save_to_vault'.tr(), style: GoogleFonts.cairo(color: Colors.white38)),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () => widget.onSelected(widget.scenarios[_selectedIndex]),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purpleAccent,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text('configurator.picker.start_production'.tr(), style: GoogleFonts.cairo(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
