abstract class AIProvider {
  String get name;
  String get description;
  
  /// Generates text content based on the prompt.
  /// [model] is optional, allows overriding the default model.
  Future<String> generateText(String prompt, {String? model});
  
  /// Checks if the provider is available (e.g. valid API key).
  Future<bool> isAvailable(String apiKey);
}
