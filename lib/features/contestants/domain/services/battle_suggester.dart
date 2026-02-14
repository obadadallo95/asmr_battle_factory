import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:asmr_battle_factory/features/generator/domain/entities/contestant.dart';
import 'package:asmr_battle_factory/features/contestants/data/repositories/contestant_repository_impl.dart';
import 'package:asmr_battle_factory/features/configurator/data/models/battle_config.dart';
import 'package:uuid/uuid.dart';

@singleton
class BattleSuggester {
  final ContestantRepository _repository;

  BattleSuggester(this._repository);

  Future<BattleConfig> suggestRandomBattle({int count = 4}) async {
    final random = Random();
    final allContestants = await _repository.getAll();
    
    // Choose strategy: Thematic consistency or Dramatic contrast
    final useThematic = random.nextBool();
    List<String> selectedIds = [];

    if (useThematic) {
      final category = _pickRandomCategory(random);
      final list = allContestants.where((c) => c.category == category).toList();
      list.shuffle();
      selectedIds = list.take(count).map((c) => c.id).toList();
    } else {
      // Pick 2 from one category, 2 from another (Contrast)
      final cat1 = _pickRandomCategory(random);
      final cat2 = _pickRandomCategory(random);
      
      final list1 = allContestants.where((c) => c.category == cat1).toList();
      final list2 = allContestants.where((c) => c.category == cat2).toList();
      
      list1.shuffle();
      list2.shuffle();
      
      selectedIds = [
        ...list1.take(count ~/ 2).map((c) => c.id),
        ...list2.take(count ~/ 2).map((c) => c.id),
      ];
    }

    if (selectedIds.length < count) {
      // Fill remaining with pure random if logic fails
      List<Contestant> shufflePool = List.from(allContestants)..shuffle();
      for (var c in shufflePool) {
        if (!selectedIds.contains(c.id)) {
          selectedIds.add(c.id);
          if (selectedIds.length == count) break;
        }
      }
    }

    return BattleConfig(
      id: const Uuid().v4(),
      selectedContestantIds: selectedIds,
      winnerMode: WinnerMode.random,
      battleType: BattleType.battleRoyale,
      createdAt: DateTime.now(),
    );
  }

  ContestantCategory _pickRandomCategory(Random r) {
    return ContestantCategory.values[r.nextInt(ContestantCategory.values.length)];
  }
}
