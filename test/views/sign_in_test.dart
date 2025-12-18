import 'package:fanta_f1/views/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../mock/firebase_auth.mocks.dart';

void main() {
  final getIt = GetIt.instance;
  final auth = MockFirebaseAuth();
  final googleAuthProvider = MockGoogleAuthProvider();
  getIt.registerSingleton<FirebaseAuth>(auth);
  getIt.registerSingleton<GoogleAuthProvider>(googleAuthProvider);

  testWidgets('Should render the elements of the sign in page', (tester) async {
    final widget = MaterialApp(home: const SignIn());
    await tester.pumpWidget(widget);

    expect(find.byType(Form), findsOneWidget);

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Sign In'), findsNWidgets(2));
    expect(find.text("Forgot password"), findsOneWidget);
    expect(find.text("Google sign in"), findsOneWidget);
  });

  testWidgets('Should validate username field', (tester) async {
    final widget = MaterialApp(home: const SignIn());
    await tester.pumpWidget(widget);

    await tester.enterText(find.byKey(ValueKey('Password')), 'apassword1');
    await tester.pumpAndSettle();

    final form = tester.state<FormState>(find.byType(Form));
    var errors = form.validateGranularly();
    expect(errors.length, 1);
    expect(errors.first.errorText, 'Please enter a username');

    await tester.enterText(find.byKey(ValueKey('Username')), 'invalid-email');
    await tester.tap(find.text("Sign In").last);
    await tester.pumpAndSettle();

    errors = form.validateGranularly();
    expect(errors.length, 1);
    expect(errors.first.errorText, 'Please enter a valid email');

    await tester.enterText(
      find.byKey(ValueKey('Username')),
      'username with spaces@gmail.com',
    );
    await tester.tap(find.byKey(ValueKey('Sign In')));
    await tester.pumpAndSettle();

    errors = form.validateGranularly();
    expect(errors.length, 1);
    expect(errors.first.errorText, 'Username cannot contain spaces');
  });

  testWidgets('Should show an error message on failed authentication', (
    tester,
  ) async {
    when(
      auth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ),
    ).thenThrow(FirebaseAuthException(code: 'user-not-found'));

    final widget = MaterialApp(home: const SignIn());
    await tester.pumpWidget(widget);

    await tester.enterText(find.byKey(ValueKey('Username')), 'email@gmail.com');
    await tester.enterText(find.byKey(ValueKey('Password')), 'apassword1');
    await tester.tap(find.byKey(ValueKey('Sign In')));
    await tester.pumpAndSettle();

    final usernameField = tester.widget<TextFormField>(
      find.byKey(ValueKey('Username')),
    );
    expect(usernameField.forceErrorText, 'User not found');
  });
}
