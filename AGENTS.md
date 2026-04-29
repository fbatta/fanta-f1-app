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
# Run unit/widget tests
fvm flutter test

# Run integration tests
fvm flutter test integration_test/

# Run code generation
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Analyze/lint
fvm flutter analyze
```

## Architecture

- **State Management:** Riverpod 3.x with hooks_riverpod
- **Navigation:** GoRouter
- **Backend:** Firebase (Auth, Firestore, Messaging, Storage)
- **DI:** GetIt
- **Code Gen:** Freezed + json_serializable + riverpod_generator

## Testing

- Widget tests in `test/component/`
- Repository tests in `test/repository/`
- Integration tests in `integration_test/`
- Mocks generated via `@GenerateNiceMocks()` in `test/mock/`

## Generated Files (Excluded from Analysis)

- `*.freezed.dart`
- `*.g.dart`
- `*.mocks.dart`

## Code Generation Required

After any changes to:
- Freezed models
- Riverpod providers
- JSON serializable DTOs

Run: `flutter pub run build_runner build --delete-conflicting-outputs`
