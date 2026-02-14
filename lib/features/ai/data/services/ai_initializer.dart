
import 'package:injectable/injectable.dart';
import 'package:asmr_battle_factory/core/services/app_logger.dart';
import 'package:asmr_battle_factory/core/services/security/biometric_vault.dart';
import 'package:asmr_battle_factory/features/ai/data/adapters/ai_provider_adapter.dart';
import 'package:asmr_battle_factory/features/ai/data/services/smart_router.dart';

@singleton
class AIInitializer {
  final SmartRouter _router;
  final BiometricVault _vault;
  final AppLogger _logger;
  
  // Inject concrete adapters by name
  final AIProviderAdapter _openai;
  final AIProviderAdapter _groq;
  final AIProviderAdapter _deepseek;
  final AIProviderAdapter _gemini;

  AIInitializer(
    this._router,
    this._vault,
    this._logger,
    @Named('openai') this._openai,
    @Named('groq') this._groq,
    @Named('deepseek') this._deepseek,
    @Named('gemini') this._gemini,
  );

  /// Initialize all AI providers and register them with the router.
  Future<void> initialize() async {
    _logger.i('Initializing AI Conductor System...');

    await _initProvider(_openai, 'openai');
    await _initProvider(_groq, 'groq');
    await _initProvider(_deepseek, 'deepseek');
    await _initProvider(_gemini, 'gemini');

    _logger.i('AI Conductor System Initialized.');
  }

  Future<void> _initProvider(AIProviderAdapter adapter, String id) async {
    try {
      // 1. Retrieve API Key (No auth required for background init)
      final apiKey = await _vault.retrieveApiKey(id, requireAuth: false);
      
      if (apiKey != null && apiKey.isNotEmpty) {
        // 2. Initialize Adapter
        await adapter.initialize(apiKey);
        
        // 3. Register with Router
        _router.registerAdapter(adapter);
        _logger.d('Provider registered: $id');
      } else {
        _logger.w('Skipping provider $id: No API key found.');
      }
    } catch (e) {
      _logger.e('Failed to initialize provider $id', e);
    }
  }
}
