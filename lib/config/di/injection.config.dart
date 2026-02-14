// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../core/services/app_logger.dart' as _i853;
import '../../core/services/haptic_service.dart' as _i689;
import '../../core/services/prompt_engineering/cinematic_engine.dart' as _i743;
import '../../core/services/security/api_key_service.dart' as _i6;
import '../../core/services/security/biometric_vault.dart' as _i521;
import '../../core/services/settings_service.dart' as _i328;
import '../../features/ai/data/adapters/ai_provider_adapter.dart' as _i149;
import '../../features/ai/data/adapters/deepseek_adapter.dart' as _i223;
import '../../features/ai/data/adapters/gemini_adapter.dart' as _i67;
import '../../features/ai/data/adapters/groq_adapter.dart' as _i577;
import '../../features/ai/data/adapters/openai_adapter.dart' as _i786;
import '../../features/ai/data/provider_registry.dart' as _i1019;
import '../../features/ai/data/providers/deepseek_provider.dart' as _i59;
import '../../features/ai/data/providers/groq_provider.dart' as _i677;
import '../../features/ai/data/providers/openai_provider.dart' as _i704;
import '../../features/ai/data/services/ai_initializer.dart' as _i513;
import '../../features/ai/data/services/ai_orchestrator.dart' as _i1012;
import '../../features/ai/data/services/smart_router.dart' as _i835;
import '../../features/ai/domain/providers/ai_provider.dart' as _i736;
import '../../features/budget/domain/repositories/budget_repository.dart'
    as _i438;
import '../../features/budget/domain/services/cost_calculator.dart' as _i543;
import '../../features/budget/domain/services/duration_calculator.dart'
    as _i576;
import '../../features/contestants/data/repositories/contestant_repository_impl.dart'
    as _i162;
import '../../features/contestants/domain/services/battle_suggester.dart'
    as _i786;
import '../../features/generator/data/providers/gemini_provider.dart' as _i650;
import '../../features/generator/data/repositories/generator_repository_impl.dart'
    as _i399;
import '../../features/generator/domain/repositories/generator_repository.dart'
    as _i560;
import '../../features/history/data/repositories/history_repository.dart'
    as _i590;
import '../../features/marketplace/data/provider_database.dart' as _i986;
import '../../features/marketplace/domain/repositories/provider_repository.dart'
    as _i844;
import '../../features/marketplace/domain/services/mixed_mode_orchestrator.dart'
    as _i681;
import '../../features/marketplace/domain/services/provider_recommender.dart'
    as _i997;
import '../../features/projects/data/repositories/project_repository.dart'
    as _i827;
import '../../features/vault/data/repositories/vault_repository.dart' as _i104;
import '../../features/vault/domain/services/multi_scenario_generator.dart'
    as _i585;
import 'modules/network_module.dart' as _i851;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    await gh.singletonAsync<_i328.SettingsService>(
      () {
        final i = _i328.SettingsService();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.singleton<_i6.APIKeyService>(() => _i6.APIKeyService());
    gh.singleton<_i689.HapticService>(() => _i689.HapticService());
    gh.singleton<_i743.CinematicEngine>(() => _i743.CinematicEngine());
    gh.singleton<_i853.AppLogger>(() => _i853.AppLogger());
    gh.singleton<_i361.Dio>(() => networkModule.dio);
    gh.singleton<_i827.ProjectRepository>(() => _i827.ProjectRepository());
    gh.singleton<_i681.MixedModeOrchestrator>(
        () => _i681.MixedModeOrchestrator());
    gh.singleton<_i1019.ProviderRegistry>(() => _i1019.ProviderRegistry());
    gh.singleton<_i590.HistoryRepository>(() => _i590.HistoryRepository());
    gh.singleton<_i104.VaultRepository>(() => _i104.VaultRepository());
    gh.singleton<_i576.DurationCalculator>(() => _i576.DurationCalculator());
    gh.singleton<_i844.IProviderRepository>(() => _i986.ProviderDatabase());
    gh.singleton<_i438.BudgetRepository>(() => _i438.BudgetRepositoryImpl());
    gh.lazySingleton<_i162.ContestantRepository>(
        () => _i162.ContestantRepositoryImpl());
    gh.singleton<_i149.AIProviderAdapter>(
      () => _i223.DeepSeekAdapter(
        gh<_i361.Dio>(),
        gh<_i1019.ProviderRegistry>(),
      ),
      instanceName: 'deepseek',
    );
    gh.singleton<_i149.AIProviderAdapter>(
      () => _i577.GroqAdapter(
        gh<_i361.Dio>(),
        gh<_i1019.ProviderRegistry>(),
      ),
      instanceName: 'groq',
    );
    gh.singleton<_i149.AIProviderAdapter>(
      () => _i786.OpenAIAdapter(
        gh<_i361.Dio>(),
        gh<_i1019.ProviderRegistry>(),
      ),
      instanceName: 'openai',
    );
    gh.singleton<_i521.BiometricVault>(
        () => _i521.BiometricVault(gh<_i853.AppLogger>()));
    gh.singleton<_i997.ProviderRecommender>(
        () => _i997.ProviderRecommender(gh<_i844.IProviderRepository>()));
    gh.singleton<_i149.AIProviderAdapter>(
      () => _i67.GeminiAdapter(
        gh<_i361.Dio>(),
        gh<_i1019.ProviderRegistry>(),
      ),
      instanceName: 'gemini',
    );
    gh.singleton<_i543.CostCalculator>(() => _i543.CostCalculator(
          gh<_i576.DurationCalculator>(),
          gh<_i844.IProviderRepository>(),
        ));
    gh.factory<_i736.AIProvider>(
      () => _i677.GroqProvider(
        gh<_i521.BiometricVault>(),
        gh<_i853.AppLogger>(),
      ),
      instanceName: 'groq',
    );
    gh.singleton<_i835.SmartRouter>(() => _i835.SmartRouter(
          gh<_i844.IProviderRepository>(),
          gh<_i6.APIKeyService>(),
          gh<_i853.AppLogger>(),
        ));
    gh.singleton<_i1012.AIOrchestrator>(() => _i1012.AIOrchestrator(
          gh<_i853.AppLogger>(),
          gh<_i743.CinematicEngine>(),
          gh<_i835.SmartRouter>(),
        ));
    gh.singleton<_i786.BattleSuggester>(
        () => _i786.BattleSuggester(gh<_i162.ContestantRepository>()));
    gh.factory<_i736.AIProvider>(
      () => _i704.OpenAIProvider(
        gh<_i521.BiometricVault>(),
        gh<_i853.AppLogger>(),
      ),
      instanceName: 'openai',
    );
    gh.factory<_i736.AIProvider>(
      () => _i59.DeepSeekProvider(
        gh<_i521.BiometricVault>(),
        gh<_i853.AppLogger>(),
      ),
      instanceName: 'deepseek',
    );
    gh.factory<_i736.AIProvider>(
      () => _i650.GeminiProvider(
        gh<_i521.BiometricVault>(),
        gh<_i853.AppLogger>(),
        gh<_i743.CinematicEngine>(),
      ),
      instanceName: 'gemini',
    );
    gh.lazySingleton<_i560.GeneratorRepository>(
        () => _i399.GeneratorRepositoryImpl(
              gh<_i1012.AIOrchestrator>(),
              gh<_i104.VaultRepository>(),
              gh<_i853.AppLogger>(),
            ));
    gh.singleton<_i513.AIInitializer>(() => _i513.AIInitializer(
          gh<_i835.SmartRouter>(),
          gh<_i521.BiometricVault>(),
          gh<_i853.AppLogger>(),
          gh<_i149.AIProviderAdapter>(instanceName: 'openai'),
          gh<_i149.AIProviderAdapter>(instanceName: 'groq'),
          gh<_i149.AIProviderAdapter>(instanceName: 'deepseek'),
          gh<_i149.AIProviderAdapter>(instanceName: 'gemini'),
        ));
    gh.singleton<_i585.MultiScenarioGenerator>(
        () => _i585.MultiScenarioGenerator(
              gh<_i1012.AIOrchestrator>(),
              gh<_i162.ContestantRepository>(),
            ));
    return this;
  }
}

class _$NetworkModule extends _i851.NetworkModule {}
