import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:asmr_battle_factory/features/history/data/models/battle_history.dart';
import 'package:asmr_battle_factory/features/history/data/repositories/history_repository.dart';
import 'package:asmr_battle_factory/config/di/injection.dart';

final historyProvider = StreamProvider<List<BattleHistory>>((ref) {
  final repo = getIt<HistoryRepository>();
  return repo.watchHistory().map((_) => repo.getRecentHistory());
});
