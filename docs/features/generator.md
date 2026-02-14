# Generator Feature

## Purpose
The core engine of the app. It takes user input (4 items) and generates a cinematic battle script.

## Key Components
1. **CinematicEngine**: 
   - Service class responsible for crafting the perfect prompt.
   - Assigns archetypes (e.g., "The Giant", "The Swarm") to contestants.
   - Selects a battle template (Nature, Elements, Objects).

2. **GeminiProvider**:
   - Handles communication with Google's Gemini API.
   - Parses the JSON response into a `BattleScript` object.
   - Handles errors and rate limits.

3. **GeneratorController (Riverpod)**:
   - Manages the UI state (`Input`, `Loading`, `Success`, `Error`).
   - Streams "Director Logs" to the UI during generation.

## Data Flow
1. User selects 4 items in `ContestantSelector`.
2. Controller calls `GeneratorRepository`.
3. Repository checks Hive cache.
4. If not cached, Repository calls `GeminiProvider`.
5. Provider uses `CinematicEngine` to create prompt.
6. API returns JSON.
7. Data is parsed, cached, and returned to UI.
