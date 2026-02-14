# 🧪 AI Marketplace (Provider Orchestration)

The **AI Marketplace** is the command center for the application's intelligence layer. It implements a **BYOK (Bring Your Own Key)** model for maximum privacy and cost control.

## Core Purpose
To provide a decentralized, multi-provider AI ecosystem where the user is in control of their own credentials and costs.

## Key Features

### 1. Provider Cards
- **Broad Coverage**: Support for Google (Gemini), Meta (Llama via Groq), OpenAI (GPT-4), and DeepSeek.
- **Connection Status**: Real-time visual feedback (Green/Red) indicating if an API key is valid and connected.
- **Link Testing**: Built-in "Test Connection" tool to verify credentials before starting production.

### 2. Provider Details
- **Technical Specs**: View model version, context window, and estimated costs per 1M tokens.
- **Documentation Links**: Deep links to provider dashboards to easily generate new keys.

### 3. Security (Local Encryption)
- **BYOK Model**: API keys are never stored on our servers. They reside only on your device.
- **Persistence**: Encrypted local storage ensures your keys are remembered between sessions but remain inaccessible to other apps.

## Technical Implementation
- **Page**: `MarketplacePage.dart`
- **Widget**: `ProviderCard.dart`, `ProviderDetailSheet.dart`
- **State Management**: `providerSettingsProvider`
- **Utilities**: `UrlLauncherHelper` for external links.

## Workflow
1. Navigate to the Marketplace tab.
2. Tap a provider (e.g., Gemini).
3. Follow the link to "Get API Key".
4. Enter the key in the field and tap "Test Connection".
5. Once "Connected", the provider is available for Use in the Studio/Vault.
