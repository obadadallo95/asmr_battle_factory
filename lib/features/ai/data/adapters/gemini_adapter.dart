
import 'package:dio/dio.dart';
import '../../domain/models/unified_request.dart';
import '../../domain/models/provider_profile.dart';
import '../../data/provider_registry.dart';
import 'ai_provider_adapter.dart';

import 'package:injectable/injectable.dart';

@Named('gemini')
@Singleton(as: AIProviderAdapter)
class GeminiAdapter implements AIProviderAdapter {
  final Dio _dio;
  final ProviderRegistry _registry;
  String? _apiKey;

  GeminiAdapter(this._dio, this._registry);

  @override
  String get providerId => 'gemini';

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
        'https://generativelanguage.googleapis.com/v1beta/models?key=$_apiKey',
        options: Options(
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
      final model = request.modelId ?? 'gemini-1.5-flash';
      final contents = request.messages.map((m) {
        String role = m.role == 'assistant' ? 'model' : 'user';
        if (m.role == 'system') return null; // Gemini 1.0 handle system differently, usually via config. 1.5 supports system instruction.
        return {
          'role': role,
          'parts': [{'text': m.content}],
        };
      }).whereType<Map<String, dynamic>>().toList();

      if (contents.isEmpty) {
        contents.add({
          'role': 'user', 
          'parts': [{'text': request.prompt}]
        });
      }

      // Handle system instruction if present in messages
      final systemMessage = request.messages.where((m) => m.role == 'system').firstOrNull;

      final payload = {
        'contents': contents,
        'generationConfig': {
          'maxOutputTokens': request.maxTokens ?? 2048,
          'temperature': request.temperature ?? 0.7,
        }
      };
      
      if (systemMessage != null) {
         // for v1beta models with systemInstruction support
         payload['systemInstruction'] = {
           'parts': [{'text': systemMessage.content}]
         };
      }

      final response = await _dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$_apiKey',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: payload,
      );

      final data = response.data;
      if (data['candidates'] == null || (data['candidates'] as List).isEmpty) {
         throw AdapterException(providerId, 'No candidates returned');
      }

      final candidate = data['candidates'][0];
      final contentParts = candidate['content']['parts'] as List;
      final contentText = contentParts.map((p) => p['text']).join('\n');
      
      final usageMetadata = data['usageMetadata'] ?? {};

      return UnifiedResponse(
        content: contentText,
        inputTokens: usageMetadata['promptTokenCount'] ?? 0,
        outputTokens: usageMetadata['candidatesTokenCount'] ?? 0,
        latencyMs: 0, 
        providerId: providerId,
        modelUsed: model,
        finishReason: candidate['finishReason'],
      );

    } on DioException catch (e) {
       final msg = e.response?.data['error']['message'] ?? e.message;
      throw AdapterException(
        providerId, 
        msg ?? 'Unknown Gemini Error', 
        e.response?.statusCode
      );
    } catch (e) {
      throw AdapterException(providerId, e.toString());
    }
  }

  @override
  Stream<UnifiedResponse> generateStream(UnifiedRequest request) {
    throw UnimplementedError('Streaming not supported by Gemini');
  }
}
