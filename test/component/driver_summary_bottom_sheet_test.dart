import 'dart:async';
import 'dart:io';

import 'package:fanta_f1/component/circular_avatar.dart';
import 'package:fanta_f1/component/driver_summary_bottom_sheet.dart';
import 'package:fanta_f1/dto/driver/driver.dart';
import 'package:fanta_f1/dto/driver_cost/driver_cost.dart';
import 'package:fanta_f1/dto/driver_summary/driver_summary.dart';
import 'package:fanta_f1/helper/color_utils.dart';
import 'package:fanta_f1/provider/driver_provider.dart';
import 'package:fanta_f1/repository/driver_summary_repository.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:material_ui/material_ui.dart';

import '../helper/http_overrides.dart';

// Fake driver summary repository for tests
class FakeDriverSummaryRepository implements DriverSummaryRepository {
  final DriverSummary? summary;
  final bool shouldThrow;

  FakeDriverSummaryRepository({this.summary, this.shouldThrow = false});

  @override
  Future<DriverSummary?> getDriverSummary(String driverId) async {
    if (shouldThrow) {
      throw Exception('Failed to load summary');
    }
    return summary;
  }
}

// Test notifier that returns controlled driver data without GetIt
class TestDriverProvider extends DriverProvider {
  final Map<Driver, DriverCost> testData;
  TestDriverProvider(this.testData);

  @override
  FutureOr<Map<Driver, DriverCost>> build() async {
    return testData;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  const testDriver = Driver(
    driverId: 'test-driver-1',
    name: 'Max Verstappen',
    teamName: 'Red Bull Racing',
    teamColour: '3671C6',
    driverNumber: 1,
    acronym: 'VER',
    driverAvatar: 'UNKNOWN',
    isActive: true,
  );

  const testDriverCost = DriverCost(
    driverId: 'test-driver-1',
    driverCost: 28.5,
  );

  const testSummary = DriverSummary(
    driverId: 'test-driver-1',
    driverAcronym: 'VER',
    driverName: 'Max Verstappen',
    driverNumber: 1,
    summaryParagraphs: [
      'Max Verstappen is a Dutch racing driver.',
      'He is a three-time Formula One World Champion.',
    ],
  );

  setUp(() {
    final getIt = GetIt.instance;
    if (getIt.isRegistered<DriverSummaryRepository>()) {
      getIt.unregister<DriverSummaryRepository>();
    }
    getIt.registerSingleton<DriverSummaryRepository>(
      FakeDriverSummaryRepository(summary: testSummary),
    );
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  Widget makeTestableWidget({
    required String driverId,
    Map<Driver, DriverCost>? driverMap,
  }) {
    return ProviderScope(
      overrides: [
        driverProviderProvider.overrideWith(
          () => TestDriverProvider(driverMap ?? {testDriver: testDriverCost}),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(body: DriverSummaryBottomSheet(driverId: driverId)),
      ),
    );
  }

  group('DriverSummaryBottomSheet', () {
    testWidgets('shows loading indicator while fetching summary', (
      WidgetTester tester,
    ) async {
      GetIt.instance.unregister<DriverSummaryRepository>();
      GetIt.instance.registerSingleton<DriverSummaryRepository>(
        FakeDriverSummaryRepository(shouldThrow: true),
      );

      await tester.pumpWidget(makeTestableWidget(driverId: 'test-driver-1'));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(MarkdownBody), findsNothing);
    });

    testWidgets('shows driver info and markdown on success', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(makeTestableWidget(driverId: 'test-driver-1'));
      await tester.pumpAndSettle();

      // Driver info
      expect(
        find.text('Max Verstappen'),
        findsOneWidget,
        reason: 'Driver name should be displayed',
      );
      expect(
        find.text('1 · Red Bull Racing'),
        findsOneWidget,
        reason: 'Driver number and team should be displayed',
      );
      expect(
        find.text('\$28.5'),
        findsOneWidget,
        reason: 'Driver cost should be displayed',
      );

      // CircularAvatar
      final avatarFinder = find.byType(CircularAvatar);
      expect(avatarFinder, findsOneWidget);
      final avatarWidget = tester.widget<CircularAvatar>(avatarFinder);
      expect(avatarWidget.size, 70);
      expect(avatarWidget.imageUrl, 'UNKNOWN');

      // Markdown is rendered
      expect(
        find.byType(MarkdownBody),
        findsOneWidget,
        reason: 'MarkdownBody should be present',
      );
      expect(
        find.textContaining('AI-generated summary'),
        findsOneWidget,
        reason: 'Markdown header should be rendered',
      );
      expect(
        find.textContaining('three-time'),
        findsOneWidget,
        reason: 'Markdown content should be rendered',
      );

      // Loading spinner is gone
      expect(
        find.byType(CircularProgressIndicator),
        findsNothing,
        reason: 'Loading spinner should be gone',
      );
    });

    testWidgets('shows error message when fetch fails', (
      WidgetTester tester,
    ) async {
      GetIt.instance.unregister<DriverSummaryRepository>();
      GetIt.instance.registerSingleton<DriverSummaryRepository>(
        FakeDriverSummaryRepository(shouldThrow: true),
      );

      await tester.pumpWidget(makeTestableWidget(driverId: 'test-driver-1'));
      await tester.pumpAndSettle();

      expect(
        find.text('Something went wrong, please try again later.'),
        findsOneWidget,
      );

      // Driver info and markdown should not be present
      expect(find.text('Max Verstappen'), findsNothing);
      expect(find.byType(MarkdownBody), findsNothing);
    });

    testWidgets('shows driver info with empty summary paragraphs', (
      WidgetTester tester,
    ) async {
      GetIt.instance.unregister<DriverSummaryRepository>();
      GetIt.instance.registerSingleton<DriverSummaryRepository>(
        FakeDriverSummaryRepository(
          summary: DriverSummary(
            driverId: 'test-driver-1',
            driverAcronym: 'VER',
            driverName: 'Max Verstappen',
            driverNumber: 1,
            summaryParagraphs: [],
          ),
        ),
      );

      await tester.pumpWidget(makeTestableWidget(driverId: 'test-driver-1'));
      await tester.pumpAndSettle();

      expect(
        find.text('Max Verstappen'),
        findsOneWidget,
        reason: 'Driver name should be displayed',
      );
      expect(
        find.byType(MarkdownBody),
        findsOneWidget,
        reason: 'MarkdownBody should be present even with empty content',
      );
    });

    testWidgets('shows error message when summary is null', (
      WidgetTester tester,
    ) async {
      GetIt.instance.unregister<DriverSummaryRepository>();
      GetIt.instance.registerSingleton<DriverSummaryRepository>(
        FakeDriverSummaryRepository(summary: null),
      );

      await tester.pumpWidget(makeTestableWidget(driverId: 'test-driver-1'));
      await tester.pumpAndSettle();

      expect(
        find.text('Something went wrong, please try again later.'),
        findsOneWidget,
      );
    });

    testWidgets('renders markdown content with formatting', (
      WidgetTester tester,
    ) async {
      GetIt.instance.unregister<DriverSummaryRepository>();
      GetIt.instance.registerSingleton<DriverSummaryRepository>(
        FakeDriverSummaryRepository(
          summary: DriverSummary(
            driverId: 'test-driver-1',
            driverAcronym: 'VER',
            driverName: 'Max Verstappen',
            driverNumber: 1,
            summaryParagraphs: ['> This is a quote', 'Second paragraph.'],
          ),
        ),
      );

      await tester.pumpWidget(makeTestableWidget(driverId: 'test-driver-1'));
      await tester.pumpAndSettle();

      expect(
        find.byType(MarkdownBody),
        findsOneWidget,
        reason: 'MarkdownBody should be present',
      );
      expect(
        find.textContaining('quote'),
        findsOneWidget,
        reason: 'Markdown content should be rendered',
      );
      expect(
        find.textContaining('Second paragraph.'),
        findsOneWidget,
      );
    });

    testWidgets('falls back to first driver entry when driverId is not found', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        makeTestableWidget(driverId: 'non-existent-driver-id'),
      );
      await tester.pumpAndSettle();

      // Should fall back to the first driver in the map (testDriver)
      expect(find.text('Max Verstappen'), findsOneWidget);
      expect(find.text('\$28.5'), findsOneWidget);
      expect(find.text('1 · Red Bull Racing'), findsOneWidget);
    });

    testWidgets('displays team color correctly on team text', (
      WidgetTester tester,
    ) async {
      const customDriver = Driver(
        driverId: 'driver-ferrari',
        name: 'Charles Leclerc',
        teamName: 'Ferrari',
        teamColour: 'E80020',
        driverNumber: 16,
        acronym: 'LEC',
        driverAvatar: 'https://example.com/lec.png',
        isActive: true,
      );
      const customCost = DriverCost(
        driverId: 'driver-ferrari',
        driverCost: 22.0,
      );

      GetIt.instance.unregister<DriverSummaryRepository>();
      GetIt.instance.registerSingleton<DriverSummaryRepository>(
        FakeDriverSummaryRepository(
          summary: DriverSummary(
            driverId: 'driver-ferrari',
            driverAcronym: 'LEC',
            driverName: 'Charles Leclerc',
            driverNumber: 16,
            summaryParagraphs: ['Scuderia Ferrari driver.'],
          ),
        ),
      );

      await tester.pumpWidget(
        makeTestableWidget(
          driverId: 'driver-ferrari',
          driverMap: {customDriver: customCost},
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Charles Leclerc'), findsOneWidget);
      expect(find.text('16 · Ferrari'), findsOneWidget);
      expect(find.text('\$22.0'), findsOneWidget);

      final teamText = tester.widget<Text>(find.text('16 · Ferrari'));
      expect(
        teamText.style?.color,
        ColorUtils.convertHexToColor(customDriver.teamColour),
      );
    });
  });
}
