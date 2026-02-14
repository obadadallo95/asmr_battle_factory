import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../models/saved_scenario.dart';

@singleton
class VaultRepository {
  static const String _boxName = 'idea_vault';
  late Box<SavedScenario> _box;

  Future<void> init() async {
    _box = await Hive.openBox<SavedScenario>(_boxName);
  }

  List<SavedScenario> getAllScenarios() {
    return _box.values.toList();
  }

  Future<void> saveScenario(SavedScenario scenario) async {
    await _box.put(scenario.id, scenario);
  }

  Future<void> deleteScenario(String id) async {
    await _box.delete(id);
  }

  Future<void> clearVault() async {
    await _box.clear();
  }

  Stream<BoxEvent> watchVault() {
    return _box.watch();
  }
}
