# 🧠 Multi-Model Orchestration

The ASMR Battle Factory is designed to be model-agnostic. It can route tasks to different Large Language Models (LLMs) and visual engines based on user preference or task complexity.

## Orchestration Logic
All AI requests flow through the `AIOchestrator` service, which acts as a traffic controller.

### 1. LLM Selection
The app identifies the best model for the current task:
- **Ideation (Vault)**: Uses faster, lower-cost models like `Gemini-1.5-Flash` or `Llama-3-8B`.
- **Cinematic Scripting**: Uses high-reasoning models like `Gemini-1.5-Pro` or `GPT-4o` to ensure dramatic depth and consistency.

### 2. Prompt Engineering (`CinematicEngine`)
The `CinematicEngine` is responsible for transforming raw contestant data into a narrative-rich prompt:
- **Archetype Mapping**: Assigns roles (e.g., "The Brute", "The Silent Stalker").
- **Environment Synthesis**: Merges the selected visual style with battle mechanics.
- **Emotional Pacing**: Instructs the AI to build tension before the final reveal.

## Provider Adapters
Each provider (Google, Groq, OpenAI) has a corresponding adapter that implements the `IAIProvider` interface:
- **`GeminiProvider`**: Direct SDK integration with Google's Generative AI.
- **`GroqProvider`**: Open-weights orchestration (Llama, Mixtral) with lightning-fast inference.
- **`OpenAIProvider`**: Standard GPT integration.

## Future Visual Orchestration
The architecture is prepared for **Image & Video Orchestration**:
- **Visual Synthesis**: Routing image prompts to DALL-E 3 or Flux.
- **Motion Mapping**: Routing cinematic descriptions to Runway or Luma for video generation.
