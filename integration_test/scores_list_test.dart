import 'package:fanta_f1/component/scores_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('scoresList Integration Test', () {
    testWidgets('renders podium and list of scores', (tester) async {
      final scores = [
        ScoresAndAvatars(name: 'Winner', score: 100.0, avatar: null),
        ScoresAndAvatars(name: 'Second', score: 80.0, avatar: null),
        ScoresAndAvatars(name: 'Third', score: 60.0, avatar: null),
        ScoresAndAvatars(name: 'Fourth', score: 40.0, avatar: null),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: scoresList(scores)),
          ),
        ),
      );

      // Verify podium names
      expect(find.text('Winner'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);

      // Verify list item name
      expect(find.text('Fourth'), findsOneWidget);

      // Verify scores
      expect(find.text('100.0'), findsOneWidget);
      expect(find.text('80.0'), findsOneWidget);
      expect(find.text('60.0'), findsOneWidget);
      expect(find.text('40.0'), findsOneWidget);
    });

    testWidgets('triggers onPressed when tapped', (tester) async {
      bool pressed = false;
      final scores = [
        ScoresAndAvatars(
          name: 'Winner',
          score: 100.0,
          avatar: null,
          onPressed: () => pressed = true,
        ),
        ScoresAndAvatars(name: 'Second', score: 80.0, avatar: null),
        ScoresAndAvatars(name: 'Third', score: 60.0, avatar: null),
      ];

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: scoresList(scores))),
      );

      await tester.tap(find.text('Winner'));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });
  });
}
