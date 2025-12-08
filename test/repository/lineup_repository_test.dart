import 'package:fanta_f1/dto/lineup/lineup.dart';
import 'package:fanta_f1/repository/lineup_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/firestore.mocks.dart';

void main() {
  group("Lineup repository", () {
    final mockFirestore = MockFirebaseFirestore();
    final mockCollectionReference = MockCollectionReference();
    final mockDocumentReference = MockDocumentReference();
    final mockDocumentSnapshot = MockDocumentSnapshot();
    final mockLineup = Lineup(
        lineupId: '1_1',
        teamId: '1',
        raceId: '1',
        totalBudgetSpent: 42,
        racePoints: 121,
        captainDriverId: '1',
        selectedDriverIds: ['1', '3', '8', '12', '20'],
        hasSafetyCar: true,
        hasVirtualSafetyCar: false,
        hasRedFlag: false,
        wetTyresUsed: true,
        poleToWin: false,
        sameTeamOneTwo: false,
        teamsInTopTenCount: 3,
        retiredCarsCount: 1,
        createdAt: DateTime.fromMillisecondsSinceEpoch(0));

    setUp(() {
      reset(mockFirestore);
      reset(mockCollectionReference);
      reset(mockDocumentReference);
      reset(mockDocumentSnapshot);
    });

    test("Should return lineup by id", () async {
      // if
      when(mockFirestore.collection('lineups')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1_1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn(mockLineup.toJson());

      // when
      final repository = LineupRepository(mockFirestore);
      final lineup = await repository.findLineupById('1', '1');

      // then
      expect(lineup, mockLineup);
    });

    test("Should return null if lineup doesn't exist", () async {
      // if
      when(mockFirestore.collection('lineups')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1_1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(false);

      // when
      final repository = LineupRepository(mockFirestore);
      final lineup = await repository.findLineupById('1', '1');

      // then
      expect(lineup, null);
    });

    test("Should update an existing lineup if it already exists", () async {
      // if
      when(mockFirestore.collection('lineups')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1_1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn(mockLineup.toJson());

      // when
      final repository = LineupRepository(mockFirestore);
      await repository.createOrUpdateLineup(mockLineup);

      // then
      verify(mockDocumentReference.update(any)).called(1);
    });

    test("Should create a new lineup if it doesn't exist", () async {
      // if
      when(mockFirestore.collection('lineups')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1_1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(false);

      // when
      final repository = LineupRepository(mockFirestore);
      await repository.createOrUpdateLineup(mockLineup);

      // then
      verify(mockDocumentReference.set(any)).called(1);
    });
  });
}