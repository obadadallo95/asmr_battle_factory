# 👨‍💻 Developer Guide

Welcome to the **ASMR Battle Factory** development team. This guide outlines the standards and workflows required to maintain the project's high quality.

## Core Philosophical Standards

### 1. The 300-Line Rule
- **Constraint**: No single `.dart` file should exceed 300 lines of code.
- **Reason**: Promotes modularity, easier code reviews, and faster testing.
- **Action**: If a file reaches 250 lines, refactor it by splitting logic into a separate Mixin, Service, or Widget.

### 2. Widget-Per-File (Atomic Design)
- **Constraint**: Each reusable widget must reside in its own file.
- **Hierarchy**:
  - Global widgets: `lib/core/widgets/`
  - Feature-specific widgets: `lib/features/[feature]/presentation/widgets/`

### 3. Responsive Everything
- **Standard**: Always use `flutter_screenutil` for measurements.
- **Usage**: `.w` for widths/padding, `.h` for heights, `.r` for radii, and `.sp` for font sizes.
- **Avoid**: Never use hardcoded pixel values (e.g., `100` -> `100.w`).

## Development Workflow

### Dependency Injection
We use `injectable`. After adding a new service or repository:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### State Management Patterns
1. Define a `State` class (Freezed is recommended).
2. Create a `Notifier` to manage that state.
3. Access the state in the UI via `ref.watch(myProvider)`.

### Localization
1. Add keys to `assets/l10n/en.json` (English) and `assets/l10n/ar.json` (Arabic).
2. Key format: `feature_name.sub_key.inner_key`.
3. Use in code: `context.tr('key.path')`.

## Pre-PR Checklist
- [ ] Run `flutter analyze` and ensure zero warnings.
- [ ] Ensure `prefer_const_constructors` is followed.
- [ ] Verify that new files have the line count comment at the top (e.g., `// Lines: 45/300`).
