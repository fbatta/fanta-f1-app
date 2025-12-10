import 'package:fanta_f1/dto/user/user.dart';
import 'package:fanta_f1/exception/validation_exception.dart';
import 'package:fanta_f1/provider/user_provider.dart';
import 'package:fanta_f1/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../helper/random_string.dart';
import '../mock/firebase_auth.mocks.dart';
import '../mock/repository.mocks.dart';

void main() {
  group("User provider", () {
    final getIt = GetIt.instance;
    final mockFirebaseAuth = MockFirebaseAuth();
    final mockUserRepository = MockUserRepository();
    final mockFirebaseUser = MockUser();
    final mockUser = User(
        userId: '1',
        displayName: 'John Doe',
        email: 'william.rufus.day@example-pet-store.com',
        privileges: [],
        createdAt: DateTime.fromMillisecondsSinceEpoch(0)
    );
    
    setUp(() {
      reset(mockFirebaseAuth);
      reset(mockUserRepository);
      reset(mockFirebaseUser);
      
      getIt.registerSingleton<FirebaseAuth>(mockFirebaseAuth);
      getIt.registerSingleton<UserRepository>(mockUserRepository);
    });

    tearDown(() async {
      await getIt.reset();
    });

    test("Should return a user if it exists", () async {
      // if
      when(mockFirebaseAuth.currentUser).thenReturn(mockFirebaseUser);
      when(mockFirebaseUser.uid).thenReturn('1');
      when(mockUserRepository.findUser('1')).thenAnswer((_) async => mockUser);

      // when
      final container = ProviderContainer.test();

      // then
      await expectLater(container.read(userProviderProvider.future), completion(mockUser));
    });

    test("Should return null if no user is found", () async {
      // if
      when(mockFirebaseAuth.currentUser).thenReturn(mockFirebaseUser);
      when(mockFirebaseUser.uid).thenReturn('1');
      when(mockUserRepository.findUser('1')).thenAnswer((_) async => null);

      // when
      final container = ProviderContainer.test();

      // then
      await expectLater(container.read(userProviderProvider.future), completion(null));
    });

    test("Should allow updating a user's display name", () async {
      // if
      when(mockFirebaseAuth.currentUser).thenReturn(mockFirebaseUser);
      when(mockFirebaseUser.uid).thenReturn('1');
      when(mockUserRepository.findUser('1')).thenAnswer((_) async => mockUser);

      // when
      final container = ProviderContainer.test();
      await expectLater(container.read(userProviderProvider.future), completion(mockUser));
      await container.read(userProviderProvider.notifier).updateDisplayName('Giggi');

      // then
      verify(mockUserRepository.updateUser(any));
    });

    test("Should throw an error if a new name is shorter than 3 characters, or longer than 80 characters", () async {
      // if
      when(mockFirebaseAuth.currentUser).thenReturn(mockFirebaseUser);
      when(mockFirebaseUser.uid).thenReturn('1');
      when(mockUserRepository.findUser('1')).thenAnswer((_) async => mockUser);

      // when
      final container = ProviderContainer.test();
      await expectLater(container.read(userProviderProvider.future), completion(mockUser));
      
      // then
      expect(() async => await container.read(userProviderProvider.notifier).updateDisplayName('AA'), throwsA(isA<ValidationException>()));
      expect(() async => await container.read(userProviderProvider.notifier).updateDisplayName(generateRandomString(81)), throwsA(isA<ValidationException>()));
      verifyNever(mockUserRepository.updateUser(any));
    });
  });
}