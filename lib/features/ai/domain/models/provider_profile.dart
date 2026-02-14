import 'task_type.dart';

/// Represents the unique identifier for an AI provider.
enum AIProviderId {
  openai,
  groq,
  gemini,
  deepseek,
  anthropic,
  local,
}

/// Profile containing static capabilities and configurations for an AI provider.
class ProviderProfile {
  final String id;
  final String name;
  final String description;
  final Map<AITaskType, double> capabilityScores; // 0.0 to 1.0
  final CostProfile cost;
  final SpeedProfile speed;
  final List<String> supportedModels;
  final bool supportsStreaming;
  final bool supportsMultimodal;
  final bool supportsTools;

  const ProviderProfile({
    required this.id,
    required this.name,
    required this.description,
    required this.capabilityScores,
    required this.cost,
    required this.speed,
    required this.supportedModels,
    this.supportsStreaming = false,
    this.supportsMultimodal = false,
    this.supportsTools = false,
  });

  /// Calculate a weighted score for a specific task based on profile metrics.
  double getScoreForTask(AITaskType taskType) {
    return capabilityScores[taskType] ?? 0.5; // Default average score if not specified
  }
}

/// Profile defining the cost structure of a provider.
class CostProfile {
  final double inputPricePer1k; // In USD
  final double outputPricePer1k; // In USD
  final String tier; // 'low', 'medium', 'high', 'premium'

  const CostProfile({
    required this.inputPricePer1k,
    required this.outputPricePer1k,
    required this.tier,
  });

  /// Estimate cost for a given token usage.
  double estimateCost(int inputTokens, int outputTokens) {
    return (inputTokens / 1000 * inputPricePer1k) + 
           (outputTokens / 1000 * outputPricePer1k);
  }
}

/// Profile defining the expected performance characteristics.
class SpeedProfile {
  final double latencyScore; // 0.0 (slow) to 1.0 (instant)
  final int averageLatencyMs; // Typical response time
  final String tier; // 'ultra', 'fast', 'standard', 'slow'

  const SpeedProfile({
    required this.latencyScore,
    required this.averageLatencyMs,
    required this.tier,
  });
}

/// Metrics collected from real-world usage or benchmarks.
class PerformanceMetrics {
  final double successRate;
  final int avgLatencyMs;
  final double avgCostPerRequest;
  final int totalRequests;

  const PerformanceMetrics({
    this.successRate = 1.0,
    this.avgLatencyMs = 0,
    this.avgCostPerRequest = 0.0,
    this.totalRequests = 0,
  });
}
