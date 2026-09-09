## 1. Team Resolution & Notification Handling

- [x] 1.1 Provide a lookup method in `TeamProvider` (or use `TeamRepository.findTeamById`) to
  resolve a `Team` by `teamId` and verify team lookup logic.
- [x] 1.2 Implement the `PushNotificationType.raceWeekendResultsAvailable` case in `_handleMessage`
  in `lib/main.dart` to parse `raceId`, `teamId`, and `lobbyId`, check `mounted`, and navigate to
  `RouteNames.raceResults`.
- [x] 1.3 Add fallback handling in `_handleMessage` for missing parameters or unresolvable teams,
  ensuring the app redirects safely to home or calendar without throwing exceptions.

## 2. Testing & Quality Verification

- [x] 2.1 Add unit test coverage for parsing `PushNotification` payload with
  `PushNotificationType.raceWeekendResultsAvailable`, `raceId`, and `teamId`.
- [x] 2.2 Add unit/widget tests for notification tap handling covering authenticated navigation,
  unauthenticated redirect to sign in, and missing payload fallback.
- [x] 2.3 Run `fvm flutter analyze` and `fvm flutter test` to verify that all linting rules and test
  suites pass cleanly.
