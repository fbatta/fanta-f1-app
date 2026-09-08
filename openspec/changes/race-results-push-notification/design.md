## Context

See proposal.md for motivation and background.

Currently, `_handleMessage(RemoteMessage message)` in `lib/main.dart` deserializes FCM data via
`PushNotification.fromJson(message.data)` and switches on `data.type`. For
`PushNotificationType.raceWeekendResultsAvailable`, it currently throws an `UnimplementedError()`.

The route for race results is defined in `lib/route/router.dart` as:

```dart
RouteNames.raceResults
('/results/:raceId/:teamId/:lobbyId
'
)
```

which expects three path parameters: `raceId`, `teamId`, and `lobbyId`.
The push notification payload contains `raceId` and `teamId`. Thus, the application must resolve
`lobbyId` (present on the `Team` model) to construct the complete route path parameters.

## Goals / Non-Goals

**Goals:**

- Implement `PushNotificationType.raceWeekendResultsAvailable` handling in `_handleMessage`.
- Parse `raceId`, `teamId` and `lobbyId` from `data`.
- Safely navigate to `RouteNames.raceResults` with `raceId`, `teamId`, and `lobbyId`.
- Provide robust error handling and fallback navigation when data is invalid, missing, or when the
  team cannot be found.
- Ensure proper `mounted` lifecycle guards after asynchronous operations.

**Non-Goals:**

- Modifying the URL schema or parameters of `RouteNames.raceResults`.
- Modifying backend notification payload structure.
- Handling foreground heads-up banner notifications differently from existing notification handling.

## Decisions

### 1. Navigation Method and Fallback Behavior

- **Decision**: Use
  `context.goNamed(RouteNames.raceResults.name, pathParameters: {'raceId': raceId, 'teamId': teamId, 'lobbyId': team.lobbyId})`.
  If `raceId` or `teamId` is null/empty, or if the team document cannot be retrieved, navigate
  safely to `RouteNames.calendar.name`.
- **Rationale**: Avoids throwing exceptions or leaving the app in an undefined state if a malformed
  notification is received or if the team has been deleted.

### 2. Lifecycle Guard

- **Decision**: Check `if (!mounted) return;` immediately after the async team retrieval before
  invoking `context.goNamed(...)`.
- **Rationale**: Matches Flutter best practices for async context usage and prevents
  `BuildContext across async gaps` exceptions.

## Risks / Trade-offs

- **[Risk] Latency fetching Team document on cold start** → `findTeamById` is a single indexed
  document lookup in Firestore; latency is minimal and standard for deep links requiring entity
  resolution.
- **[Risk] User taps notification while logged out** → Existing check at top of `_handleMessage`
  redirects to `RouteNames.signIn.name` before reaching the switch statement.
- **[Risk] Team or Race deleted/invalid** → Mitigated by checking if team is non-null before
  attempting navigation; falls back to `RouteNames.home.name`.
