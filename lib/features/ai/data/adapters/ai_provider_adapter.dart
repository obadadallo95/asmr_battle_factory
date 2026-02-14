
import '../../domain/models/unified_request.dart';
import '../../domain/models/provider_profile.dart';

enum ConnectionStatus {
  connected,
  disconnected,
  checking,
  error
}

/// Abstract adapter that normalizes interactions with different AI providers.
abstract class AIProviderAdapter {
  /// Unique identifier of the provider (e.g., 'openai', 'groq').
  String get providerId;

  /// Returns the static profile capabilities of this provider.
  ProviderProfile get profile;

  /// Setup/Init the adapter (e.g., validate API key).
  Future<void> initialize(String apiKey);

  /// Check if the provider is currently available and functional.
  Future<bool> isAvailable();

  /// Explicit connectivity test returning status.
  Future<ConnectionStatus> testConnection();

  /// Generate a unified response from a unified request.
  Future<UnifiedResponse> generate(UnifiedRequest request);

  /// Generate a streaming response (optional implementation).
  Stream<UnifiedResponse> generateStream(UnifiedRequest request) {
    throw UnimplementedError('Streaming not supported by $providerId');
  }
}

class AdapterException implements Exception {
  final String providerId;
  final String message;
  final int? code;

  AdapterException(this.providerId, this.message, [this.code]);

  @override
  String toString() => 'AdapterException($providerId): $message (Code: $code)';
}
