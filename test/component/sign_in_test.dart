import 'package:fanta_f1/route/route_names.dart';
import 'package:fanta_f1/views/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mockito/mockito.dart';

import '../mock/firebase_auth.mocks.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleAuthProvider mockGoogleAuthProvider;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleAuthProvider = MockGoogleAuthProvider();
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();

    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockFirebaseAuth.currentUser).thenReturn(null);

    final getIt = GetIt.instance;
    if (getIt.isRegistered<FirebaseAuth>()) {
      getIt.unregister<FirebaseAuth>();
    }
    if (getIt.isRegistered<GoogleAuthProvider>()) {
      getIt.unregister<GoogleAuthProvider>();
    }

    getIt.registerSingleton<FirebaseAuth>(mockFirebaseAuth);
    getIt.registerSingleton<GoogleAuthProvider>(mockGoogleAuthProvider);
  });

  tearDown(() {
    final getIt = GetIt.instance;
    if (getIt.isRegistered<FirebaseAuth>()) {
      getIt.unregister<FirebaseAuth>();
    }
    if (getIt.isRegistered<GoogleAuthProvider>()) {
      getIt.unregister<GoogleAuthProvider>();
    }
  });

  Widget createWidgetUnderTest() {
    final router = GoRouter(
      initialLocation: RouteNames.signIn.path,
      routes: [
        GoRoute(
          path: RouteNames.signIn.path,
          name: RouteNames.signIn.toString(),
          builder: (context, state) => const SignIn(),
        ),
        GoRoute(
          path: RouteNames.home.path,
          name: RouteNames.home.toString(),
          builder: (context, state) => const Scaffold(
            body: Text('Home Screen'),
          ),
        ),
        GoRoute(
          path: RouteNames.signUp.path,
          name: RouteNames.signUp.name,
          builder: (context, state) => const Scaffold(
            body: Text('SignUp Screen'),
          ),
        ),
      ],
    );

    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  testWidgets('redirects to home view on successful username/password sign in', (
    tester,
  ) async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'Password123!',
      ),
    ).thenAnswer((_) async => mockUserCredential);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(SignIn), findsOneWidget);
    expect(find.text('Home Screen'), findsNothing);

    await tester.enterText(
      find.byKey(const ValueKey('Username')),
      'test@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('Password')),
      'Password123!',
    );

    await tester.tap(find.byKey(const ValueKey('Sign In')));
    await tester.pumpAndSettle();

    verify(
      mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'Password123!',
      ),
    ).called(1);

    expect(find.text('Home Screen'), findsOneWidget);
    expect(find.byType(SignIn), findsNothing);
  });

  testWidgets('shows error message when email and password sign in fails', (
    tester,
  ) async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'Password123!',
      ),
    ).thenThrow(
      FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found for that email.',
      ),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('Username')),
      'test@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('Password')),
      'Password123!',
    );

    await tester.tap(find.byKey(const ValueKey('Sign In')));
    await tester.pumpAndSettle();

    expect(find.text('User not found'), findsOneWidget);
    expect(find.text('Home Screen'), findsNothing);
  });

  testWidgets('redirects to home view on successful Google sign in', (
    tester,
  ) async {
    when(
      mockFirebaseAuth.signInWithProvider(mockGoogleAuthProvider),
    ).thenAnswer((_) async => mockUserCredential);
    when(
      mockFirebaseAuth.signInWithPopup(mockGoogleAuthProvider),
    ).thenAnswer((_) async => mockUserCredential);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Google sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Home Screen'), findsOneWidget);
  });

  testWidgets('redirects to home if user is already signed in', (
    tester,
  ) async {
    when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Home Screen'), findsOneWidget);
    expect(find.byType(SignIn), findsNothing);
  });
}
