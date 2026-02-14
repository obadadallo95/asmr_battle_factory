// Lines: 25/30
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'config/di/injection.dart';
import 'features/marketplace/domain/repositories/provider_repository.dart';
import 'features/ai/data/services/ai_initializer.dart';
import 'app.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'features/generator/data/models/scene_model.dart';
import 'features/generator/data/models/battle_script_model.dart';
import 'features/projects/data/models/battle_project.dart';
import 'features/projects/data/repositories/project_repository.dart';
import 'features/configurator/data/models/battle_config.dart';
import 'features/vault/data/models/saved_scenario.dart';
import 'features/vault/data/repositories/vault_repository.dart';
import 'features/budget/domain/models/budget_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  // Hive Setup (Must be before DI because SettingsService uses it)
  await Hive.initFlutter();
  
  Hive.registerAdapter(SceneModelAdapter());
  Hive.registerAdapter(BattleScriptModelAdapter());
  Hive.registerAdapter(BattleProjectImplAdapter());
  Hive.registerAdapter(ProviderMixImplAdapter());
  Hive.registerAdapter(VideoSettingsImplAdapter());
  Hive.registerAdapter(BudgetModeAdapter());
  
  // New Adapters for Battle Arena & Vault
  Hive.registerAdapter(WinnerModeAdapter());
  Hive.registerAdapter(BattleTypeAdapter());
  Hive.registerAdapter(BattleConfigImplAdapter());
  Hive.registerAdapter(SavedScenarioImplAdapter());
  
  // Open boxes after registering adapters
  await Hive.openBox('settings');
  await Hive.openBox('operations');
  
  await configureDependencies();
  
  // Initialize ProviderDatabase (must be done before using MarketPlace or Generator)
  await getIt<IProviderRepository>().initialize();
  
  // Initialize AI Conductor & Repositories
  await getIt<AIInitializer>().initialize();
  await getIt<ProjectRepository>().init();
  await getIt<VaultRepository>().init();


  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/l10n',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      child: const ProviderScope(child: App()),
    ),
  );
}
