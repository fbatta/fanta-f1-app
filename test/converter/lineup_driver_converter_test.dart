import 'package:fanta_f1/converter/lineup_driver_converter.dart';
import 'package:fanta_f1/dto/lineup/lineup_driver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LineupDriverConverter', () {
    const converter = LineupDriverConverter();

    final testJson = [
      {
        'driverId': 'verstappen',
        'driverNumber': 1,
        'driverAcronym': 'VER',
        'driverCost': 30.5,
      },
      {
        'driverId': 'leclerc',
        'driverNumber': 16,
        'driverAcronym': 'LEC',
        'driverCost': 25.0,
      },
    ];

    final testDrivers = [
      const LineupDriver(
        driverId: 'verstappen',
        driverNumber: 1,
        driverAcronym: 'VER',
        driverCost: 30.5,
      ),
      const LineupDriver(
        driverId: 'leclerc',
        driverNumber: 16,
        driverAcronym: 'LEC',
        driverCost: 25.0,
      ),
    ];

    test(
      'fromJson should convert a list of dynamic to a list of LineupDriver',
      () {
        final result = converter.fromJson(testJson);

        expect(result.length, 2);
        expect(result[0].driverId, 'verstappen');
        expect(result[0].driverNumber, 1);
        expect(result[0].driverAcronym, 'VER');
        expect(result[0].driverCost, 30.5);

        expect(result[1].driverId, 'leclerc');
        expect(result[1].driverNumber, 16);
        expect(result[1].driverAcronym, 'LEC');
        expect(result[1].driverCost, 25.0);
      },
    );

    test(
      'toJson should convert a list of LineupDriver to a list of dynamic',
      () {
        final result = converter.toJson(testDrivers);

        expect(result, testJson);
      },
    );
  });
}
