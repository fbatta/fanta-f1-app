import 'package:fanta_f1/dto/driver/driver.dart';
import 'package:fanta_f1/dto/driver_cost/driver_cost.dart';
import 'package:fanta_f1/dto/driver_summary/driver_summary.dart';
import 'package:fanta_f1/repository/driver_cost_repository.dart';
import 'package:fanta_f1/repository/driver_repository.dart';
import 'package:fanta_f1/repository/driver_summary_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'driver_provider.g.dart';

@riverpod
class DriverProvider extends _$DriverProvider {
  final _getIt = GetIt.instance;

  @override
  FutureOr<Map<Driver, DriverCost>> build() async {
    final driverRepository = _getIt<DriverRepository>();
    final driverCostRepository = _getIt<DriverCostRepository>();

    final drivers = await driverRepository.getDrivers();
    final driverCosts = await driverCostRepository.getDriverCosts();

    return {
      for (final driver in drivers)
        driver: driverCosts.firstWhere(
          (element) => element.driverId == driver.driverId,
          orElse: () => DriverCost(driverId: driver.driverId, driverCost: 0.0),
        ),
    };
  }

  Future<DriverSummary?> getDriverSummary(String driverId) async {
    try {
      final summaryRepository = _getIt<DriverSummaryRepository>();
      return await summaryRepository.getDriverSummary(driverId);
    } catch (_) {
      // TODO: report error
      return null;
    }
  }
}
