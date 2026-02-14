import 'package:equatable/equatable.dart';
import '../../../generator/domain/entities/contestant.dart';
import '../../../budget/domain/models/budget_mode.dart';

enum WinnerMode { unexpected, random, underdog, favorite }
enum BattleType { tournament, royale, revenge, showcase }
enum ProviderMix { balanced, speed, quality, economy }

class BattleConfig extends Equatable {
  final List<Contestant> contestants;
  final WinnerMode winnerMode;
  final ProviderMix providerMix;
  final BattleType type;
  final BudgetMode budgetMode;
  final bool slowMotion;

  const BattleConfig({
    required this.contestants,
    this.winnerMode = WinnerMode.random,
    this.providerMix = ProviderMix.balanced,
    this.type = BattleType.showcase,
    this.budgetMode = BudgetMode.balanced,
    this.slowMotion = false,
  });

  BattleConfig copyWith({
    List<Contestant>? contestants,
    WinnerMode? winnerMode,
    ProviderMix? providerMix,
    BattleType? type,
    BudgetMode? budgetMode,
    bool? slowMotion,
  }) {
    return BattleConfig(
      contestants: contestants ?? this.contestants,
      winnerMode: winnerMode ?? this.winnerMode,
      providerMix: providerMix ?? this.providerMix,
      type: type ?? this.type,
      budgetMode: budgetMode ?? this.budgetMode,
      slowMotion: slowMotion ?? this.slowMotion,
    );
  }

  @override
  List<Object?> get props => [contestants, winnerMode, providerMix, type, budgetMode, slowMotion];
}
