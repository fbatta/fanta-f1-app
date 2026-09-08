import 'dart:async';

import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:fanta_f1/main.dart';
import 'package:fanta_f1/repository/driver_repository.dart';
import 'package:fanta_f1/repository/lineup_repository.dart';
import 'package:fanta_f1/repository/lobby_repository.dart';
import 'package:fanta_f1/repository/race_weekend_repository.dart';
import 'package:fanta_f1/repository/team_repository.dart';
import 'package:fanta_f1/route/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';

import '../mock/firebase_auth.mocks.dart';
import '../mock/firebase_messaging.mocks.dart';
import '../mock/repository.mocks.dart';
import '../mock/utils.mocks.dart';

void main() {
  late MockFirebaseMessaging mockMessaging;
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;
  late MockTeamRepository mockTeamRepository;
  late MockTimeUtils mockTimeUtils;
  late MockLineupRepository mockLineupRepository;
  late MockRaceWeekendRepository mockRaceWeekendRepository;
  late MockLobbyRepository mockLobbyRepository;
  late MockDriverRepository mockDriverRepository;
  late StreamController<RemoteMessage> onMessageOpenedAppController;

  final team = Team(
    teamId: 'team-1',
    ownerId: 'test-user',
    teamName: 'Scuderia',
    lobbyId: 'lobby-99',
    points: {2026: 50.0},
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );

  setUp(() {
    mockMessaging = MockFirebaseMessaging();
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockTeamRepository = MockTeamRepository();
    mockTimeUtils = MockTimeUtils();
    mockLineupRepository = MockLineupRepository();
    mockRaceWeekendRepository = MockRaceWeekendRepository();
    mockLobbyRepository = MockLobbyRepository();
    mockDriverRepository = MockDriverRepository();
    onMessageOpenedAppController = StreamController<RemoteMessage>.broadcast();

    when(mockMessaging.onTokenRefresh)
        .thenAnswer((_) => const Stream<String>.empty());
    when(mockMessaging.getInitialMessage()).thenAnswer((_) async => null);

    when(mockAuth.currentUser).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('test-user');
    when(mockTimeUtils.tryGetNetworkTime())
        .thenAnswer((_) async => DateTime(2026, 1, 1));

    when(mockTeamRepository.findTeamById('team-1'))
        .thenAnswer((_) async => team);
    when(mockTeamRepository.getTeamsByOwnerId('test-user'))
        .thenAnswer((_) async => [team]);

    when(mockRaceWeekendRepository.getFutureRacesForYear(any))
        .thenAnswer((_) async => []);
    when(mockRaceWeekendRepository.getPastRacesForYear(any))
        .thenAnswer((_) async => []);
    when(mockRaceWeekendRepository.getCurrentRace())
        .thenAnswer((_) async => null);
    when(mockRaceWeekendRepository.getRaceById(any))
        .thenAnswer((_) async => null);

    when(mockLobbyRepository.getLobbies()).thenAnswer((_) async => []);
    when(mockDriverRepository.getDrivers()).thenAnswer((_) async => []);

    final getIt = GetIt.instance;
    void register<T extends Object>(T instance) {
      if (getIt.isRegistered<T>()) {
        getIt.unregister<T>();
      }
      getIt.registerSingleton<T>(instance);
    }

    register<FirebaseMessaging>(mockMessaging);
    register<FirebaseAuth>(mockAuth);
    register<TeamRepository>(mockTeamRepository);
    register<TimeUtils>(mockTimeUtils);
    register<LineupRepository>(mockLineupRepository);
    register<RaceWeekendRepository>(mockRaceWeekendRepository);
    register<LobbyRepository>(mockLobbyRepository);
    register<DriverRepository>(mockDriverRepository);
  });

  tearDown(() async {
    await onMessageOpenedAppController.close();
    final getIt = GetIt.instance;
    void unregister<T extends Object>() {
      if (getIt.isRegistered<T>()) {
        getIt.unregister<T>();
      }
    }

    unregister<FirebaseMessaging>();
    unregister<FirebaseAuth>();
    unregister<TeamRepository>();
    unregister<TimeUtils>();
    unregister<LineupRepository>();
    unregister<RaceWeekendRepository>();
    unregister<LobbyRepository>();
    unregister<DriverRepository>();
  });

  GoRouter createTestRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: RouteNames.signIn.path,
          name: RouteNames.signIn.name,
          builder: (context, state) => const Scaffold(
            body: Text('SignInScreen'),
          ),
        ),
        GoRoute(
          path: RouteNames.calendar.path,
          name: RouteNames.calendar.name,
          builder: (context, state) => const Scaffold(
            body: Text('CalendarScreen'),
          ),
        ),
        GoRoute(
          path: RouteNames.home.path,
          name: RouteNames.home.name,
          builder: (context, state) => const Scaffold(
            body: Text('HomeScreen'),
          ),
        ),
        GoRoute(
          path: RouteNames.raceResults.path,
          name: RouteNames.raceResults.name,
          builder: (context, state) => Scaffold(
            body: Text(
              'RaceResultsScreen:${state.pathParameters['raceId']}:${state.pathParameters['teamId']}:${state.pathParameters['lobbyId']}',
            ),
          ),
        ),
      ],
    );
  }

  testWidgets(
    'navigates to raceResults on initialMessage with raceId, teamId, and lobbyId',
    (tester) async {
      final message = RemoteMessage(
        data: {
          'type': 'raceWeekendResultsAvailable',
          'raceId': 'monaco-2026',
          'teamId': 'team-1',
          'lobbyId': 'custom-lobby',
        },
      );
      when(mockMessaging.getInitialMessage()).thenAnswer((_) async => message);

      final router = createTestRouter();

      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('RaceResultsScreen:monaco-2026:team-1:custom-lobby'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'navigates to raceResults resolving lobbyId from team when not in payload',
    (tester) async {
      final message = RemoteMessage(
        data: {
          'type': 'raceWeekendResultsAvailable',
          'raceId': 'monaco-2026',
          'teamId': 'team-1',
        },
      );
      when(mockMessaging.getInitialMessage()).thenAnswer((_) async => message);

      final router = createTestRouter();

      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('RaceResultsScreen:monaco-2026:team-1:lobby-99'),
        findsOneWidget,
      );
    },
  );

  testWidgets('redirects unauthenticated user to signIn screen', (
    tester,
  ) async {
    when(mockAuth.currentUser).thenReturn(null);

    final message = RemoteMessage(
      data: {
        'type': 'raceWeekendResultsAvailable',
        'raceId': 'monaco-2026',
        'teamId': 'team-1',
      },
    );
    when(mockMessaging.getInitialMessage()).thenAnswer((_) async => message);

    final router = createTestRouter();

    await tester.pumpWidget(
      ProviderScope(
        child: MyApp(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('SignInScreen'), findsOneWidget);
    expect(find.textContaining('RaceResultsScreen'), findsNothing);
  });

  testWidgets('redirects to calendar screen when raceId is missing or empty', (
    tester,
  ) async {
    final message = RemoteMessage(
      data: {
        'type': 'raceWeekendResultsAvailable',
        'teamId': 'team-1',
      },
    );
    when(mockMessaging.getInitialMessage()).thenAnswer((_) async => message);

    final router = createTestRouter();

    await tester.pumpWidget(
      ProviderScope(
        child: MyApp(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('CalendarScreen'), findsOneWidget);
    expect(find.textContaining('RaceResultsScreen'), findsNothing);
  });

  testWidgets('redirects to calendar screen when teamId is missing or empty', (
    tester,
  ) async {
    final message = RemoteMessage(
      data: {
        'type': 'raceWeekendResultsAvailable',
        'raceId': 'monaco-2026',
      },
    );
    when(mockMessaging.getInitialMessage()).thenAnswer((_) async => message);

    final router = createTestRouter();

    await tester.pumpWidget(
      ProviderScope(
        child: MyApp(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('CalendarScreen'), findsOneWidget);
    expect(find.textContaining('RaceResultsScreen'), findsNothing);
  });

  testWidgets('redirects to calendar screen when team cannot be found', (
    tester,
  ) async {
    when(mockTeamRepository.findTeamById('unknown-team'))
        .thenAnswer((_) async => null);
    when(mockTeamRepository.getTeamsByOwnerId('test-user'))
        .thenAnswer((_) async => []);

    final message = RemoteMessage(
      data: {
        'type': 'raceWeekendResultsAvailable',
        'raceId': 'monaco-2026',
        'teamId': 'unknown-team',
      },
    );
    when(mockMessaging.getInitialMessage()).thenAnswer((_) async => message);

    final router = createTestRouter();

    await tester.pumpWidget(
      ProviderScope(
        child: MyApp(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('CalendarScreen'), findsOneWidget);
    expect(find.textContaining('RaceResultsScreen'), findsNothing);
  });

  testWidgets(
    'navigates to raceResults when notification is tapped in background',
    (tester) async {
      final router = createTestRouter();

      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(
            routerConfig: router,
            onMessageOpenedApp: onMessageOpenedAppController.stream,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final message = RemoteMessage(
        data: {
          'type': 'raceWeekendResultsAvailable',
          'raceId': 'monaco-2026',
          'teamId': 'team-1',
          'lobbyId': 'lobby-99',
        },
      );

      onMessageOpenedAppController.add(message);
      await tester.pumpAndSettle();

      expect(
        find.text('RaceResultsScreen:monaco-2026:team-1:lobby-99'),
        findsOneWidget,
      );
    },
  );
}
