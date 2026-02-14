import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/providers/ai_provider.dart';
import '../../../../core/services/security/biometric_vault.dart';
import '../../../../core/services/app_logger.dart';

@Named('deepseek')
@Injectable(as: AIProvider)
class DeepSeekProvider implements AIProvider {
  final Dio _dio;
  final BiometricVault _vault;
  final AppLogger _logger;

  DeepSeekProvider(this._vault, this._logger)
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://api.deepseek.com',
          connectTimeout: const Duration(seconds: 45),
          receiveTimeout: const Duration(seconds: 45),
        ));

  @override
  String get name => 'DeepSeek';

  @override
  String get description => 'DeepSeek V3: Excellent reasoning capabilities';

  @override
  Future<String> generateText(String prompt, {String? model}) async {
    final apiKey = await _vault.retrieveApiKey('deepseek', requireAuth: false);
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('DeepSeek API Key is missing. Please add it in Settings.');
    }

    try {
      final response = await _dio.post(
        '/chat/completions',
        options: Options(headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        }),
        data: {
          'model': model ?? 'deepseek-chat',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 1.0, 
        },
      );

      final content = response.data['choices']?[0]?['message']?['content'];
      if (content == null) throw Exception('Empty response from DeepSeek');
      return content.toString();
    } on DioException catch (e) {
      _logger.e('DeepSeek API Error', e);
      final msg = e.response?.data?['error']?['message'] ?? e.message;
      throw Exception('DeepSeek Error: $msg');
    } catch (e) {
      _logger.e('Unexpected DeepSeek Error', e);
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
