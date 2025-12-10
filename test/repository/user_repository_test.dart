import 'package:fanta_f1/dto/user/user.dart';
import 'package:fanta_f1/exception/user_already_exists_exception.dart';
import 'package:fanta_f1/exception/user_not_found_exception.dart';
import 'package:fanta_f1/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/firebase_storage.mocks.dart';
import '../mock/firestore.mocks.dart';

void main() {
  final mockFirestore = MockFirebaseFirestore();
  final mockStorage = MockFirebaseStorage();
  final mockCollectionReference = MockCollectionReference();
  final mockDocumentReference = MockDocumentReference();
  final mockDocumentSnapshot = MockDocumentSnapshot();
  final mockUser = User(
    userId: '1',
    displayName: 'John Doe',
    email: 'william.rufus.day@example-pet-store.com',
    privileges: [],
    createdAt: DateTime.fromMillisecondsSinceEpoch(0)
  );

  group("User repository", () {
    setUp(() {
      reset(mockFirestore);
      reset(mockStorage);
      reset(mockCollectionReference);
      reset(mockDocumentReference);
      reset(mockDocumentSnapshot);
    });

    test("Should return a user when found", () async {
      // if
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn(mockUser.toJson());

      // when
      final userRepository = UserRepository(mockFirestore, mockStorage);
      final user = await userRepository.getUser('1');

      // then
      expect(user, mockUser);
    });

    test("Should throw an exception when user is not found and using getUser", () async {
      // if
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('2')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(false);

      // when
      final userRepository = UserRepository(mockFirestore, mockStorage);
      expect(() async => await userRepository.getUser('2'), throwsA(isA<UserNotFoundException>()));
    });

    test("Should return null if a user is not found and using findUser", () async {
      // if
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('2')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(false);

      // when
      final userRepository = UserRepository(mockFirestore, mockStorage);
      final user = await userRepository.findUser('2');

      // then
      expect(user, null);
    });

    test("Should create a user", () async {
      // if
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(false);

      // when
      final userRepository = UserRepository(mockFirestore, mockStorage);
      await userRepository.createUser(mockUser);

      // then
      verify(mockDocumentReference.set(mockUser.toJson())).called(1);
    });

    test("Should throw an exception when user already exists and trying to create it", () async {
      // if
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(true);

      // when
      final userRepository = UserRepository(mockFirestore, mockStorage);
      expect(() async => await userRepository.createUser(mockUser), throwsA(isA<UserAlreadyExistsException>()));
    });

    test("Should update a user", () async {
      // if
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(true);

      // when
      final userRepository = UserRepository(mockFirestore, mockStorage);
      await userRepository.updateUser(mockUser);

      // then
      verify(mockDocumentReference.update(mockUser.toJson())).called(1);
    });

    test("Should throw error when user is not found and trying to update it", () async {
      // if
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('1')).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(false);

      // when
      final userRepository = UserRepository(mockFirestore, mockStorage);
      expect(() async => await userRepository.updateUser(mockUser), throwsA(isA<UserNotFoundException>()));
    });
  });
}