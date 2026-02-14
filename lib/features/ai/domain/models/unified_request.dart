import 'task_type.dart';

/// Standardized output format options.
enum OutputFormat {
  text,
  json,
  markdown,
  code,
}

/// A unified request object that works across all AI providers.
class UnifiedRequest {
  final String prompt;
  final List<AIMessage> messages;
  final AITaskType taskType;
  final OutputFormat format;
  final int? maxTokens;
  final double? temperature;
  final List<AITool>? tools;
  final String? modelId; // Optional override

  const UnifiedRequest({
    required this.prompt,
    this.messages = const [],
    required this.taskType,
    this.format = OutputFormat.text,
    this.maxTokens,
    this.temperature,
    this.tools,
    this.modelId,
  });

  /// Create a simple request from just a prompt.
  factory UnifiedRequest.simple(String prompt, AITaskType type) {
    return UnifiedRequest(
      prompt: prompt,
      taskType: type,
      messages: [AIMessage.user(prompt)],
    );
  }
}

/// A unified response object returned by all adapters.
class UnifiedResponse {
  final String content;
  final int inputTokens;
  final int outputTokens;
  final double latencyMs;
  final String providerId;
  final String modelUsed;
  final String? finishReason;
  final List<ToolCall>? toolCalls;

  const UnifiedResponse({
    required this.content,
    required this.inputTokens,
    required this.outputTokens,
    required this.latencyMs,
    required this.providerId,
    required this.modelUsed,
    this.finishReason,
    this.toolCalls,
  });
}

/// Represents a message in the conversation history.
class AIMessage {
  final String role; // 'user', 'assistant', 'system'
  final String content;

  const AIMessage({required this.role, required this.content});

  factory AIMessage.user(String content) => AIMessage(role: 'user', content: content);
  factory AIMessage.assistant(String content) => AIMessage(role: 'assistant', content: content);
  factory AIMessage.system(String content) => AIMessage(role: 'system', content: content);
}

/// Abstract representation of a tool/function the AI can call.
class AITool {
  final String name;
  final String description;
  final Map<String, dynamic> parameters;

  const AITool({
    required this.name,
    required this.description,
    required this.parameters,
  });
}

/// A request from the AI to execute a specific tool.
class ToolCall {
  final String id;
  final String name;
  final Map<String, dynamic> arguments;

  const ToolCall({
    required this.id,
    required this.name,
    required this.arguments,
  });
}
