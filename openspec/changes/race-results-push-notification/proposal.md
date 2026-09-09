## Why

Currently, when a user opens the app by tapping a `PushNotificationType.raceWeekendResultsAvailable`
push notification, the app throws an `UnimplementedError` in `_handleMessage`. Users need a seamless
way to immediately view their team's race results when notified that race weekend results are
available.

## What Changes

- Implement handling for `PushNotificationType.raceWeekendResultsAvailable` in the app's
  notification message handler (`_handleMessage`).
- Expect and parse `raceId`, `teamId` and `lobbyId` from the notification payload.
- Navigate directly to the `raceResults` view (`/results/:raceId/:teamId/:lobbyId`) using GoRouter.
- Handle fallback scenarios gracefully:
    - If the user is unauthenticated, redirect to the sign-in screen.
    - If `raceId`, `teamId` or `lobbyId` is missing, or if the specified team cannot be resolved,
      log a warning and fall back to the calendar screen without crashing.

## Capabilities

### New Capabilities

- `push-notifications/race-weekend-results`: Defines requirements for receiving, parsing, and
  handling `PushNotificationType.raceWeekendResultsAvailable` push notifications, including
  deep-linking navigation to the race results view.

### Modified Capabilities

*(None)*

## Impact

- **Affected Code**:
    - `lib/main.dart`: Update `_handleMessage` switch-case for
      `PushNotificationType.raceWeekendResultsAvailable`.
- **Dependencies & APIs**:
    - Existing Firebase Messaging (`FirebaseMessaging.onMessageOpenedApp` and `getInitialMessage`).
    - Existing GoRouter navigation to `RouteNames.raceResults`.
- **Tests**:
    - Unit/widget tests verifying payload parsing, fallback handling, and route navigation on
      notification tap.
