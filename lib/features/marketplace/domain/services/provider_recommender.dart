import 'package:injectable/injectable.dart';
import '../entities/provider_catalog_entry.dart';
import '../repositories/provider_repository.dart';
import '../../../budget/domain/models/budget_mode.dart';

class Recommendation {
  final String ideaProvider;
  final String scriptProvider;
  final String imageProvider;
  final String? videoProvider;
  final double estimatedCost;
  final double qualityScore;
  final String message;
  final String messageAr;

  Recommendation({
    required this.ideaProvider,
    required this.scriptProvider,
    required this.imageProvider,
    this.videoProvider,
    required this.estimatedCost,
    required this.qualityScore,
    required this.message,
    required this.messageAr,
  });
}

@singleton
class ProviderRecommender {
  final IProviderRepository _repository;

  ProviderRecommender(this._repository);

  Recommendation suggest(BudgetMode mode) {
    switch (mode) {
      case BudgetMode.economy:
        return Recommendation(
          ideaProvider: 'groq',
          scriptProvider: 'groq',
          imageProvider: 'pollinations',
          videoProvider: null,
          estimatedCost: 0.01,
          qualityScore: 7.5,
          message: '100% Free Mix - Perfect for beginners',
          messageAr: 'مزيج مجاني 100% - مثالي للبداية',
        );
      
      case BudgetMode.balanced:
        return Recommendation(
          ideaProvider: 'groq',
          scriptProvider: 'deepseek',
          imageProvider: 'pollinations',
          videoProvider: 'kling',
          estimatedCost: 1.50,
          qualityScore: 8.8,
          message: 'Optimal Balance - High speed, low cost',
          messageAr: 'توازن مثالي - سرعة عالية وتكلفة منخفضة',
        );

      case BudgetMode.premium:
        return Recommendation(
          ideaProvider: 'openai',
          scriptProvider: 'openai',
          imageProvider: 'flux',
          videoProvider: 'runway',
          estimatedCost: 4.50,
          qualityScore: 9.8,
          message: 'Absolute Premium - Max quality possible',
          messageAr: 'أقصى جودة ممكنة - مخصص للمحترفين',
        );

      case BudgetMode.custom:
        return Recommendation(
          ideaProvider: 'gemini',
          scriptProvider: 'mistral',
          imageProvider: 'leonardo',
          videoProvider: 'pika',
          estimatedCost: 2.50,
          qualityScore: 8.5,
          message: 'Alternative Mix - Broad context & unique style',
          messageAr: 'مزيج بديل - سياق واسع وأسلوب فريد',
        );
    }
  }

  /// Get specific provider details for the recommendation
  List<ProviderCatalogEntry> getProviderEntries(Recommendation rec) {
    final list = <ProviderCatalogEntry>[];
    
    final idea = _repository.getById(rec.ideaProvider);
    if (idea != null) list.add(idea);
    
    final script = _repository.getById(rec.scriptProvider);
    if (script != null) list.add(script);
    
    final image = _repository.getById(rec.imageProvider);
    if (image != null) list.add(image);
    
    if (rec.videoProvider != null) {
      final video = _repository.getById(rec.videoProvider!);
      if (video != null) list.add(video);
    }
    
    return list;
  }
}
