import 'dart:async';

import 'package:fanta_f1/component/race_recap_card.dart';
import 'package:fanta_f1/dto/race_recap/race_recap.dart';
import 'package:fanta_f1/provider/race_recap_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeRaceRecapProvider extends RaceRecapProvider {
  final RaceRecap? recap;
  final bool shouldThrow;

  FakeRaceRecapProvider({this.recap, this.shouldThrow = false});

  @override
  FutureOr<RaceRecap?> build(String raceId) async {
    if (shouldThrow) {
      throw Exception('Failed to load recap');
    }
    return recap;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const testRecap = RaceRecap(
    raceId: 'monaco-2025',
    raceName: 'Monaco Grand Prix',
    recapParagraphs: [
      'A thrilling race in Monaco.',
      'Verstappen took the lead early in the race.',
    ],
  );

  Widget makeTestableWidget({
    required String raceId,
    RaceRecap? recap,
    bool shouldThrow = false,
  }) {
    return ProviderScope(
      overrides: [
        raceRecapProviderProvider(raceId).overrideWith(
          () => FakeRaceRecapProvider(recap: recap, shouldThrow: shouldThrow),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(body: RaceRecapCard(raceId: raceId)),
      ),
    );
  }

  group('RaceRecapCard', () {
    testWidgets('renders recap card when data is available', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(makeTestableWidget(
        raceId: 'monaco-2025',
        recap: testRecap,
      ));
      await tester.pumpAndSettle();

      expect(
        find.text('Race weekend recap'),
        findsOneWidget,
        reason: 'Section header should be displayed',
      );
      expect(
        find.byType(MarkdownBody),
        findsOneWidget,
        reason: 'MarkdownBody should be present',
      );
      expect(
        find.textContaining('thrilling'),
        findsOneWidget,
        reason: 'Markdown content should be rendered',
      );
      expect(
        find.textContaining('Verstappen'),
        findsOneWidget,
        reason: 'Second paragraph should be rendered',
      );
      expect(
        find.byType(Card),
        findsOneWidget,
        reason: 'Card should wrap the recap content',
      );
    });

    testWidgets('renders markdown with multiple paragraphs', (
      WidgetTester tester,
    ) async {
      const recapWithMultipleParagraphs = RaceRecap(
        raceId: 'spa-2025',
        raceName: 'Belgian Grand Prix',
        recapParagraphs: [
          'First paragraph about the race.',
          'Second paragraph describing overtakes.',
          'Third paragraph about the podium.',
        ],
      );

      await tester.pumpWidget(makeTestableWidget(
        raceId: 'spa-2025',
        recap: recapWithMultipleParagraphs,
      ));
      await tester.pumpAndSettle();

      expect(
        find.byType(MarkdownBody),
        findsOneWidget,
      );
      expect(
        find.textContaining('First paragraph'),
        findsOneWidget,
      );
      expect(
        find.textContaining('overtakes'),
        findsOneWidget,
      );
      expect(
        find.textContaining('podium'),
        findsOneWidget,
      );
    });

    testWidgets('renders markdown with bold text', (WidgetTester tester) async {
      const recapWithMarkdown = RaceRecap(
        raceId: 'monaco-2025',
        raceName: 'Monaco Grand Prix',
        recapParagraphs: ['**Verstappen** dominated the **qualifying**.'],
      );

      await tester.pumpWidget(makeTestableWidget(
        raceId: 'monaco-2025',
        recap: recapWithMarkdown,
      ));
      await tester.pumpAndSettle();

      expect(
        find.byType(MarkdownBody),
        findsOneWidget,
      );
      expect(
        find.textContaining('dominated'),
        findsOneWidget,
      );
    });

    testWidgets('renders markdown with blockquotes', (
      WidgetTester tester,
    ) async {
      const recapWithBlockquote = RaceRecap(
        raceId: 'monaco-2025',
        raceName: 'Monaco Grand Prix',
        recapParagraphs: ['> A historic moment in Monaco.'],
      );

      await tester.pumpWidget(makeTestableWidget(
        raceId: 'monaco-2025',
        recap: recapWithBlockquote,
      ));
      await tester.pumpAndSettle();

      expect(
        find.byType(MarkdownBody),
        findsOneWidget,
      );
      expect(
        find.textContaining('historic'),
        findsOneWidget,
      );
    });

    testWidgets('renders empty when recap is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(makeTestableWidget(
        raceId: 'monaco-2025',
        recap: null,
      ));
      await tester.pumpAndSettle();

      expect(
        find.text('Race weekend recap'),
        findsNothing,
      );
      expect(
        find.byType(MarkdownBody),
        findsNothing,
      );
      expect(
        find.byType(Card),
        findsNothing,
      );
    });

    testWidgets('renders empty when provider throws error', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(makeTestableWidget(
        raceId: 'monaco-2025',
        shouldThrow: true,
      ));
      await tester.pumpAndSettle();

      expect(
        find.text('Race weekend recap'),
        findsNothing,
      );
      expect(
        find.byType(MarkdownBody),
        findsNothing,
      );
    });

    testWidgets('renders empty while loading', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        raceId: 'monaco-2025',
        recap: testRecap,
      ));

      expect(
        find.text('Race weekend recap'),
        findsNothing,
      );
      expect(
        find.byType(MarkdownBody),
        findsNothing,
      );

      await tester.pumpAndSettle();

      expect(
        find.text('Race weekend recap'),
        findsOneWidget,
      );
    });

    testWidgets('renders empty with single paragraph', (
      WidgetTester tester,
    ) async {
      const singleParagraphRecap = RaceRecap(
        raceId: 'monaco-2025',
        raceName: 'Monaco Grand Prix',
        recapParagraphs: ['A single paragraph recap.'],
      );

      await tester.pumpWidget(makeTestableWidget(
        raceId: 'monaco-2025',
        recap: singleParagraphRecap,
      ));
      await tester.pumpAndSettle();

      expect(
        find.byType(MarkdownBody),
        findsOneWidget,
      );
      expect(
        find.textContaining('single paragraph'),
        findsOneWidget,
      );
    });
  });
}
