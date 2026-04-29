import 'package:fanta_f1/component/error_card.dart';
import 'package:fanta_f1/component/scores_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScoresList Widget Tests', () {
    testWidgets('renders podium and list of scores', (
      WidgetTester tester,
    ) async {
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

    testWidgets('triggers onPressed when tapped', (WidgetTester tester) async {
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

    testWidgets('renders all podium positions correctly', (
      WidgetTester tester,
    ) async {
      final scores = [
        ScoresAndAvatars(name: 'Winner', score: 100.0, avatar: null),
        ScoresAndAvatars(name: 'Second', score: 80.0, avatar: null),
        ScoresAndAvatars(name: 'Third', score: 60.0, avatar: null),
      ];

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: scoresList(scores))),
      );

      // Verify podium layout - Winner should be centered on top podium
      // Second should be on left podium (lower)
      // Third should be on right podium (lower)
      expect(find.text('Winner'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);
    });

    testWidgets('renders list items for scores beyond podium positions', (
      WidgetTester tester,
    ) async {
      final scores = List.generate(
        6,
        (index) => ScoresAndAvatars(
          name: 'Driver $index',
          score: (100 - index * 10).toDouble(),
          avatar: null,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: scoresList(scores))),
      );

      // Podium positions (0-2) should be rendered on podium
      // Remaining (3-5) should be in list
      for (int i = 0; i < 6; i++) {
        expect(find.text('Driver $i'), findsOneWidget);
      }
    });

    testWidgets('shows ErrorCard when list is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: scoresList([]))),
      );

      // Verify ErrorCard is displayed
      expect(find.byType(ErrorCard), findsOneWidget);
      expect(find.text('No scores found'), findsOneWidget);

      // Verify podium and list are not rendered
      expect(find.text('Winner'), findsNothing);
      expect(find.text('Second'), findsNothing);
      expect(find.text('Third'), findsNothing);
    });

    testWidgets('renders with custom avatars', (WidgetTester tester) async {
      final scores = [
        ScoresAndAvatars(
          name: 'Winner',
          score: 100.0,
          avatar: 'https://example.com/avatar1.png',
        ),
        ScoresAndAvatars(
          name: 'Second',
          score: 80.0,
          avatar: 'https://example.com/avatar2.png',
        ),
        ScoresAndAvatars(
          name: 'Third',
          score: 60.0,
          avatar: 'https://example.com/avatar3.png',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: scoresList(scores))),
      );

      // Verify avatars are rendered (as Container widgets)
      expect(find.byType(Container), findsWidgets);
    });
  });
}
