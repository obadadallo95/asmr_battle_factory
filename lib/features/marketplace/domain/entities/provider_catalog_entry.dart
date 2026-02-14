import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'provider_catalog_entry.freezed.dart';
part 'provider_catalog_entry.g.dart';

/// Provider tier classification
enum ProviderTier {
  @JsonValue('free')
  free,           // Completely free (Pollinations, Groq free tier)
  
  @JsonValue('freemium')
  freemium,       // Free tier + paid upgrade (Gemini, OpenAI)
  
  @JsonValue('paid')
  paid,           // Pay-per-use only (Runway, Midjourney)
  
  @JsonValue('open_source')
  openSource,     // Self-hosted/local (Ollama, Stable Diffusion)
}

/// AI provider function category
enum ProviderFunction {
  @JsonValue('text_generation')
  textGeneration,     // LLMs for scripts/ideas
  
  @JsonValue('image_generation')
  imageGeneration,    // Flux, Midjourney, DALL-E
  
  @JsonValue('video_generation')
  videoGeneration,    // Runway, Kling, Pika
  
  @JsonValue('audio_generation')
  audioGeneration,    // ElevenLabs, Azure TTS
  
  @JsonValue('music_generation')
  musicGeneration,    // Suno, Udio
  
  @JsonValue('voice_cloning')
  voiceCloning,       // ElevenLabs Voice Clone
  
  @JsonValue('upscaling')
  upscaling,          // Topaz, Magnific AI
  
  @JsonValue('face_swap')
  faceSwap,           // Roop, FaceSwapper
  
  @JsonValue('subtitle_generation')
  subtitleGeneration, // Whisper, Deepgram
}

/// Setup difficulty level
enum SetupDifficulty {
  @JsonValue('easy')
  easy,     // Just paste API key
  
  @JsonValue('medium')
  medium,   // API key + configuration
  
  @JsonValue('hard')
  hard,     // Complex setup, webhooks, etc.
}

@freezed
class ProviderCatalogEntry with _$ProviderCatalogEntry {
  const factory ProviderCatalogEntry({
    required String id,                    // 'openai', 'runway', 'pollinations'
    required String name,
    required String nameAr,
    required ProviderFunction function,
    required ProviderTier tier,
    
    // Visual identity
    String? logoAsset,
    @Default('#6366F1') String brandColor,
    
    // Pricing transparency
    String? freeTierDescription,   // "1,000 tokens/day free"
    String? paidPricing,           // "$0.20 per second"
    required String websiteUrl,
    String? signupUrl,
    String? docsUrl,
    
    // Structured Pricing
    double? costPerInputUnit,      // USD per token/image/second
    double? costPerOutputUnit,     // USD per token
    @Default(1000) int unitQuantity, // 1000 for tokens, 1 for others
    
    // Capabilities
    @Default(false) bool supportsStreaming,
    @Default(false) bool supportsBatch,
    int? maxContextLength,
    @Default([]) List<String> supportedModels,
    
    // Quality ratings (1.0-5.0 stars)
    @Default(3.0) double qualityRating,         // For this specific function
    @Default(3.0) double speedRating,
    @Default(3.0) double costEfficiencyRating,
    
    // Special features
    @Default(false) bool requiresCreditCard,      // For free tier
    @Default(true) bool availableInSyria,        // Geo-restrictions
    String? alternativeFor,       // If banned, use this instead
    @Default(SetupDifficulty.easy) SetupDifficulty setupDifficulty,
    @Default(true) bool requiresKey,
  }) = _ProviderCatalogEntry;

  factory ProviderCatalogEntry.fromJson(Map<String, dynamic> json) =>
      _$ProviderCatalogEntryFromJson(json);
}

extension ProviderCatalogEntryX on ProviderCatalogEntry {
  Color get brandColorValue => Color(int.parse(brandColor.replaceFirst('#', '0xFF')));
  
  String get tierLabel {
    switch (tier) {
      case ProviderTier.free: return 'مجاني';
      case ProviderTier.freemium: return 'Freemium';
      case ProviderTier.paid: return 'مدفوع';
      case ProviderTier.openSource: return 'Open Source';
    }
  }
  
  IconData get tierIcon {
    switch (tier) {
      case ProviderTier.free: return Icons.card_giftcard;
      case ProviderTier.freemium: return Icons.layers;
      case ProviderTier.paid: return Icons.monetization_on;
      case ProviderTier.openSource: return Icons.code;
    }
  }
}
