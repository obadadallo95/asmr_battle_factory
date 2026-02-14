
import 'package:dio/dio.dart';
import '../../domain/models/unified_request.dart';
import '../../domain/models/provider_profile.dart';
import '../../data/provider_registry.dart';
import 'ai_provider_adapter.dart';

import 'package:injectable/injectable.dart';

@Named('groq')
@Singleton(as: AIProviderAdapter)
class GroqAdapter implements AIProviderAdapter {
  final Dio _dio;
  final ProviderRegistry _registry;
  String? _apiKey;

  GroqAdapter(this._dio, this._registry);

  @override
  String get providerId => 'groq';

  @override
  ProviderProfile get profile => _registry.getProfile(providerId)!;

  @override
  Future<void> initialize(String apiKey) async {
    _apiKey = apiKey;
  }

  @override
  Future<bool> isAvailable() async {
    return _apiKey != null && _apiKey!.isNotEmpty;
  }

  @override
  Future<ConnectionStatus> testConnection() async {
    if (_apiKey == null || _apiKey!.isEmpty) return ConnectionStatus.disconnected;
    
    try {
      final response = await _dio.get(
        'https://api.groq.com/openai/v1/models',
        options: Options(
          headers: {'Authorization': 'Bearer $_apiKey'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      
      if (response.statusCode == 200) {
        return ConnectionStatus.connected;
      }
      return ConnectionStatus.error;
    } catch (e) {
      return ConnectionStatus.error; 
    }
  }

  @override
  Future<UnifiedResponse> generate(UnifiedRequest request) async {
    if (_apiKey == null) {
      throw AdapterException(providerId, 'API Key not initialized', 401);
    }

    try {
      final model = request.modelId ?? 'llama3-70b-8192';
      final messages = request.messages.map((m) => {
        'role': m.role,
        'content': m.content,
      }).toList();

      if (messages.isEmpty) {
        messages.add({'role': 'user', 'content': request.prompt});
      }

      final response = await _dio.post(
        'https://api.groq.com/openai/v1/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': model,
          'messages': messages,
          'max_tokens': request.maxTokens ?? 2048,
          'temperature': request.temperature ?? 0.7,
        },
      );

      final data = response.data;
      final choice = data['choices'][0];
      final content = choice['message']['content'] as String;
      final usage = data['usage'];

      return UnifiedResponse(
        content: content,
        inputTokens: usage['prompt_tokens'] ?? 0,
        outputTokens: usage['completion_tokens'] ?? 0,
        latencyMs: 0, 
        providerId: providerId,
        modelUsed: data['model'] ?? model,
        finishReason: choice['finish_reason'],
      );

    } on DioException catch (e) {
      throw AdapterException(
        providerId, 
        e.response?.data['error']['message'] ?? e.message, 
        e.response?.statusCode
      );
    } catch (e) {
      throw AdapterException(providerId, e.toString());
    }
  }

  @override
  Stream<UnifiedResponse> generateStream(UnifiedRequest request) {
    throw UnimplementedError('Streaming not supported by groq');
  }
}
