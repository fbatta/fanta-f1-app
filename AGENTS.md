# Agent Instructions

## Setup

```bash
# Use FVM-managed Flutter version
fvm flutter pub get

# Run code generation before running or testing
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Commands

```bash
# Standard workflow: Analyze/Lint -> Test
fvm flutter analyze
fvm flutter test

# Run integration tests
fvm flutter test integration_test/

# Run code generation
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Architecture

- **State Management:** Riverpod 3.x with `hooks_riverpod`
- **Navigation:** GoRouter
- **Backend:** Firebase (Auth, Firestore, Messaging, Storage)
- **DI:** GetIt
- **Linting:** `custom_lint` and `riverpod_lint`
- **Code Gen:** Freezed + `json_serializable` + `riverpod_generator`

## Testing & Mocking

- **Widget tests:** `test/component/`
- **Repository tests:** `test/repository/`
- **Integration tests:** `integration_test/`
- **Mocking:** Use `mockito`. Register mocks in `GetIt` within `setUp` blocks:
  ```dart
  final getIt = GetIt.instance;
  if (getIt.isRegistered<Type>()) {
    getIt.unregister<Type>();
  }
  getIt.registerSingleton<Type>(mockInstance);
  ```
- **Mocks:** Generated via `@GenerateNiceMocks()` in `test/mock/`

## Generated Files (Excluded from Analysis)

- `*.freezed.dart`
- `*.g.dart`
- `*.mocks.dart`

## Code Generation Required

After any changes to Freezed models, Riverpod providers, or JSON serializable DTOs, run:
`fvm flutter pub run build_runner build --delete-conflicting-outputs`

