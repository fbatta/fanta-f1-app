import 'dart:async';

import 'package:fanta_f1/component/driver_summary_bottom_sheet.dart';
import 'package:fanta_f1/dto/driver/driver.dart';
import 'package:fanta_f1/dto/driver_cost/driver_cost.dart';
import 'package:fanta_f1/dto/driver_summary/driver_summary.dart';
import 'package:fanta_f1/provider/driver_provider.dart';
import 'package:fanta_f1/repository/driver_summary_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

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
    GetIt.instance.registerSingleton<DriverSummaryRepository>(
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
        home: Scaffold(
          body: DriverSummaryBottomSheet(driverId: driverId),
        ),
      ),
    );
  }

  group('DriverSummaryBottomSheet', () {
    testWidgets(
      'shows loading indicator while fetching summary',
      (WidgetTester tester) async {
        GetIt.instance.unregister<DriverSummaryRepository>();
        GetIt.instance.registerSingleton<DriverSummaryRepository>(
          FakeDriverSummaryRepository(shouldThrow: true),
        );

        await tester.pumpWidget(makeTestableWidget(driverId: 'test-driver-1'));

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(MarkdownBody), findsNothing);
      },
    );

    testWidgets(
      'shows driver info and markdown on success',
      (WidgetTester tester) async {
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

        // Markdown is rendered
        expect(
          find.byType(MarkdownBody),
          findsOneWidget,
          reason: 'MarkdownBody should be present',
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
      },
    );

    testWidgets(
      'shows error message when fetch fails',
      (WidgetTester tester) async {
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
      },
    );

    testWidgets(
      'shows driver info with empty summary paragraphs',
      (WidgetTester tester) async {
        GetIt.instance.unregister<DriverSummaryRepository>();
        GetIt.instance.registerSingleton<DriverSummaryRepository>(
          FakeDriverSummaryRepository(summary: DriverSummary(
            driverId: 'test-driver-1',
            driverAcronym: 'VER',
            driverName: 'Max Verstappen',
            driverNumber: 1,
            summaryParagraphs: [],
          )),
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
      },
    );

    testWidgets(
      'shows error message when summary is null',
      (WidgetTester tester) async {
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
      },
    );

    testWidgets(
      'renders markdown content',
      (WidgetTester tester) async {
        GetIt.instance.unregister<DriverSummaryRepository>();
        GetIt.instance.registerSingleton<DriverSummaryRepository>(
          FakeDriverSummaryRepository(summary: DriverSummary(
            driverId: 'test-driver-1',
            driverAcronym: 'VER',
            driverName: 'Max Verstappen',
            driverNumber: 1,
            summaryParagraphs: ['> This is a quote'],
          )),
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
      },
    );
  });
}
