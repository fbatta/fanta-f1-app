import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/driver_cost/driver_cost.dart';
import 'package:fanta_f1/repository/driver_cost_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../mock/firestore.mocks.dart';

void main() {
  late DriverCostRepository repository;
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
    when(mockFirestore.collection('driver_costs')).thenReturn(mockCollection);

    repository = DriverCostRepository();
  });

  group('DriverCostRepository', () {
    test('getDriverCosts returns a list of DriverCost', () async {
      // Arrange
      final driverCostData = {'driverId': 'verstappen', 'driverCost': 30.5};

      when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
      when(mockQueryDocumentSnapshot.data()).thenReturn(driverCostData);

      // Act
      final result = await repository.getDriverCosts();

      // Assert
      expect(result, isA<List<DriverCost>>());
      expect(result.length, 1);
      expect(result.first.driverId, 'verstappen');
      expect(result.first.driverCost, 30.5);

      verify(mockFirestore.collection('driver_costs')).called(1);
      verify(mockCollection.get()).called(1);
    });

    test('getDriverCosts returns empty list when no data is found', () async {
      // Arrange
      when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([]);

      // Act
      final result = await repository.getDriverCosts();

      // Assert
      expect(result, isEmpty);
      verify(mockCollection.get()).called(1);
    });
  });
}
