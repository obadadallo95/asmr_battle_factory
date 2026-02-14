import 'dart:math';
import 'package:asmr_battle_factory/features/generator/domain/entities/contestant.dart';
import '../../../configurator/data/models/battle_config.dart';

class WinnerSelector {
  Contestant? determineWinner(
    List<Contestant> contestants,
    WinnerMode mode,
    String? userSelectedWinnerId,
  ) {
    if (contestants.isEmpty) return null;

    switch (mode) {
      case WinnerMode.aiDecided:
        return _calculateLogicBasedWinner(contestants);
        
      case WinnerMode.random:
        return contestants[Random().nextInt(contestants.length)];
        
      case WinnerMode.userSelected:
        if (userSelectedWinnerId != null) {
          return contestants.firstWhere(
            (c) => c.id == userSelectedWinnerId,
            orElse: () => contestants[0],
          );
        }
        return contestants[0];
        
      case WinnerMode.scriptBased:
        // Winner will be identified during full script generation
        return null;
    }
  }

  Contestant _calculateLogicBasedWinner(List<Contestant> contestants) {
    // Basic logic for now: High power level wins.
    // In future versions, we can add rock-paper-scissors type advantages.
    return contestants.reduce((curr, next) => curr.powerLevel >= next.powerLevel ? curr : next);
  }
}
