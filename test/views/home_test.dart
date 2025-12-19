import 'package:fanta_f1/component/app_bar_user_action.dart';
import 'package:fanta_f1/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../mock/firebase_auth.mocks.dart';

void main() {
  final getIt = GetIt.instance;
  final mockAuth = MockFirebaseAuth();
  getIt.registerSingleton<FirebaseAuth>(mockAuth);

  setUp(() {
    reset(mockAuth);
  });

  testWidgets("Should display elements in the view", (tester) async {
    final widget = MaterialApp(home: Home());
    await tester.pumpWidget(widget);

    expect(find.text('Home'), findsOneWidget);
    expect(find.byType(AppBarUserAction), findsOneWidget);
  });
}
