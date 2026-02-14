import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/golden_ratio.dart';
import '../../../../core/utils/responsive_extensions.dart';
import '../../domain/entities/battle_config.dart';
import '../providers/battle_config_provider.dart';

class ConfigurationPanel extends ConsumerWidget {
  const ConfigurationPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(battleConfigProvider);
    final notifier = ref.read(battleConfigProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'configuration_panel.title'.tr(),
          style: GoogleFonts.cairo(
            fontSize: 2.t,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 1.g),
        
        // Winner Mode Section
        Text(
          'winner_mode.title'.tr(),
          style: TextStyle(
            fontSize: 1.t,
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 0.g),
        Wrap(
          spacing: 0.g,
          runSpacing: 0.g,
          children: WinnerMode.values.map((mode) {
            final isSelected = config.winnerMode == mode;
            return ChoiceChip(
              label: Text('winner_mode.${mode.name}'.tr()),
              selected: isSelected,
              onSelected: (_) => notifier.setWinnerMode(mode),
              selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              labelStyle: GoogleFonts.cairo(
                color: isSelected ? Colors.white : Colors.white60,
                fontSize: 0.t,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.white12,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 1.g),
        
        // Battle Type Section
        Text(
          'battle_type.title'.tr(),
          style: TextStyle(
            fontSize: 1.t,
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 0.g),
        Wrap(
          spacing: 0.g,
          runSpacing: 0.g,
          children: BattleType.values.map((type) {
            final isSelected = config.type == type;
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getBattleTypeIcon(type),
                    size: 1.t,
                    color: isSelected ? Colors.white : Colors.white60,
                  ),
                  SizedBox(width: 0.g),
                  Text('battle_type.${type.name}'.tr()),
                ],
              ),
              selected: isSelected,
              onSelected: (_) => notifier.setBattleType(type),
              selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              labelStyle: GoogleFonts.cairo(
                color: isSelected ? Colors.white : Colors.white60,
                fontSize: 0.t,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.white12,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 1.g),
        
        // Provider Mix Section
        Text(
          'provider_mix.title'.tr(),
          style: TextStyle(
            fontSize: 1.t,
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 0.g),
        Wrap(
          spacing: 0.g,
          runSpacing: 0.g,
          children: ProviderMix.values.map((mix) {
            final isSelected = config.providerMix == mix;
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getProviderMixIcon(mix),
                    size: 1.t,
                    color: isSelected ? Colors.white : Colors.white60,
                  ),
                  SizedBox(width: 0.g),
                  Text('provider_mix.${mix.name}'.tr()),
                ],
              ),
              selected: isSelected,
              onSelected: (_) => notifier.setProviderMix(mix),
              selectedColor: _getProviderMixColor(mix).withValues(alpha: 0.2),
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              labelStyle: GoogleFonts.cairo(
                color: isSelected ? Colors.white : Colors.white60,
                fontSize: 0.t,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected
                    ? _getProviderMixColor(mix)
                    : Colors.white12,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  IconData _getBattleTypeIcon(BattleType type) {
    return switch (type) {
      BattleType.tournament => Icons.emoji_events,
      BattleType.royale => Icons.local_fire_department,
      BattleType.revenge => Icons.replay,
      BattleType.showcase => Icons.visibility,
    };
  }

  IconData _getProviderMixIcon(ProviderMix mix) {
    return switch (mix) {
      ProviderMix.balanced => Icons.balance,
      ProviderMix.speed => Icons.speed,
      ProviderMix.quality => Icons.high_quality,
      ProviderMix.economy => Icons.savings,
    };
  }

  Color _getProviderMixColor(ProviderMix mix) {
    return switch (mix) {
      ProviderMix.balanced => Colors.purple,
      ProviderMix.speed => Colors.blue,
      ProviderMix.quality => Colors.amber,
      ProviderMix.economy => Colors.green,
    };
  }
}
