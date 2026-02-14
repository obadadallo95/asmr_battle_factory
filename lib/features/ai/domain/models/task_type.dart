
/// Enum defining the different types of AI tasks.
enum AITaskType {
  creativeIdeation,      // Brainstorming, wild ideas (needs creativity)
  narrativeScripting,    // Story writing, dialogue (needs coherence)
  technicalPrompting,    // Image/video prompts (needs precision)
  analyticalReasoning,   // Logic, comparisons (needs accuracy)
  codeGeneration,        // Structured output (needs syntax)
  summarization,         // Condensing text (needs comprehension)
  generalChat,           // Fallback for general conversation
}

/// Context for the task to help with classification.
class TaskContext {
  final String? previousMessages;
  final bool requiresRealTime;
  final bool requiresMultimodal;

  TaskContext({
    this.previousMessages,
    this.requiresRealTime = false,
    this.requiresMultimodal = false,
  });
}

/// Engine to classify user prompts into specific task types.
class TaskClassifier {
  
  /// Classifies a user prompt into an [AITaskType].
  static AITaskType classify(String prompt, [TaskContext? context]) {
    final lowerPrompt = prompt.toLowerCase();

    // 1. Check for explicit code indicators
    if (lowerPrompt.contains('code') || 
        lowerPrompt.contains('function') || 
        lowerPrompt.contains('json') ||
        lowerPrompt.contains('flutter') ||
        lowerPrompt.contains('dart')) {
      return AITaskType.codeGeneration;
    }

    // 2. Check for summarization keywords
    if (lowerPrompt.startsWith('summarize') || 
        lowerPrompt.contains('summary') || 
        lowerPrompt.contains('tl;dr')) {
      return AITaskType.summarization;
    }

    // 3. Check for creative/brainstorming keywords
    if (lowerPrompt.contains('idea') || 
        lowerPrompt.contains('brainstorm') || 
        lowerPrompt.contains('concept') ||
        lowerPrompt.contains('imagine')) {
      return AITaskType.creativeIdeation;
    }

    // 4. Check for narrative/scripting keywords
    if (lowerPrompt.contains('script') || 
        lowerPrompt.contains('story') || 
        lowerPrompt.contains('dialogue') ||
        lowerPrompt.contains('scene')) {
      return AITaskType.narrativeScripting;
    }

    // 5. Check for technical prompting (image/video generation hints)
    if (lowerPrompt.contains('prompt for') || 
        lowerPrompt.contains('image of') || 
        lowerPrompt.contains('cinematic shot') ||
        lowerPrompt.contains('camera')) {
      return AITaskType.technicalPrompting;
    }

    // 6. Check for analytical/reasoning keywords
    if (lowerPrompt.contains('compare') || 
        lowerPrompt.contains('analyze') || 
        lowerPrompt.contains('logic') ||
        lowerPrompt.contains('why')) {
      return AITaskType.analyticalReasoning;
    }

    // Default to general chat if no specific pattern is matched
    return AITaskType.generalChat;
  }
}
