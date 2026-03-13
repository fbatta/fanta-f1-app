import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/driver/driver.dart';
import 'package:fanta_f1/repository/driver_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../mock/firestore.mocks.dart';

void main() {
  late DriverRepository repository;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockQuerySnapshot mockQuerySnapshot;
  late MockQueryDocumentSnapshot mockQueryDocumentSnapshot;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();

    // Register mock in GetIt
    final getIt = GetIt.instance;
    if (getIt.isRegistered<FirebaseFirestore>()) {
      getIt.unregister<FirebaseFirestore>();
    }
    getIt.registerSingleton<FirebaseFirestore>(mockFirestore);

    // Setup mock behavior
    when(mockFirestore.collection('drivers')).thenReturn(mockCollection);

    repository = DriverRepository();
  });

  group('DriverRepository', () {
    test('getDrivers returns a list of Driver objects', () async {
      // Arrange
      final driverData = {
        'driverId': 'verstappen',
        'name': 'Max Verstappen',
        'teamName': 'Red Bull Racing',
        'teamColour': '0000FF',
        'driverNumber': 1,
        'acronym': 'VER',
        'driverAvatar': 'url_to_avatar',
        'isActive': true,
      };

      when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
      when(mockQueryDocumentSnapshot.data()).thenReturn(driverData);

      // Act
      final result = await repository.getDrivers();

      // Assert
      expect(result, isA<List<Driver>>());
      expect(result.length, 1);
      expect(result.first.driverId, 'verstappen');
      expect(result.first.name, 'Max Verstappen');
      expect(result.first.teamName, 'Red Bull Racing');
      expect(result.first.isActive, isTrue);

      verify(mockFirestore.collection('drivers')).called(1);
      verify(mockCollection.get()).called(1);
    });

    test('getDrivers returns empty list when no drivers are found', () async {
      // Arrange
      when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([]);

      // Act
      final result = await repository.getDrivers();

      // Assert
      expect(result, isEmpty);
      verify(mockCollection.get()).called(1);
    });
  });
}
