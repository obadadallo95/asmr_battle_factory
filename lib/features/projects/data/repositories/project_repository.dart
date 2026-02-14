import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:asmr_battle_factory/features/projects/data/models/battle_project.dart';
import 'package:asmr_battle_factory/features/budget/domain/models/budget_mode.dart';

@singleton
class ProjectRepository {
  static const String _boxName = 'battle_projects';
  late Box<BattleProject> _box;

  Future<void> init() async {
    _box = await Hive.openBox<BattleProject>(_boxName);
    
    // Seed and/or default templates logic could go here
    if (_box.isEmpty) {
      await _seedDefaultProjects();
    }
  }

  List<BattleProject> getAllProjects() {
    return _box.values.toList();
  }

  Future<void> saveProject(BattleProject project) async {
    await _box.put(project.id, project);
  }

  Future<void> deleteProject(String id) async {
    await _box.delete(id);
  }

  Future<void> duplicateProject(String id) async {
    final original = getProject(id);
    if (original != null) {
      final duplicate = original.copyWith(
        id: '${original.id}_copy_${DateTime.now().millisecondsSinceEpoch}',
        name: '${original.name} (Copy)',
        nameAr: '${original.nameAr} (نسخة)',
        createdAt: DateTime.now(),
        lastUsed: DateTime.now(),
        generationCount: 0,
        totalSpent: 0,
      );
      await saveProject(duplicate);
    }
  }

  BattleProject? getProject(String id) {
    return _box.get(id);
  }

  Stream<BoxEvent> watchProjects() {
    return _box.watch();
  }

  Future<void> _seedDefaultProjects() async {
    final freeStarter = BattleProject(
      id: 'free_starter',
      name: 'Free Starter',
      nameAr: 'مجاني وسريع',
      description: '100% Free generation with Groq and Pollinations.',
      createdAt: DateTime.now(),
      lastUsed: DateTime.now(),
      contestants: ['نمل', 'نحل'],
      budgetMode: BudgetMode.economy,
      providerMix: const ProviderMix(
        ideaProvider: 'groq',
        imageProvider: 'pollinations',
        useSmartRouting: true,
      ),
      videoSettings: const VideoSettings(),
      tags: ['Free', 'Beginner'],
    );

    final cinematicPro = BattleProject(
      id: 'cinematic_pro',
      name: 'Cinematic Pro',
      nameAr: 'طبيعة سينمائية',
      description: 'High-quality 4K battle with GPT-4, Flux and Runway.',
      createdAt: DateTime.now(),
      lastUsed: DateTime.now(),
      contestants: ['أسد', 'نمر'],
      budgetMode: BudgetMode.premium,
      providerMix: const ProviderMix(
        ideaProvider: 'openai',
        scriptProvider: 'openai',
        imageProvider: 'flux',
        videoProvider: 'runway',
        useSmartRouting: false,
      ),
      videoSettings: const VideoSettings(resolution: '4K', style: 'cinematic'),
      tags: ['Premium', 'Quality'],
    );

    await saveProject(freeStarter);
    await saveProject(cinematicPro);
  }
}
