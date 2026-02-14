# Coding Standards

## General
- **Max Lines**: 300 lines per file. Split functionality if it grows larger.
- **Language**: Dart 3.0+ features (Records, Patterns).
- **Safety**: Null Safety is mandatory.

## Naming
- **Classes**: `PascalCase` (e.g., `BattleScript`)
- **Variables/Functions**: `camelCase` (e.g., `generateScript`)
- **Files**: `snake_case` (e.g., `battle_script.dart`)

## Architecture
- **State Management**: Riverpod (ConsumerWidget / ConsumerStatefulWidget).
- **Navigation**: GoRouter (Use `context.go()` for explicit paths).
- **Localization**: use `easy_localization` keys, never hardcode strings.

## Comments
- Use `///` for documentation comments.
- Complex logic should be explained in **Arabic** or **English**.
