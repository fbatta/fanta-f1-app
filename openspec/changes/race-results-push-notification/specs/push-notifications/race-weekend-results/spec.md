## Purpose

Defines how the application handles incoming push notifications when race weekend results are
available, including payload parsing and deep-linking navigation to the race results view.

## ADDED Requirements

### Requirement: Race weekend results push notification payload

When the backend sends a `raceWeekendResultsAvailable` push notification, the notification payload
SHALL include `type` set to `raceWeekendResultsAvailable`, a valid `raceId`, a valid `teamId` and a
valid `lobbyId`.

#### Scenario: Notification payload parsed successfully

- **WHEN** the app receives a notification with `type: "raceWeekendResultsAvailable"`, `raceId`,
  `teamId`, and `lobbyId`
- **THEN** the system parses the notification data into a push notification object containing all
  three parameters

### Requirement: Notification tap navigates to race results view

When an authenticated user opens or taps a `raceWeekendResultsAvailable` notification, the system
SHALL navigate directly to the race results view corresponding to the `raceId`, `teamId`, and
`lobbyId` from the notification payload.

#### Scenario: User opens notification from background or terminated state

- **WHEN** an authenticated user taps a `raceWeekendResultsAvailable` notification containing a
  valid `raceId`, `teamId`, and `lobbyId`
- **THEN** the system navigates directly to the race results view for that `raceId`, `teamId`, and
  `lobbyId`

### Requirement: Unauthenticated user redirects to sign in

When a user who is not logged in opens a `raceWeekendResultsAvailable` notification, the system
SHALL redirect the user to the sign-in screen.

#### Scenario: User is not authenticated

- **WHEN** an unauthenticated user opens a `raceWeekendResultsAvailable` notification
- **THEN** the system navigates to the sign-in screen instead of the race results view

### Requirement: Fallback for missing or invalid notification data

When the notification payload is missing `raceId`, `teamId`, or `lobbyId`, or when the referenced
team cannot be resolved, the system SHALL NOT throw an unhandled exception and SHALL navigate to a
safe fallback screen (home or calendar).

#### Scenario: Missing raceId or teamId

- **WHEN** a notification of type `raceWeekendResultsAvailable` has null or empty `raceId`,
  `teamId`, or `lobbyId`
- **THEN** the system avoids crashing and navigates to calendar screen

#### Scenario: Team cannot be resolved

- **WHEN** a notification has a `teamId` that does not exist or cannot be fetched
- **THEN** the system avoids crashing and navigates to the home or calendar screen
