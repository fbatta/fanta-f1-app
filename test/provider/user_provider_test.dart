import 'package:fanta_f1/dto/user/user.dart';
import 'package:fanta_f1/provider/user_provider.dart';
import 'package:fanta_f1/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

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

      await expectLater(container.read(userProviderProvider.future), completion(mockUser));
    });

    test("Should return null if no user is found", () async {
      // if
      when(mockFirebaseAuth.currentUser).thenReturn(mockFirebaseUser);
      when(mockFirebaseUser.uid).thenReturn('1');
      when(mockUserRepository.findUser('1')).thenAnswer((_) async => null);

      // when
      final container = ProviderContainer.test();

      await expectLater(container.read(userProviderProvider.future), completion(null));
    });
  });
}