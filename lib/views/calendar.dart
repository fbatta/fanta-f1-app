import 'package:fanta_f1/component/main_bottom_navigation_bar.dart';
import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/component/team_select_modal_bottom_sheet.dart';
import 'package:fanta_f1/dto/race/race.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:fanta_f1/provider/race_weekend_provider.dart';
import 'package:fanta_f1/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  ConsumerState createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {
  final _getIt = GetIt.instance;
  late final TimeUtils _timeUtils;
  late final Future<DateTime> _networkTimeFuture;

  @override
  void initState() {
    _timeUtils = _getIt();
    _networkTimeFuture = _timeUtils.tryGetNetworkTime();
    super.initState();
  }

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
            raceWeekends.requireValue.currentRace != null
                ? _currentRaceCard(raceWeekends.requireValue.currentRace!)
                : Container(),
            Text("Next race:", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8.0),
            _raceWeekendCard(
              raceWeekends.requireValue.futureRaces.first,
              showLineupOpenDate: true,
            ),
            SizedBox(height: 16.0),
            Text(
              "Future races:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8.0),
            ...raceWeekends.requireValue.futureRaces
                .sublist(1)
                .map(_raceWeekendCard),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNavigationBar(),
    );
  }

  Widget _currentRaceCard(Race race) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current race:', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 8.0),
        _raceWeekendCard(race, showLineupOpenDate: true),
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget _raceWeekendCard(Race race, {bool showLineupOpenDate = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
          title: Text(race.raceName),
          leading: Image.network(
            race.circuitImage,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error);
            },
          ),
          subtitle: RichText(
            maxLines: 2,
            text: TextSpan(
              children: [
                TextSpan(text: _startsIn(race.dateStart)),
                showLineupOpenDate
                    ? _lineupOpens(
                        dateOpen: race.dateLineupOpen,
                        dateClose: race.dateLineupClose,
                      )
                    : TextSpan(),
              ],
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          trailing: _goToLineupChevron(race),
        ),
      ),
    );
  }

  String _startsIn(DateTime date) {
    final difference = date.difference(DateTime.now());
    if (difference.inDays > 0) {
      return "Starts in ${difference.inDays} days";
    } else if (difference.inHours > 0) {
      return "Starts in ${difference.inHours} hours";
    }
    return "Currently running";
  }

  TextSpan _lineupOpens({
    required DateTime dateOpen,
    required DateTime dateClose,
  }) {
    final differenceFromStart = dateOpen.difference(DateTime.now());
    final differenceFromEnd = dateClose.difference(DateTime.now());
    if (differenceFromStart.inDays > 0) {
      return TextSpan(
        text: "\nLineup opens in ${differenceFromStart.inDays} days",
      );
    } else if (differenceFromStart.inHours > 0) {
      return TextSpan(
        text: "\nLineup opens in ${differenceFromStart.inHours} hours",
      );
    } else if (differenceFromStart.inMinutes >= 0) {
      return TextSpan(
        text: "\nLineup opens in ${differenceFromEnd.inMinutes} minutes",
      );
    } else if (differenceFromEnd.inDays > 0) {
      return TextSpan(
        text: "\nLineup closes in ${differenceFromEnd.inDays} days",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    } else if (differenceFromEnd.inHours > 0) {
      return TextSpan(
        text: "\nLineup closes in ${differenceFromEnd.inHours} hours",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
      );
    } else if (differenceFromEnd.inMinutes >= 0) {
      return TextSpan(
        text: "\nLineup closes in ${differenceFromEnd.inMinutes} minutes",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
      );
    }
    return TextSpan(
      text: "\nLineup closed",
      style: Theme.of(
        context,
      ).textTheme.titleSmall!.copyWith(color: Colors.green),
    );
  }

  Widget? _goToLineupChevron(Race race) {
    return FutureBuilder(
      future: _networkTimeFuture,
      builder: (builder, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return SizedBox(height: 1, width: 1);
        }
        if (snapshot.data!.isAfter(race.dateLineupOpen) &&
            snapshot.data!.isBefore(race.dateLineupClose)) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                iconSize: 32,
                onPressed: () async => _onGoToLineupPressed(race),
                icon: Icon(Icons.chevron_right),
              ),
            ],
          );
        }
        return SizedBox(height: 1, width: 1);
      },
    );
  }

  Future<void> _onGoToLineupPressed(Race race) async {
    final teamId = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) {
        return TeamSelectModalBottomSheet();
      },
    );
    if (teamId == null || !context.mounted) {
      return;
    }
    context.pushNamed(
      RouteNames.lineup.name,
      pathParameters: {'teamId': teamId, 'raceId': race.raceId},
      extra: race,
    );
  }
}
