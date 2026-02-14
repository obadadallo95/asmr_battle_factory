import 'package:asmr_battle_factory/features/generator/domain/entities/contestant.dart';

class MatchmakingEngine {
  bool areCompatible(Contestant a, Contestant b) {
    // Same category = Natural rivals (Ant vs Bee)
    if (a.category == b.category) return true;
    
    // Complementary categories = Dramatic contrast (Fire vs Ice)
    if (a.category == ContestantCategory.elements && 
        b.category == ContestantCategory.elements) {
      return true;
    }
    
    // Tech vs Nature
    if ((a.category == ContestantCategory.tech && b.category == ContestantCategory.wildAnimals) ||
        (b.category == ContestantCategory.tech && a.category == ContestantCategory.wildAnimals)) {
      return true;
    }
    
    // Metallic vs Elemental
    if ((a.category == ContestantCategory.metals && b.category == ContestantCategory.elements) ||
        (b.category == ContestantCategory.metals && a.category == ContestantCategory.elements)) {
      return true;
    }
      
    return false;
  }
  
  List<Contestant> suggestOpponents(Contestant selected, List<Contestant> pool) {
    final suggestions = pool
        .where((c) => c.id != selected.id)
        .where((c) => areCompatible(selected, c))
        .toList();
    
    suggestions.shuffle();
    return suggestions.take(5).toList();
  }
}
