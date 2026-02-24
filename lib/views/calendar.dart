import 'package:fanta_f1/component/main_bottom_navigation_bar.dart';
import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/dto/race/race.dart';
import 'package:fanta_f1/provider/race_weekend_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  ConsumerState createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {
  @override
  Widget build(BuildContext context) {
    final raceWeekends = ref.watch(raceWeekendProviderProvider);

    if (raceWeekends.isLoading || raceWeekends.isRefreshing) {
      return Scaffold(body: SpinnerCentered(text: "Loading race weekends..."));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Calendar')),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            Text("Next race:", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8.0),
            _raceWeekendCard(raceWeekends.requireValue.first),
            SizedBox(height: 16.0),
            Text(
              "Future races:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8.0),
            ...raceWeekends.requireValue.sublist(1).map(_raceWeekendCard),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNavigationBar(),
    );
  }

  Widget _raceWeekendCard(Race race) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        child: ListTile(
          title: Text(race.raceName),
          leading: Image.network(race.circuitImage),
          subtitle: Text(_startsIn(race.dateStart)),
        ),
      ),
    );
  }

  String _startsIn(DateTime date) {
    final difference = date.difference(DateTime.now());
    if (difference.inDays > 0) {
      return "Starts in ${difference.inDays} days";
    }
    return "Starts in ${difference.inHours} hours";
  }
}
