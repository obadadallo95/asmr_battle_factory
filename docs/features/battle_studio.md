# 🎨 Battle Studio (Battle Configurator)

The **Battle Studio** is where the creative process begins. It provides a visual interface for selecting contestants and defining the parameters of an ASMR battle.

## Core Purpose
To allow users to precisely configure the "Who", "Where", and "How" of a battle before sending it to the neural engine.

## Key Features

### 1. Contestant Selection (`ContestantGrid`)
*   **Categories**: Browse through 50+ items categorized into Nature, Objects, Elements, and more.
*   **Smart Selection**: The system tracks your chosen contestants in the `SelectedContestantsBar`.
*   **Search & Filter**: Find the perfect rival using real-time filtering.

### 2. Studio Controls
*   **Resolution/Format**: Choose between TikTok (9:16), YouTube (16:9), or Square (1:1).
*   **Visual Style**: Define the aesthetic—Cinematic, Neon, Retro, or Realistic.
*   **Production Level**: Adjust the "Complexity" of the generated battle script.

### 3. Outcome Logic
*   **AI-Decided**: Let the LLM determine the winner based on the contestants' strengths and weaknesses.
*   **Random Luck**: A dice roll determines who survives.
*   **Manual Override**: You, the Director, choose the victor.

## Technical Implementation
- **Page**: `BattleConfiguratorPage.dart`
- **State Management**: `battleConfigProvider` (Riverpod)
- **Data Source**: `ContestantRepository` (loading from `contestants.json`)

## Workflow
1. Select at least 4 contestants from the grid.
2. Review the `SelectedContestantsBar`.
3. Adjust Studio Controls (Format, Persistence, Style).
4. Tap "Produce Battle" to move to the Generator Lab.
