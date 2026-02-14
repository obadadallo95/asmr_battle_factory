# Architecture Overview

ASMR Battle Factory uses a **Feature-First Clean Architecture**. This means code is organized primarily by **features** (e.g., `generator`, `vault`, `marketplace`) rather than technological layers, promoting modularity and scalability.

## Structural Hierarchy
```
lib/
├── config/              # Global configuration (DI, Routing, Global Theme)
├── core/                # Transversal infrastructure (Constants, Common Widgets, Nav)
└── features/            # Business domains
    ├── [feature]/
    │   ├── data/        # Repositories Implementation, APIs, Serialization Models
    │   ├── domain/      # Pure Entities, Data Repository Interfaces
    │   └── presentation/# Pages, Feature Widgets, State Management (Riverpod Notifiers)
```

## State Management (Riverpod)
We use `flutter_riverpod` as the primary state management solution.
- **Notifiers**: Most features use `Notifier` or `AsyncNotifier` to encapsulate complex business logic and UI state.
- **Providers**: Global configuration (like API settings) is managed via `StateProvider` or `NotifierProvider`.
- **Reactivity**: We leverage `ref.watch` for reactive UI updates and `ref.listen` for side-effects (like navigation or toasts).

## Dependency Injection
- **Framework**: `get_it` combined with `injectable`.
- **Generation**: Run `flutter pub run build_runner build` to wire dependencies.
- **Pattern**: Services and repositories are injected into Notifiers, keeping the Presentation layer decoupled from Data implementation.

## Communication Pattern
1. **User Action**: UI calls a method on a Riverpod Notifier.
2. **Logic Orchestration**: Notifier calls one or more Repository methods.
3. **Data Retrieval**: Repository interacts with Local DB (Hive) or Remote API (Dio/GenerativeAI).
4. **State Update**: Notifier updates its state, triggering a UI rebuild.
5. **Side Effects**: If needed, the UI or Notifier triggers navigation via `go_router`.
