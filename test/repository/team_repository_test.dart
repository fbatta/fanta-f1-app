import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/repository/team_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/firestore.mocks.dart';

void main() {
  group("Team repository", () {
    final mockFirestore = MockFirebaseFirestore();
    final mockCollectionReference = MockCollectionReference();
    final mockDocumentReference = MockDocumentReference();
    final mockDocumentSnapshot = MockDocumentSnapshot();
    final mockTeam = Team(
      teamId: '1',
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      lobbyId: '1',
      name: 'Numero 1 della Williams',
      ownerId: '1',
    );

    setUp(() {
      reset(mockFirestore);
      reset(mockCollectionReference);
      reset(mockDocumentReference);
      reset(mockDocumentSnapshot);
    });

    test("Should return a team", () async {
      // if
      when(mockFirestore.collection('teams')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn(mockTeam.toJson());

      // when
      final repository = TeamRepository(mockFirestore);
      final team = await repository.findTeamById('1');

      // then
      expect(team, mockTeam);
    });

    test("Should return null if no team was found", () async {
      // if
      when(mockFirestore.collection('teams')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(false);

      // when
      final repository = TeamRepository(mockFirestore);
      final team = await repository.findTeamById('1');

      // then
      expect(team, null);
    });

    test("Should create a new team if one doesn't exist", () async {
      // if
      when(mockFirestore.collection('teams')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(false);
      
      // when
      final repository = TeamRepository(mockFirestore);
      await repository.createOrUpdateTeam(mockTeam);

      // then
      verify(mockDocumentReference.set(mockTeam.toJson())).called(1);
    });

    test("Should update a team if one already exists", () async {
      // if
      when(mockFirestore.collection('teams')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn(mockTeam.toJson());

      // when
      final repository = TeamRepository(mockFirestore);
      await repository.createOrUpdateTeam(mockTeam);

      // then
      verify(mockDocumentReference.update(mockTeam.toJson())).called(1);
    });
  });
}