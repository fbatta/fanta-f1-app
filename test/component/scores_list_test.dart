import 'dart:io';

import 'package:fanta_f1/component/circular_avatar.dart';
import 'package:fanta_f1/component/error_card.dart';
import 'package:fanta_f1/component/scores_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helper/http_overrides.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  group('ScoresList Widget Tests', () {
    testWidgets('renders podium and list of scores with correct formatting', (
      WidgetTester tester,
    ) async {
      final scores = [
        ScoresAndAvatars(name: 'Winner', score: 100.0, avatar: null),
        ScoresAndAvatars(name: 'Second', score: 80.5, avatar: null),
        ScoresAndAvatars(name: 'Third', score: 60.0, avatar: null),
        ScoresAndAvatars(name: 'Fourth', score: 40.2, avatar: null),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: scoresList(scores)),
          ),
        ),
      );

      // Verify podium image asset
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  'assets/images/podium.png',
        ),
        findsOneWidget,
      );

      // Verify podium names
      expect(find.text('Winner'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);

      // Verify list item name
      expect(find.text('Fourth'), findsOneWidget);

      // Verify formatted scores (1 decimal place)
      expect(find.text('100.0'), findsOneWidget);
      expect(find.text('80.5'), findsOneWidget);
      expect(find.text('60.0'), findsOneWidget);
      expect(find.text('40.2'), findsOneWidget);

      // Verify circular avatars (3 on podium + 1 in list = 4 total)
      expect(find.byType(CircularAvatar), findsNWidgets(4));
    });

    testWidgets('triggers onPressed when 1st place is tapped', (
      WidgetTester tester,
    ) async {
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

    testWidgets('triggers onPressed when 2nd place is tapped', (
      WidgetTester tester,
    ) async {
      bool pressed = false;
      final scores = [
        ScoresAndAvatars(name: 'Winner', score: 100.0, avatar: null),
        ScoresAndAvatars(
          name: 'Second',
          score: 80.0,
          avatar: null,
          onPressed: () => pressed = true,
        ),
        ScoresAndAvatars(name: 'Third', score: 60.0, avatar: null),
      ];

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: scoresList(scores))),
      );

      await tester.tap(find.text('Second'));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('triggers onPressed when 3rd place is tapped', (
      WidgetTester tester,
    ) async {
      bool pressed = false;
      final scores = [
        ScoresAndAvatars(name: 'Winner', score: 100.0, avatar: null),
        ScoresAndAvatars(name: 'Second', score: 80.0, avatar: null),
        ScoresAndAvatars(
          name: 'Third',
          score: 60.0,
          avatar: null,
          onPressed: () => pressed = true,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: scoresList(scores))),
      );

      await tester.tap(find.text('Third'));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('triggers onPressed when list item is tapped', (
      WidgetTester tester,
    ) async {
      bool fourthPressed = false;
      final scores = [
        ScoresAndAvatars(name: 'Winner', score: 100.0, avatar: null),
        ScoresAndAvatars(name: 'Second', score: 80.0, avatar: null),
        ScoresAndAvatars(name: 'Third', score: 60.0, avatar: null),
        ScoresAndAvatars(
          name: 'Fourth',
          score: 40.0,
          avatar: null,
          onPressed: () => fourthPressed = true,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: scoresList(scores)),
          ),
        ),
      );

      await tester.tap(find.text('Fourth'));
      await tester.pumpAndSettle();

      expect(fourthPressed, isTrue);
    });

    testWidgets('handles null onPressed gracefully when tapped', (
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

      // Tapping items without onPressed should not throw
      await tester.tap(find.text('Winner'));
      await tester.tap(find.text('Second'));
      await tester.tap(find.text('Third'));
      await tester.tap(find.text('Fourth'));
      await tester.pumpAndSettle();
    });

    testWidgets('renders exactly 3 items with podium only and no list tiles', (
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

      expect(find.text('Winner'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);
      expect(find.byType(ListTile), findsNothing);
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
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: scoresList(scores)),
          ),
        ),
      );

      // Podium positions (0-2) and list items (3-5) should all be rendered
      for (int i = 0; i < 6; i++) {
        expect(find.text('Driver $i'), findsOneWidget);
      }
      expect(find.byType(ListTile), findsNWidgets(3));
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

    testWidgets('renders with custom network avatars and UNKNOWN avatars', (
      WidgetTester tester,
    ) async {
      final scores = [
        ScoresAndAvatars(
          name: 'Winner',
          score: 100.0,
          avatar: 'https://example.com/avatar1.png',
        ),
        ScoresAndAvatars(
          name: 'Second',
          score: 80.0,
          avatar: 'UNKNOWN',
        ),
        ScoresAndAvatars(
          name: 'Third',
          score: 60.0,
          avatar: null,
        ),
        ScoresAndAvatars(
          name: 'Fourth',
          score: 40.0,
          avatar: 'https://example.com/avatar4.png',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: scoresList(scores)),
          ),
        ),
      );

      // Verify 4 avatars rendered
      final avatars = tester.widgetList<CircularAvatar>(
        find.byType(CircularAvatar),
      );
      expect(avatars.length, 4);

      // Podium avatars have size 40
      expect(avatars.elementAt(0).size, 40);
      expect(avatars.elementAt(0).imageUrl, 'https://example.com/avatar1.png');

      expect(avatars.elementAt(1).size, 40);
      expect(avatars.elementAt(1).imageUrl, 'UNKNOWN');

      expect(avatars.elementAt(2).size, 40);
      expect(avatars.elementAt(2).imageUrl, null);

      // ListTile avatar has size 35
      expect(avatars.elementAt(3).size, 35);
      expect(avatars.elementAt(3).imageUrl, 'https://example.com/avatar4.png');
    });
  });
}
