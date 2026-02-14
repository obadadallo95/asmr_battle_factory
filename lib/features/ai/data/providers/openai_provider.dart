import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/providers/ai_provider.dart';
import '../../../../core/services/security/biometric_vault.dart';
import '../../../../core/services/app_logger.dart';

@Named('openai')
@Injectable(as: AIProvider)
class OpenAIProvider implements AIProvider {
  final Dio _dio;
  final BiometricVault _vault;
  final AppLogger _logger;

  OpenAIProvider(this._vault, this._logger)
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://api.openai.com/v1',
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ));

  @override
  String get name => 'OpenAI';

  @override
  String get description => 'GPT-4o: Best for storytelling and complex narratives';

  @override
  Future<String> generateText(String prompt, {String? model = 'gpt-4o'}) async {
    final apiKey = await _vault.retrieveApiKey('openai', requireAuth: false);
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('OpenAI API Key is missing. Please add it in Settings.');
    }

    try {
      final response = await _dio.post(
        '/chat/completions',
        options: Options(headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        }),
        data: {
          'model': model ?? 'gpt-4o',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 1.0, 
        },
      );

      final content = response.data['choices']?[0]?['message']?['content'];
      if (content == null) throw Exception('Empty response from OpenAI');
      return content.toString();
    } on DioException catch (e) {
      _logger.e('OpenAI API Error', e);
      final msg = e.response?.data?['error']?['message'] ?? e.message;
      throw Exception('OpenAI Error: $msg');
    } catch (e) {
      _logger.e('Unexpected OpenAI Error', e);
      rethrow;
    }
  }

  @override
  Future<bool> isAvailable(String apiKey) async {
    try {
      final response = await _dio.get(
        '/models',
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
