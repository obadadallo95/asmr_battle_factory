# Setup Guide

## Requirements
- Flutter SDK 3.27+
- Dart SDK 3.6+
- Android Studio / VS Code
- CocoaPods (for iOS)

## Installation
1. Clone the repo.
2. Run `flutter pub get`.
3. Run `flutter packages pub run build_runner build --delete-conflicting-outputs` (to generate Hive/Injectable code).
4. Run `flutter run`.

## Troubleshooting
- **Hive Error**: Run `build_runner`.
- **CocoaPods Error**: `cd ios && pod install && cd ..`.
