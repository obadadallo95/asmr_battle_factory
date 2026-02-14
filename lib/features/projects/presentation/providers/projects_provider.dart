import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:asmr_battle_factory/features/projects/data/repositories/project_repository.dart';
import 'package:asmr_battle_factory/features/projects/data/models/battle_project.dart';
import 'package:asmr_battle_factory/config/di/injection.dart';

final projectsProvider = StateNotifierProvider<ProjectsNotifier, List<BattleProject>>((ref) {
  return ProjectsNotifier(getIt<ProjectRepository>());
});

class ProjectsNotifier extends StateNotifier<List<BattleProject>> {
  final ProjectRepository _repo;

  ProjectsNotifier(this._repo) : super([]) {
    _loadProjects();
    _listenToChanges();
  }

  void _loadProjects() {
    state = _repo.getAllProjects();
  }

  void _listenToChanges() {
    _repo.watchProjects().listen((event) {
      _loadProjects();
    });
  }

  Future<void> deleteProject(String id) async {
    await _repo.deleteProject(id);
  }

  Future<void> duplicateProject(String id) async {
    await _repo.duplicateProject(id);
  }

  void search(String query) {
    if (query.isEmpty) {
      _loadProjects();
    } else {
      final all = _repo.getAllProjects();
      state = all.where((p) {
        final matchesName = p.name.toLowerCase().contains(query.toLowerCase()) ||
            p.nameAr.contains(query);
        final matchesContestant = p.contestants.any((c) => c.toLowerCase().contains(query.toLowerCase()));
        return matchesName || matchesContestant;
      }).toList();
    }
  }
}

final projectSearchProvider = StateProvider<String>((ref) => '');
