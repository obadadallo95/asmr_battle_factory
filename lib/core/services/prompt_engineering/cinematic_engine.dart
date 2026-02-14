// Lines: 120/300
import 'package:injectable/injectable.dart';
import '../../../features/generator/domain/entities/contestant.dart';

@singleton
class CinematicEngine {
  
  String craftCinematicPrompt(List<Contestant> contestants) {
    final archetype1 = _assignArchetype(contestants[0]);
    final archetype2 = _assignArchetype(contestants[1]);
    
    final template = _determineTemplate(contestants);
    
    return '''
    ACT AS A HOLLYWOOD CINEMATOGRAPHER AND DIRECTOR FOR A HIGH-BUDGET ASMR BATTLE VIDEO.
    
    ** CONTESTANTS **
    1. ${contestants[0].nameEn} (Strength: ${contestants[0].powerLevel}/10) - Archetype: $archetype1
    2. ${contestants[1].nameEn} (Strength: ${contestants[1].powerLevel}/10) - Archetype: $archetype2
    
    ** CONTEXT & TONE **
    Template: ${template.name}
    Style: Photorealistic, 8k, Unreal Engine 5 render, Macro Photography.
    Audio Focus: Binaural, crisp, crunchy, impactful.
    
    ** THREE ACT STRUCTURE (4 Scenes Total) **
    - Scene 1: Act 1 - Introduction & Rising Tension (Establishing shots, sizing up).
    - Scene 2: Act 2 - Engagement (First strike, slow-motion impact).
    - Scene 3: Act 2 - Climax (Chaos, debris, elemental reaction).
    - Scene 4: Act 3 - Resolution (The aftermath, winner revealed, dust settling).
    
    ** OUTPUT FORMAT (Strict JSON) **
    Return valid JSON with this exact structure:
    {
      "title": "Arabic Title Here",
      "winner": "Name of Winner",
      "suggested_hashtags": ["#asmr", "#battle", ...],
      "scenes": [
        {
          "title": "Scene 1 Title in Arabic",
          "visual_description": "Detailed prompt for Runway Gen-2. Lighting, camera angle, texture focus.",
          "motion_prompt": "Specific camera movement (e.g. Slow push in, Truck left, Orbit). Physics description.",
          "audio_cue": "Detailed ASMR audio description (e.g. Crunching chitin, sizzling fire, deep bass rumble).",
          "duration_seconds": 5
        },
        ... (Total 4 scenes)
      ]
    }
    
    ** RULES **
    1. "visual_description" MUST be in English, optimized for AI Video generation.
    2. "title" MUST be in Arabic.
    3. Make it VISCERAL. Focus on textures (slime, fur, metal, fire).
    ''';
  }

  String _assignArchetype(Contestant c) {
    // Simple logic based on name/strength/type
    if (c.powerLevel > 8) return "The Unstoppable Titan";
    if (c.powerLevel < 4) return "The Underdog";
    
    switch (c.category) {
      case ContestantCategory.insects: return "The Hive Mind";
      case ContestantCategory.wildAnimals: return "The Apex Predator";
      case ContestantCategory.metals: return "The Immovable Object";
      case ContestantCategory.stationery: return "The Precision Tool";
      case ContestantCategory.elements: return "The Force of Nature";
      case ContestantCategory.tech: return "The Calculated Machine";
      case ContestantCategory.mythical: return "The Legend";
      case ContestantCategory.all:
      default: return "The Wildcard";
    }
  }

  _BattleTemplate _determineTemplate(List<Contestant> contestants) {
    final categories = contestants.map((c) => c.category).toSet();
    
    if (categories.contains(ContestantCategory.stationery)) {
      return _BattleTemplate.objectDrama;
    }
    if (categories.contains(ContestantCategory.insects) || categories.contains(ContestantCategory.wildAnimals)) {
      return _BattleTemplate.natureWars;
    }
    if (categories.contains(ContestantCategory.elements) || categories.contains(ContestantCategory.tech)) {
       return _BattleTemplate.elementalClash;
    }
    return _BattleTemplate.elementalClash; // Default fallout
  }
}

enum _BattleTemplate {
  natureWars,
  elementalClash,
  objectDrama,
}
