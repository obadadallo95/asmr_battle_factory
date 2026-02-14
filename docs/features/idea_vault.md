# 💎 Idea Vault (Scenario Bank)

The **Idea Vault** is a high-efficiency brainstorming system that allows you to generate multiple creative directions for a battle at a fraction of the cost.

## Core Purpose
To separate "Scenario Generation" (low cost) from "Full Production" (higher cost), giving the user a sandbox to find the most "viral" ideas.

## Key Features

### 1. Neural Batching
- **Batch Generation**: Instead of one idea, the vault generates 5 high-potential battle scripts in a single request.
- **Token Optimization**: Uses minimal context to maximize speed and reduce production costs to less than $0.01 per batch.

### 2. Scenario Carousel
- **Swiping Interface**: A mobile-optimized carousel allows you to swipe through the 5 generated scenarios.
- **Full View**: Tap any card to read the full script and battle progression.

### 3. Selection & Projection
- **Favorite Ideas**: "Star" the ideas you love to move them into the `Production Queue`.
- **History Tracking**: All generated vault batches are archived, so you never lose a "crazy idea".

## Technical Implementation
- **Page**: `IdeaVaultPage.dart`
- **State Management**: `vaultNotifierProvider`
- **AI Model**: Specifically optimized prompts for Gemini-Flash or Llama-8B for speed.

## Workflow
1. Select contestants in the Studio.
2. Enter the Idea Vault.
3. Tap "Strike White Gold" (Generate Batch).
4. Swipe through the 5 generated scenarios.
5. Select the best one for full production (Video/Audio).
