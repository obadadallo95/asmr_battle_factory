import 'package:hive_flutter/hive_flutter.dart';

part 'budget_mode.g.dart';

@HiveType(typeId: 50)
enum BudgetMode {
  @HiveField(0)
  economy,    // Groq + Pollinations (Free images) + No video (images only)
  @HiveField(1)
  balanced,   // Groq + Flux + Shorter video
  @HiveField(2)
  premium,    // OpenAI + Flux + Runway (Full quality)
  @HiveField(3)
  custom,     // User manually selects providers
}

class ProviderStack {
  final String ideaProvider;
  final String scriptProvider;
  final String imageProvider;
  final String? videoProvider;
  final (double, double) estimatedCostRange;

  const ProviderStack({
    required this.ideaProvider,
    required this.scriptProvider,
    required this.imageProvider,
    this.videoProvider,
    required this.estimatedCostRange,
  });
}

extension BudgetModeConfig on BudgetMode {
  ProviderStack get recommendedStack {
    switch(this) {
      case BudgetMode.economy:
        return const ProviderStack(
          ideaProvider: 'groq',
          scriptProvider: 'groq',
          imageProvider: 'pollinations', // Free!
          videoProvider: null, // No video generation, slideshow only
          estimatedCostRange: (0.01, 0.10), // $0.01 - $0.10
        );
      case BudgetMode.balanced:
        return const ProviderStack(
          ideaProvider: 'groq',
          scriptProvider: 'openai', // GPT-4o-mini maybe? Or mix
          imageProvider: 'flux',
          videoProvider: 'kling',
          estimatedCostRange: (0.50, 1.50),
        );
      case BudgetMode.premium:
        return const ProviderStack(
          ideaProvider: 'openai',
          scriptProvider: 'openai',
          imageProvider: 'flux',
          videoProvider: 'runway',
          estimatedCostRange: (2.00, 5.00),
        );
      case BudgetMode.custom:
         return const ProviderStack(
          ideaProvider: 'openai', 
          scriptProvider: 'openai', 
          imageProvider: 'flux', 
          videoProvider: 'runway', 
          estimatedCostRange: (0, 0),
        );
    }
  }
  
  String get label {
    switch(this) {
      case BudgetMode.economy: return "Economy 💚";
      case BudgetMode.balanced: return "Balanced 💛";
      case BudgetMode.premium: return "Premium ❤️";
      case BudgetMode.custom: return "Custom ⚙️";
    }
  }
}
