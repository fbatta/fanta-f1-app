import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:fanta_f1/provider/team_provider.dart';
import 'package:fanta_f1/repository/team_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../mock/firebase_auth.mocks.dart';
import '../mock/repository.mocks.dart';
import '../mock/utils.mocks.dart';

void main() {
  late MockTeamRepository mockTeamRepository;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;
  late MockTimeUtils mockTimeUtils;

  setUp(() {
    mockTeamRepository = MockTeamRepository();
    mockFirebaseAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockTimeUtils = MockTimeUtils();

    when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('test-user-id');
    when(mockTimeUtils.tryGetNetworkTime())
        .thenAnswer((_) async => DateTime(2026, 1, 1));

    final getIt = GetIt.instance;
    if (getIt.isRegistered<TeamRepository>()) {
      getIt.unregister<TeamRepository>();
    }
    if (getIt.isRegistered<FirebaseAuth>()) {
      getIt.unregister<FirebaseAuth>();
    }
    if (getIt.isRegistered<TimeUtils>()) {
      getIt.unregister<TimeUtils>();
    }

    getIt.registerSingleton<TeamRepository>(mockTeamRepository);
    getIt.registerSingleton<FirebaseAuth>(mockFirebaseAuth);
    getIt.registerSingleton<TimeUtils>(mockTimeUtils);
  });

  tearDown(() {
    final getIt = GetIt.instance;
    if (getIt.isRegistered<TeamRepository>()) {
      getIt.unregister<TeamRepository>();
    }
    if (getIt.isRegistered<FirebaseAuth>()) {
      getIt.unregister<FirebaseAuth>();
    }
    if (getIt.isRegistered<TimeUtils>()) {
      getIt.unregister<TimeUtils>();
    }
  });

  Team createSampleTeam({required String teamId, required String lobbyId}) {
    return Team(
      teamId: teamId,
      ownerId: 'test-user-id',
      teamName: 'Team $teamId',
      lobbyId: lobbyId,
      points: {2026: 100.0},
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    );
  }

  test('getTeamById returns team from state if present', () async {
    final team = createSampleTeam(teamId: 'team-1', lobbyId: 'lobby-1');
    when(mockTeamRepository.getTeamsByOwnerId('test-user-id'))
        .thenAnswer((_) async => [team]);

    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Read provider to initialize state
    await container.read(teamProviderProvider.future);

    final result = await container
        .read(teamProviderProvider.notifier)
        .getTeamById('team-1');

    expect(result, isNotNull);
    expect(result!.teamId, equals('team-1'));
    expect(result.lobbyId, equals('lobby-1'));
    verifyNever(mockTeamRepository.findTeamById(any));
  });

  test(
    'getTeamById queries repository if team is not in current state',
    () async {
      when(mockTeamRepository.getTeamsByOwnerId('test-user-id'))
          .thenAnswer((_) async => []);

      final externalTeam =
          createSampleTeam(teamId: 'external-team', lobbyId: 'external-lobby');
      when(mockTeamRepository.findTeamById('external-team'))
          .thenAnswer((_) async => externalTeam);

      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(teamProviderProvider.future);

      final result = await container
          .read(teamProviderProvider.notifier)
          .getTeamById('external-team');

      expect(result, isNotNull);
      expect(result!.teamId, equals('external-team'));
      expect(result.lobbyId, equals('external-lobby'));
      verify(mockTeamRepository.findTeamById('external-team')).called(1);
    },
  );

  test('getTeamById returns null if team cannot be found', () async {
    when(mockTeamRepository.getTeamsByOwnerId('test-user-id'))
        .thenAnswer((_) async => []);
    when(mockTeamRepository.findTeamById('unknown-team'))
        .thenAnswer((_) async => null);

    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(teamProviderProvider.future);

    final result = await container
        .read(teamProviderProvider.notifier)
        .getTeamById('unknown-team');

    expect(result, isNull);
  });
}
