# Fanta F1 App

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

## Introduction

Fanta F1 is a Fantasy Formula 1 application built with Flutter and Firebase. It allows users to create their own fantasy teams, compete in various lobbies, and track their progress throughout the Formula 1 season. Manage your lineup, join friends in competitive leagues, and stay updated with the race calendar.

## Disclaimer

**IMPORTANT:** This application is an independent project and is **not affiliated, associated, authorized, endorsed by, or in any way officially connected with Formula 1, the FIA, or any of its bodies.** 

All product and company names are trademarks™ or registered® trademarks of their respective holders. Use of them does not imply any affiliation with or endorsement by them. Formula 1, F1, FORMULA ONE, FIA FORMULA ONE WORLD CHAMPIONSHIP, GRAND PRIX and related marks are trade marks of Formula One Licensing B.V.

## Features

- **User Authentication:** Secure sign-in and sign-up using Firebase Auth.
- **Team Management:** Create and edit your fantasy team.
- **Lineup Selection:** Strategically choose your drivers for each race weekend.
- **Lobbies:** Join or create private lobbies to compete with friends.
- **Race Calendar:** Keep track of upcoming Grand Prix events.
- **Account Settings:** Manage your profile and preferences.

## Tech Stack

- **Framework:** [Flutter](https://flutter.dev)
- **State Management:** [Riverpod](https://riverpod.dev) (with hooks)
- **Backend:** [Firebase](https://firebase.google.com) (Auth, Firestore, Cloud Messaging, Storage)
- **Navigation:** [GoRouter](https://pub.dev/packages/go_router)
- **Networking:** [Dio](https://pub.dev/packages/dio)
- **Code Generation:** [Freezed](https://pub.dev/packages/freezed), [JSON Serializable](https://pub.dev/packages/json_serializable)

## Getting Started

### Prerequisites

- Flutter SDK (refer to [official installation guide](https://docs.flutter.dev/get-started/install))
- Firebase project configured for Android/iOS

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/fanta-f1-app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd fanta-f1-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run code generation:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
5. Run the application:
   ```bash
   flutter run
   ```

## License

This project is licensed under the terms of the LICENSE file included in the repository.
