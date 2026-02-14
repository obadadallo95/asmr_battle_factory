import 'package:freezed_annotation/freezed_annotation.dart';

part 'cost_models.freezed.dart';
part 'cost_models.g.dart';

enum CostType { 
  perToken, 
  perImage, 
  perSecondVideo, 
  perRequest, 
  perCharacter 
}

@freezed
class APICostModel with _$APICostModel {
  const factory APICostModel({
    required String providerId, // 'openai', 'runway', 'flux'
    required String modelName, // 'gpt-4o', 'gen-2', etc.
    required CostType type, // perToken, perImage, perSecond, perRequest
    required double inputCostPerUnit, // USD
    required double outputCostPerUnit, // USD (if applicable)
    @Default('USD') String currency, // USD (default)
    required DateTime lastUpdated, // For price updates
  }) = _APICostModel;

  factory APICostModel.fromJson(Map<String, dynamic> json) => _$APICostModelFromJson(json);
}
