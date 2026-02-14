import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:asmr_battle_factory/core/services/app_logger.dart';
import 'package:asmr_battle_factory/core/services/security/biometric_vault.dart';
import 'package:asmr_battle_factory/core/services/prompt_engineering/cinematic_engine.dart';
import 'package:asmr_battle_factory/core/errors/failures.dart';
import 'package:asmr_battle_factory/features/generator/data/models/battle_script_model.dart';
import 'package:asmr_battle_factory/features/generator/domain/entities/contestant.dart';
import 'package:asmr_battle_factory/features/ai/domain/providers/ai_provider.dart';

@Named('gemini')
@Injectable(as: AIProvider)
class GeminiProvider implements AIProvider {
  final Dio _dio;
  final BiometricVault _vault;
  final AppLogger _logger;
  final CinematicEngine _cinematicEngine;

  GeminiProvider(
    this._vault,
    this._logger,
    this._cinematicEngine,
  ) : _dio = Dio(BaseOptions(
          baseUrl: 'https://generativelanguage.googleapis.com/v1beta',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ));

  @override
  String get name => 'Gemini';

  @override
  String get description => 'Gemini 1.5 Flash: Best for multimodal and video prompts';

  @override
  Future<String> generateText(String prompt, {String? model}) async {
    final apiKey = await _vault.retrieveApiKey('gemini', requireAuth: false);
    if (apiKey == null || apiKey.isEmpty) {
      throw const ServerFailure('Gemini API Key is missing. Please add it in Settings.');
    }

    try {
      final response = await _dio.post(
        '/models/${model ?? 'gemini-1.5-flash'}:generateContent?key=$apiKey',
        data: {
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ],
          "generationConfig": {
            "temperature": 1.0,
            "maxOutputTokens": 2048,
          }
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final String? rawText = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        
        if (rawText == null) {
          throw const ServerFailure('Empty response from Gemini');
        }
        return rawText;
      } else {
        throw ServerFailure('Gemini Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _logger.e('DioException calling Gemini', e);
      final message = e.response?.data?['error']?['message'] ?? e.message;
      throw ServerFailure('Network Error: $message');
    } catch (e, stack) {
      _logger.e('Unexpected error in GeminiProvider', e, stack);
      throw ServerFailure(e.toString());
    }
  }

  // Deprecated/Legacy method - kept for temporary compatibility or refactored to use generateText
  Future<BattleScriptModel> generateCinematicBattle(List<String> contestants) async {
     // Temporary: Create contestant objects
    // Temporary: Create contestant objects
    final contestantObjects = contestants.map((name) => 
      Contestant(
        id: 'temp', 
        nameAr: name, 
        nameEn: name, 
        category: ContestantCategory.wildAnimals, 
        iconAsset: '❓', 
        strengths: [], 
        weaknesses: [], 
        powerLevel: 5
      )
    ).toList();

    final prompt = _cinematicEngine.craftCinematicPrompt(contestantObjects);
    _logger.i('Generating cinematic battle with Gemini for: $contestants');
    
    final rawText = await generateText(prompt);
    final jsonText = _cleanJson(rawText);
    
    try {
       final jsonMap = jsonDecode(jsonText);
       return BattleScriptModel.fromJson(jsonMap);
    } catch (e) {
      _logger.e('JSON Parsing Error', e);
      throw const ServerFailure('Failed to parse battle script');
    }
  }

  @override
  Future<bool> isAvailable(String apiKey) async {
    try {
      final response = await _dio.get(
        '/models',
        queryParameters: {'key': apiKey},
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  String _cleanJson(String text) {
    return text.replaceAll('```json', '').replaceAll('```', '').trim();
  }
}
