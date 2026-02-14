# 📂 Projects & 📜 Battle History

The ASMR Battle Factory uses a **Project-Based Workflow**, allowing you to save your favorite setups and track your creative journey.

## Projects Hub
Accessed via the main navigation, the Hub displays all your saved creative projects.

### Features:
*   **Project Cards**: View snapshots of contestants, production dates, and quick stats.
*   **Duplication**: Found a perfect setup? Use the "Duplicate" action to create a variation without losing the original.
*   **Production Launch**: Jump directly from a project card into the Battle Studio.

## Battle History
Every time a battle is generated, it is automatically logged in your history.

### What's Saved?
- **Timestamp**: When the battle was produced.
- **Winners/Losers**: The final result of the encounter.
- **Script Snippet**: A preview of the generated narrative.
- **Status**: Whether the production was successful or encountered an error.

## Technical Implementation
- **Project Model**: `Project`
- **History Model**: `BattleHistoryEntry`
- **Repository**: `ProjectRepository` & `HistoryRepository`
- **Storage**: Hive Boxes (`projects_box`, `history_box`)

## Data Management
- **Persistence**: All projects and history are stored locally on your device for maximum privacy.
- **Search**: The Hub includes a global search to find projects by name or contestant.
