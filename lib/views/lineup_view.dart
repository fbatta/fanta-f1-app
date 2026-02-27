import 'package:fanta_f1/component/error_snack_bar.dart';
import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/component/success_snack_bar.dart';
import 'package:fanta_f1/dto/driver/driver.dart';
import 'package:fanta_f1/dto/driver_cost/driver_cost.dart';
import 'package:fanta_f1/dto/lineup/lineup.dart';
import 'package:fanta_f1/helper/color_utils.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:fanta_f1/provider/driver_provider.dart';
import 'package:fanta_f1/provider/lineup_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/v4.dart';

class LineupView extends ConsumerStatefulWidget {
  final String raceId;
  final String teamId;
  const LineupView({super.key, required this.raceId, required this.teamId});

  @override
  ConsumerState createState() => _LineupViewState();
}

class _LineupViewState extends ConsumerState<LineupView> {
  static final Driver emptyDriver = Driver(
    driverId: 'emptyDriver',
    name: 'Empty',
    teamName: '',
    teamColour: 'FF0000',
    driverNumber: 1,
    acronym: 'EMP',
    driverAvatar: 'UNKNOWN',
    isActive: true,
  );
  static final DriverCost emptyDriverCost = DriverCost(
    driverCost: 0,
    driverId: 'emptyDriver',
  );
  static final double totalCredits = 200.0;

  final _getIt = GetIt.instance;
  late final FirebaseAuth _auth;
  late final TimeUtils _timeUtils;
  late final Future<Lineup?> _lineupFuture;

  Lineup? _lineup;
  double _creditsSpent = 0.0;

  @override
  void initState() {
    _lineupFuture = ref
        .read(lineupProviderProvider.notifier)
        .findLineupByRaceId(widget.teamId, widget.raceId);
    _auth = _getIt();
    _timeUtils = _getIt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final drivers = ref.watch(driverProviderProvider);

    return FutureBuilder(
      future: _lineupFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            drivers.isLoading ||
            drivers.isRefreshing) {
          return Scaffold(
            appBar: _appBar(),
            body: SpinnerCentered(text: 'Loading lineup...'),
          );
        }

        if (drivers.hasError) {
          // TODO: report error
          return Scaffold(
            appBar: _appBar(),
            body: Center(
              child: Text('Something went wrong, please try again later.'),
            ),
          );
        }

        if (_lineup == null && snapshot.data != null) {
          _lineup = snapshot.data!;
          _creditsSpent = snapshot.data!.drivers.fold(
            0.0,
            (acc, driver) => acc + driver.driverCost,
          );
        }

        final activeDrivers = {
          for (final el in drivers.requireValue.entries.where(
            (el) => el.key.isActive == true,
          ))
            el.key: el.value,
        };
        return Scaffold(
          appBar: _appBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                _selectedDriversCard(drivers.requireValue),
                _driversList(activeDrivers),
              ],
            ),
          ),
          bottomNavigationBar: _bottomAppBar(),
        );
      },
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(title: Text('Lineup'));
  }

  Widget _selectedDriversCard(Map<Driver, DriverCost> drivers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.0),
        Text(
          'Selected drivers:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8.0,
            ),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.4,
              ),
              itemBuilder: (context, index) {
                if (_lineup == null || _lineup!.drivers.length - 1 < index) {
                  return _selectedDriverTile(
                    driver: emptyDriver,
                    driverCost: emptyDriverCost,
                  );
                }
                final lineupDriver = _lineup!.drivers[index];
                final driver = drivers.entries
                    .firstWhere(
                      (el) => el.key.acronym == lineupDriver.driverAcronym,
                    )
                    .key;
                final driverCost = drivers.entries
                    .firstWhere(
                      (el) => el.key.acronym == lineupDriver.driverAcronym,
                    )
                    .value;
                return _selectedDriverTile(
                  driver: driver,
                  driverCost: driverCost,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _driversList(Map<Driver, DriverCost> drivers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.0),
        Text('Drivers:', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 8.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                final driver = drivers.keys.elementAt(index);
                final driverCost = drivers.values.elementAt(index);

                return Column(
                  children: [
                    _driverTile(driver: driver, driverCost: driverCost),
                    index < drivers.length - 1 ? Divider() : Container(),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectedDriverTile({
    required Driver driver,
    required DriverCost driverCost,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
                image: DecorationImage(
                  image: driver.driverAvatar == 'UNKNOWN'
                      ? AssetImage('assets/images/unknown_driver_avatar.png')
                      : NetworkImage(driver.driverAvatar),
                ),
              ),
            ),
            driver.driverId != 'emptyDriver'
                ? Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: IconButton(
                        onPressed: () =>
                            _onRemoveDriverPressed(driver, driverCost),
                        icon: Icon(Icons.close, color: Colors.white),
                        iconSize: 15,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        SizedBox(height: 8.0),
        Text(driver.name),
        Text(
          driver.teamName,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorUtils.convertHexToColor(driver.teamColour),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _driverTile({required Driver driver, required DriverCost driverCost}) {
    return InkWell(
      child: ListTile(
        onTap: () => _onDriverSelected(driver, driverCost),
        enabled: _isDriverEnabled(driver, driverCost),
        leading: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            image: DecorationImage(image: NetworkImage(driver.driverAvatar)),
          ),
        ),
        title: Text(driver.name),
        subtitle: Text('\$ ${driverCost.driverCost.toString()}'),
      ),
    );
  }

  Future<void> _onDriverSelected(Driver driver, DriverCost driverCost) async {
    final now = await _timeUtils.tryGetNetworkTime();
    final lineupDriver = driver.toLineupDriver(driverCost.driverCost);

    if (_lineup == null) {
      setState(() {
        _lineup = Lineup(
          lineupId: UuidV4().generate(),
          teamId: widget.teamId,
          ownerId: _auth.currentUser!.uid,
          raceId: widget.raceId,
          drivers: [lineupDriver],
          createdAt: now,
          updatedAt: now,
          version: 1,
        );
      });
    } else {
      setState(() {
        _lineup!.drivers.add(lineupDriver);
      });
    }
  }

  bool _isDriverEnabled(Driver driver, DriverCost driverCost) {
    if (_lineup != null &&
        _lineup!.drivers.any(
          (lineupDriver) => lineupDriver.driverId == driver.driverId,
        )) {
      return false;
    }
    if (_creditsSpent + driverCost.driverCost > totalCredits) {
      return false;
    }
    if (_lineup != null && _lineup!.drivers.length >= 4) {
      return false;
    }
    return true;
  }

  void _onRemoveDriverPressed(Driver driver, DriverCost driverCost) {
    setState(() {
      _lineup!.drivers.removeWhere(
        (lineupDriver) => lineupDriver.driverId == driver.driverId,
      );
      _creditsSpent -= driverCost.driverCost;
    });
  }

  Widget? _bottomAppBar() {
    return BottomAppBar(
      height: 70,
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 16.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton(
            onPressed: _lineup != null && _lineup!.drivers.length == 4
                ? _onSaveLineupPressed
                : null,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _onSaveLineupPressed() async {
    if (_lineup == null || _lineup!.drivers.length < 4) {
      return;
    }
    try {
      print(_lineup);
      await ref
          .read(lineupProviderProvider.notifier)
          .createOrUpdateLineup(_lineup!);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(successSnackBar(context: context, text: 'Lineup saved'));
      }
    } catch (e) {
      print(e);
      // TODO: record error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(context: context, text: 'Error saving lineup'),
        );
      }
    }
  }
}
