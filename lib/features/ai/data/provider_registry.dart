
import 'package:injectable/injectable.dart';
import '../domain/models/provider_profile.dart';
import '../domain/models/task_type.dart';

/// Registry of all known AI providers and their capabilities.
@singleton
class ProviderRegistry {
  final Map<String, ProviderProfile> _profiles = {};

  ProviderRegistry() {
    _registerDefaults();
  }

  /// Register default provider profiles.
  void _registerDefaults() {
    // 1. OpenAI (The All-Rounder, High Quality, Expensive)
    _profiles['openai'] = const ProviderProfile(
      id: 'openai',
      name: 'OpenAI (GPT-4o)',
      description: 'High intelligence, best for complex storytelling and creative writing.',
      capabilityScores: {
        AITaskType.narrativeScripting: 0.95,
        AITaskType.codeGeneration: 0.9,
        AITaskType.creativeIdeation: 0.85,
        AITaskType.analyticalReasoning: 0.9,
        AITaskType.technicalPrompting: 0.85,
      },
      cost: CostProfile(
        inputPricePer1k: 0.005, // Approximation
        outputPricePer1k: 0.015,
        tier: 'premium',
      ),
      speed: SpeedProfile(
        latencyScore: 0.6,
        averageLatencyMs: 1500,
        tier: 'standard',
      ),
      supportedModels: ['gpt-4o', 'gpt-4o-mini'],
      supportsStreaming: true,
      supportsMultimodal: true,
      supportsTools: true,
    );

    // 2. Groq (The Speedster, Creative, Cheap)
    _profiles['groq'] = const ProviderProfile(
      id: 'groq',
      name: 'Groq (Llama 3)',
      description: 'Ultra-fast inference, perfect for brainstorming and real-time ideas.',
      capabilityScores: {
        AITaskType.creativeIdeation: 0.9,
        AITaskType.summarization: 0.85,
        AITaskType.generalChat: 0.8,
        AITaskType.narrativeScripting: 0.7, // Good, but less coherent than GPT-4
      },
      cost: CostProfile(
        inputPricePer1k: 0.0001, 
        outputPricePer1k: 0.0001,
        tier: 'low',
      ),
      speed: SpeedProfile(
        latencyScore: 0.98,
        averageLatencyMs: 200, // Blazing fast
        tier: 'ultra',
      ),
      supportedModels: ['llama3-70b-8192', 'mixtral-8x7b-32768'],
      supportsStreaming: true,
    );

    // 3. Gemini (The Multimodal Specialist)
    _profiles['gemini'] = const ProviderProfile(
      id: 'gemini',
      name: 'Gemini 1.5 Flash',
      description: 'Balanced performance, specializes in multimodal and long context.',
      capabilityScores: {
        AITaskType.technicalPrompting: 0.9, // Great for describing images/video
        AITaskType.summarization: 0.9, // Long context window
        AITaskType.analyticalReasoning: 0.85,
      },
      cost: CostProfile(
        inputPricePer1k: 0.00035,
        outputPricePer1k: 0.00105,
        tier: 'medium',
      ),
      speed: SpeedProfile(
        latencyScore: 0.8,
        averageLatencyMs: 800,
        tier: 'fast',
      ),
      supportedModels: ['gemini-1.5-flash', 'gemini-1.5-pro'],
      supportsStreaming: true,
      supportsMultimodal: true,
    );

    // 4. DeepSeek (The Reasoner, Cheap)
    _profiles['deepseek'] = const ProviderProfile(
      id: 'deepseek',
      name: 'DeepSeek V3',
      description: 'Cost-effective reasoning model, great for logic and code.',
      capabilityScores: {
        AITaskType.analyticalReasoning: 0.9,
        AITaskType.codeGeneration: 0.9,
        AITaskType.technicalPrompting: 0.8,
      },
      cost: CostProfile(
        inputPricePer1k: 0.0002, 
        outputPricePer1k: 0.0002,
        tier: 'low',
      ),
      speed: SpeedProfile(
        latencyScore: 0.7,
        averageLatencyMs: 1000,
        tier: 'standard',
      ),
      supportedModels: ['deepseek-chat', 'deepseek-reasoner'],
      supportsStreaming: true,
    );
  }

  /// Get a profile by provider ID.
  ProviderProfile? getProfile(String id) => _profiles[id];

  /// Get all registered profiles.
  List<ProviderProfile> getAllProfiles() => _profiles.values.toList();
}
