import 'models/cost_models.dart';

/// Live API pricing (as of 2024/2025)
final defaultCosts = [
  // Text Generation
  APICostModel(
    providerId: 'groq', 
    modelName: 'llama-3.1-70b', 
    type: CostType.perToken, 
    inputCostPerUnit: 0.00000059, 
    outputCostPerUnit: 0.00000079,
    lastUpdated: DateTime(2025, 1, 1),
  ),
  APICostModel(
    providerId: 'openai', 
    modelName: 'gpt-4o', 
    type: CostType.perToken, 
    inputCostPerUnit: 0.000005, 
    outputCostPerUnit: 0.000015,
    lastUpdated: DateTime(2025, 1, 1),
  ),
  APICostModel(
    providerId: 'openai', 
    modelName: 'gpt-4o-mini', 
    type: CostType.perToken, 
    inputCostPerUnit: 0.00000015, 
    outputCostPerUnit: 0.0000006,
    lastUpdated: DateTime(2025, 1, 1),
  ),
  
  // Image Generation  
  APICostModel(
    providerId: 'flux', 
    modelName: 'flux-pro', 
    type: CostType.perImage, 
    inputCostPerUnit: 0.05, 
    outputCostPerUnit: 0,
    lastUpdated: DateTime(2025, 1, 1),
  ),
  APICostModel(
    providerId: 'pollinations', 
    modelName: 'free', 
    type: CostType.perImage, 
    inputCostPerUnit: 0, 
    outputCostPerUnit: 0,
    lastUpdated: DateTime(2025, 1, 1),
  ),
  
  // Video Generation (Most Expensive)
  APICostModel(
    providerId: 'runway', 
    modelName: 'gen-2', 
    type: CostType.perSecondVideo, 
    inputCostPerUnit: 0.20, 
    outputCostPerUnit: 0, // $0.20 per second!
    lastUpdated: DateTime(2025, 1, 1),
  ),
  APICostModel(
    providerId: 'kling', 
    modelName: 'kling-1.5', 
    type: CostType.perSecondVideo, 
    inputCostPerUnit: 0.12, 
    outputCostPerUnit: 0,
    lastUpdated: DateTime(2025, 1, 1),
  ),
  
  // Audio/TTS
  APICostModel(
    providerId: 'elevenlabs', 
    modelName: 'multilingual-v2', 
    type: CostType.perCharacter, 
    inputCostPerUnit: 0.00015, 
    outputCostPerUnit: 0,
    lastUpdated: DateTime(2025, 1, 1),
  ),
];
