import 'package:fanta_f1/component/error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorCard Widget Tests', () {
    testWidgets('should display the error message', (
      WidgetTester tester,
    ) async {
      const errorMessage = 'An unexpected error occurred';

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: ErrorCard(message: errorMessage)),
          ),
        ),
      );

      // Verify the message is displayed
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('should apply correct styling from theme', (
      WidgetTester tester,
    ) async {
      const errorMessage = 'Styled error';
      final themeData = ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          error: Colors.red,
          errorContainer: Colors.red.shade100,
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: themeData,
            home: const Scaffold(body: ErrorCard(message: errorMessage)),
          ),
        ),
      );

      // Verify Card color
      final card = tester.widget<Card>(find.byType(Card));
      expect(card.color, themeData.colorScheme.errorContainer);

      // Verify Text style
      final text = tester.widget<Text>(find.text(errorMessage));
      expect(text.style?.color, themeData.colorScheme.error);
      expect(text.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('should have correct padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: ErrorCard(message: 'Padding test')),
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(
        find
            .descendant(of: find.byType(Card), matching: find.byType(Padding))
            .last,
      );

      expect(
        paddingWidget.padding,
        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      );
    });
  });
}
