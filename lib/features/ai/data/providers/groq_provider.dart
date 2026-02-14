import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/providers/ai_provider.dart';
import '../../../../core/services/security/biometric_vault.dart';
import '../../../../core/services/app_logger.dart';

@Named('groq')
@Injectable(as: AIProvider)
class GroqProvider implements AIProvider {
  final Dio _dio;
  final BiometricVault _vault;
  final AppLogger _logger;

  GroqProvider(this._vault, this._logger)
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://api.groq.com/openai/v1',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ));

  @override
  String get name => 'Groq';

  @override
  String get description => 'Llama 3: Fastest inference, great for brainstorming ideas';

  @override
  Future<String> generateText(String prompt, {String? model}) async {
    final apiKey = await _vault.retrieveApiKey('groq', requireAuth: false);
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Groq API Key is missing. Please add it in Settings.');
    }

    try {
      final response = await _dio.post(
        '/chat/completions',
        options: Options(headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        }),
        data: {
          'model': model ?? 'llama-3.1-70b-versatile',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7, 
        },
      );

      final content = response.data['choices']?[0]?['message']?['content'];
      if (content == null) throw Exception('Empty response from Groq');
      return content.toString();
    } on DioException catch (e) {
      _logger.e('Groq API Error', e);
      final msg = e.response?.data?['error']?['message'] ?? e.message;
      throw Exception('Groq Error: $msg');
    } catch (e) {
      _logger.e('Unexpected Groq Error', e);
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
