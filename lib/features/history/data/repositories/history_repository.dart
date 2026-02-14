import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:asmr_battle_factory/features/history/data/models/battle_history.dart';

@singleton
class HistoryRepository {
  static const String _boxName = 'battle_history';
  late Box<BattleHistory> _box;

  Future<void> init() async {
    _box = await Hive.openBox<BattleHistory>(_boxName);
  }

  Future<void> logBattle(BattleHistory entry) async {
    await _box.put(entry.id, entry);
    
    // Maintain a rolling history of 50 items
    if (_box.length > 50) {
      final keys = _box.keys.toList()..sort();
      final keysToDelete = keys.take(_box.length - 50);
      await _box.deleteAll(keysToDelete);
    }
  }

  List<BattleHistory> getRecentHistory({int limit = 20}) {
    return _box.values.toList().reversed.take(limit).toList();
  }

  Future<void> deleteHistoryEntry(String id) async {
    await _box.delete(id);
  }

  Future<void> clearAllHistory() async {
    await _box.clear();
  }

  Stream<BoxEvent> watchHistory() {
    return _box.watch();
  }
}
