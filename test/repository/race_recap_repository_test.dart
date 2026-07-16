import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/race_recap/race_recap.dart';
import 'package:fanta_f1/repository/race_recap_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../mock/firestore.mocks.dart';

void main() {
  late RaceRecapRepository repository;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocumentReference;
  late MockDocumentSnapshot mockDocumentSnapshot;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();

    final getIt = GetIt.instance;
    if (getIt.isRegistered<FirebaseFirestore>()) {
      getIt.unregister<FirebaseFirestore>();
    }
    getIt.registerSingleton<FirebaseFirestore>(mockFirestore);

    when(mockFirestore.collection('race_weekend_recaps')).thenReturn(
      mockCollection,
    );
    when(mockCollection.doc('monaco-2025')).thenReturn(mockDocumentReference);

    repository = RaceRecapRepository();
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  group('RaceRecapRepository', () {
    test('getRaceRecap returns RaceRecap when document exists', () async {
      final recapData = {
        'raceId': 'monaco-2025',
        'raceName': 'Monaco Grand Prix',
        'recapParagraphs': [
          'A thrilling race in Monaco.',
          'Verstappen took the lead early.',
        ],
      };

      when(mockDocumentReference.get()).thenAnswer(
        (_) async => mockDocumentSnapshot,
      );
      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn(recapData);

      final result = await repository.getRaceRecap('monaco-2025');

      expect(result, isA<RaceRecap>());
      expect(result!.raceId, 'monaco-2025');
      expect(result.raceName, 'Monaco Grand Prix');
      expect(result.recapParagraphs.length, 2);
      expect(result.recapParagraphs[0], 'A thrilling race in Monaco.');
      expect(result.recapParagraphs[1], 'Verstappen took the lead early.');

      verify(mockFirestore.collection('race_weekend_recaps')).called(1);
      verify(mockCollection.doc('monaco-2025')).called(1);
      verify(mockDocumentReference.get()).called(1);
    });

    test('getRaceRecap returns null when document does not exist', () async {
      when(mockDocumentReference.get()).thenAnswer(
        (_) async => mockDocumentSnapshot,
      );
      when(mockDocumentSnapshot.exists).thenReturn(false);

      final result = await repository.getRaceRecap('monaco-2025');

      expect(result, isNull);

      verify(mockDocumentReference.get()).called(1);
    });

    test('getRaceRecap parses multiple recap paragraphs', () async {
      final recapData = {
        'raceId': 'spa-2025',
        'raceName': 'Belgian Grand Prix',
        'recapParagraphs': [
          'Paragraph one content.',
          'Paragraph two content.',
          'Paragraph three content.',
        ],
      };

      when(mockCollection.doc('spa-2025')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer(
        (_) async => mockDocumentSnapshot,
      );
      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn(recapData);

      final result = await repository.getRaceRecap('spa-2025');

      expect(result, isA<RaceRecap>());
      expect(result!.raceId, 'spa-2025');
      expect(result.raceName, 'Belgian Grand Prix');
      expect(result.recapParagraphs.length, 3);
    });
  });
}
