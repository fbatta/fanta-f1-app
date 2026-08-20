import 'dart:async';

import 'package:fanta_f1/component/team_select_modal_bottom_sheet.dart';
import 'package:fanta_f1/dto/race/race.dart';
import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:fanta_f1/provider/race_weekend_provider.dart';
import 'package:fanta_f1/provider/team_provider.dart';
import 'package:fanta_f1/route/route_names.dart';
import 'package:fanta_f1/views/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';

import '../mock/utils.mocks.dart';

class _FakeTeamProvider extends TeamProvider {
  _FakeTeamProvider(this._teams);

  final Map<String, Team> _teams;

  @override
  FutureOr<Map<String, Team>> build() async => _teams;
}

class _FakeRaceWeekendProvider extends RaceWeekendProvider {
  _FakeRaceWeekendProvider(this._model);

  final RaceWeekendProviderModel _model;

  @override
  FutureOr<RaceWeekendProviderModel> build() async => _model;
}

class _LineupStub extends StatelessWidget {
  const _LineupStub();

  @override
  Widget build(BuildContext context) => const Scaffold(body: Text('LineupStub'));
}

class _ResultsStub extends StatelessWidget {
  const _ResultsStub();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Text('ResultsStub'));
}

void main() {
  late MockTimeUtils mockTimeUtils;
  late DateTime now;

  setUp(() {
    now = DateTime(2026, 1, 15, 12, 0, 0);
    mockTimeUtils = MockTimeUtils();
    when(mockTimeUtils.tryGetNetworkTime()).thenAnswer((_) async => now);

    final getIt = GetIt.instance;
    if (getIt.isRegistered<TimeUtils>()) {
      getIt.unregister<TimeUtils>();
    }
    getIt.registerSingleton<TimeUtils>(mockTimeUtils);
  });

  Team team(String id, String name, String lobbyId) {
    return Team(
      teamId: id,
      ownerId: 'owner',
      teamName: name,
      lobbyId: lobbyId,
      points: {2026: 0.0},
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    );
  }

  Race raceWithLineupOpen() {
    return Race(
      raceId: 'race-1',
      raceName: 'Race 1',
      openF1MeetingKey: 1,
      circuitImage: 'https://example.com/circuit.png',
      dateStart: now.add(Duration(days: 1)),
      dateEnd: now.add(Duration(days: 2)),
      countryName: 'Country',
      countryFlag: '',
      circuitType: 'street',
      dateLineupOpen: now.subtract(Duration(hours: 1)),
      dateLineupClose: now.add(Duration(hours: 1)),
    );
  }

  Race raceWithoutChevron() {
    return Race(
      raceId: 'race-2',
      raceName: 'Race 2',
      openF1MeetingKey: 2,
      circuitImage: 'https://example.com/circuit.png',
      dateStart: now.add(Duration(days: 3)),
      dateEnd: now.add(Duration(days: 4)),
      countryName: 'Country',
      countryFlag: '',
      circuitType: 'street',
      dateLineupOpen: now.add(Duration(hours: 5)),
      dateLineupClose: now.add(Duration(hours: 6)),
    );
  }

  Future<void> pumpCalendar(WidgetTester tester, Map<String, Team> teams) async {
    final model = RaceWeekendProviderModel(
      currentRace: null,
      futureRaces: [raceWithLineupOpen()],
      pastRaces: [raceWithoutChevron()],
      allRaces: [raceWithLineupOpen(), raceWithoutChevron()],
    );

    final container = ProviderContainer(
      overrides: [
        raceWeekendProviderProvider.overrideWith(
          () => _FakeRaceWeekendProvider(model),
        ),
        teamProviderProvider.overrideWith(() => _FakeTeamProvider(teams)),
      ],
    );
    addTearDown(container.dispose);

    final router = GoRouter(
      initialLocation: RouteNames.calendar.path,
      routes: [
        GoRoute(
          path: RouteNames.home.path,
          name: RouteNames.home.name,
          builder: (context, state) => const Scaffold(),
        ),
        GoRoute(
          path: RouteNames.calendar.path,
          name: RouteNames.calendar.name,
          builder: (context, state) => const Calendar(),
        ),
        GoRoute(
          path: RouteNames.account.path,
          name: RouteNames.account.name,
          builder: (context, state) => const Scaffold(),
        ),
        GoRoute(
          path: RouteNames.lineup.path,
          name: RouteNames.lineup.name,
          builder: (context, state) => const _LineupStub(),
        ),
        GoRoute(
          path: RouteNames.raceResults.path,
          name: RouteNames.raceResults.name,
          builder: (context, state) => const _ResultsStub(),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('Calendar team selection', () {
    testWidgets('navigates directly to lineup without modal when single team',
        (tester) async {
      await pumpCalendar(
        tester,
        {for (var t in [team('t1', 'My Team', 'l1')]) t.teamId: t},
      );

      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      expect(find.byType(TeamSelectModalBottomSheet), findsNothing);
      expect(find.text('LineupStub'), findsOneWidget);
    });

    testWidgets('shows modal when multiple teams', (tester) async {
      await pumpCalendar(tester, {
        for (var t in [
          team('t1', 'Alpha', 'l1'),
          team('t2', 'Beta', 'l1'),
        ])
          t.teamId: t,
      });

      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      expect(find.byType(TeamSelectModalBottomSheet), findsOneWidget);
      expect(find.text('Alpha'), findsOneWidget);
      expect(find.text('Beta'), findsOneWidget);
      expect(find.text('LineupStub'), findsNothing);
    });

    testWidgets('shows modal with empty list when no teams', (tester) async {
      await pumpCalendar(tester, {});

      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      expect(find.byType(TeamSelectModalBottomSheet), findsOneWidget);
      expect(find.text('LineupStub'), findsNothing);
    });
  });
}
