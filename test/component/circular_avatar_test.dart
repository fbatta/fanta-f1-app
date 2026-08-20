import 'dart:io';

import 'package:fanta_f1/component/circular_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helper/http_overrides.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  Widget buildAvatar({
    String? imageUrl,
    double size = 50.0,
    ThemeData? theme,
  }) {
    return ProviderScope(
      child: MaterialApp(
        theme: theme ?? ThemeData.light(),
        home: Scaffold(
          body: Center(
            child: CircularAvatar(
              imageUrl: imageUrl,
              size: size,
            ),
          ),
        ),
      ),
    );
  }

  group('CircularAvatar', () {
    testWidgets('renders fallback asset image when imageUrl is null', (
      WidgetTester tester,
    ) async {
      const testSize = 60.0;
      await tester.pumpWidget(buildAvatar(imageUrl: null, size: testSize));

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      expect(container.constraints?.maxWidth, testSize);
      expect(container.constraints?.maxHeight, testSize);

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.shape, BoxShape.circle);
      expect(decoration.image, isNotNull);
      expect(
        decoration.image!.image,
        const AssetImage('assets/images/unknown_driver_avatar.png'),
      );
      expect(decoration.image!.fit, BoxFit.cover);
      expect(decoration.border, isNotNull);
    });

    testWidgets('renders fallback asset image when imageUrl is UNKNOWN', (
      WidgetTester tester,
    ) async {
      const testSize = 40.0;
      await tester.pumpWidget(buildAvatar(imageUrl: 'UNKNOWN', size: testSize));

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      expect(container.constraints?.maxWidth, testSize);
      expect(container.constraints?.maxHeight, testSize);

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.shape, BoxShape.circle);
      expect(decoration.image, isNotNull);
      expect(
        decoration.image!.image,
        const AssetImage('assets/images/unknown_driver_avatar.png'),
      );
      expect(decoration.image!.fit, BoxFit.cover);
    });

    testWidgets('renders NetworkImage when valid imageUrl is provided', (
      WidgetTester tester,
    ) async {
      const testUrl = 'https://example.com/driver.png';
      const testSize = 80.0;

      await tester.pumpWidget(buildAvatar(imageUrl: testUrl, size: testSize));
      await tester.pumpAndSettle();

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      expect(container.constraints?.maxWidth, testSize);
      expect(container.constraints?.maxHeight, testSize);

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.shape, BoxShape.circle);
      expect(decoration.image, isNotNull);
      expect(decoration.image!.image, isA<NetworkImage>());
      final networkImage = decoration.image!.image as NetworkImage;
      expect(networkImage.url, testUrl);
      expect(decoration.image!.fit, BoxFit.cover);
    });

    testWidgets('applies primary border color from theme', (
      WidgetTester tester,
    ) async {
      const primaryColor = Colors.deepOrange;
      final customTheme = ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
        ),
      );

      await tester.pumpWidget(
        buildAvatar(imageUrl: null, size: 50.0, theme: customTheme),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, primaryColor);
      expect(border.bottom.color, primaryColor);
    });

    testWidgets('renders with different sizes accurately', (
      WidgetTester tester,
    ) async {
      for (final size in [24.0, 48.0, 70.0, 100.0]) {
        await tester.pumpWidget(buildAvatar(imageUrl: null, size: size));

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.constraints?.maxWidth, size);
        expect(container.constraints?.maxHeight, size);
      }
    });
  });
}
