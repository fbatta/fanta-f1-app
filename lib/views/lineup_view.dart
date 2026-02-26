import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/dto/driver/driver.dart';
import 'package:fanta_f1/dto/driver_cost/driver_cost.dart';
import 'package:fanta_f1/dto/lineup/lineup.dart';
import 'package:fanta_f1/helper/color_utils.dart';
import 'package:fanta_f1/provider/driver_provider.dart';
import 'package:fanta_f1/provider/lineup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LineupView extends ConsumerStatefulWidget {
  final String raceId;
  final String teamId;
  const LineupView({super.key, required this.raceId, required this.teamId});

  @override
  ConsumerState createState() => _LineupViewState();
}

class _LineupViewState extends ConsumerState<LineupView> {
  Lineup? lineup;

  @override
  Widget build(BuildContext context) {
    final drivers = ref.watch(driverProviderProvider);

    return FutureBuilder(
      future: ref
          .read(lineupProviderProvider.notifier)
          .findLineupByRaceId(widget.teamId, widget.raceId),
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

        lineup = snapshot.data;
        return Scaffold(
          appBar: _appBar(),
          body: ListView(
            children: [_selectedDriversCard(drivers.requireValue)],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(title: Text('Lineup'));
  }

  Widget _selectedDriversCard(Map<Driver, DriverCost> drivers) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
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
            if (lineup == null || lineup!.drivers.length - 1 < index) {
              return SizedBox(height: 1, width: 1);
            }
            final lineupDriver = lineup!.drivers[index];
            final driver = drivers.entries
                .firstWhere(
                  (el) => el.key.acronym == lineupDriver.driverAcronym,
                )
                .key;
            return Column(
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
                      image: NetworkImage(driver.driverAvatar),
                    ),
                  ),
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
          },
        ),
      ),
    );
  }
}
