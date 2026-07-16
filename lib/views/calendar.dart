import 'package:fanta_f1/component/main_bottom_navigation_bar.dart';
import 'package:fanta_f1/component/section_header.dart';
import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/component/team_select_modal_bottom_sheet.dart';
import 'package:fanta_f1/dto/race/race.dart';
import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:fanta_f1/provider/race_weekend_provider.dart';
import 'package:fanta_f1/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class Calendar extends ConsumerStatefulWidget {
  final String? raceId;
  const Calendar({super.key, this.raceId});

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

    if (widget.raceId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onGoToLineupPressed(widget.raceId!);
      });
    }
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
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            raceWeekends.requireValue.currentRace != null
                ? _currentRaceCard(raceWeekends.requireValue.currentRace!)
                : Container(),
            sectionHeader('Next race'),
            SizedBox(height: 8.0),
            _raceWeekendCard(
              raceWeekends.requireValue.futureRaces.first,
              showLineupOpenDate: true,
            ),
            SizedBox(height: 16.0),
            sectionHeader('Future races'),
            SizedBox(height: 8.0),
            ...raceWeekends.requireValue.futureRaces
                .sublist(1)
                .map(_raceWeekendCard),
            SizedBox(height: 16.0),
            sectionHeader('Past races'),
            SizedBox(height: 8.0),
            ...raceWeekends.requireValue.pastRaces
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
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          title: Text(race.raceName),
          leading: Image.network(
            race.circuitImage,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error);
            },
          ),
          subtitle: RichText(
            maxLines: 3,
            text: TextSpan(
              children: [
                TextSpan(
                  text: _startsIn(start: race.dateStart, end: race.dateEnd),
                ),
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
          trailing: _goToLineupOrResultsChevron(race),
        ),
      ),
    );
  }

  String _startsIn({required DateTime start, required DateTime end}) {
    final now = DateTime.now();
    final differenceFromStart = start.difference(now);
    final differenceFromEnd = end.difference(now);
    if (differenceFromStart.inDays > 0) {
      return "Starts in ${differenceFromStart.inDays} days and ${differenceFromStart.inHours % 24} hours";
    } else if (differenceFromStart.inHours > 0) {
      return "Starts in ${differenceFromStart.inHours} hours";
    } else if (differenceFromEnd.inMilliseconds > 0) {
      return "Currently running";
    }
    return 'Finished';
  }

  TextSpan _lineupOpens({
    required DateTime dateOpen,
    required DateTime dateClose,
  }) {
    final differenceFromStart = dateOpen.difference(DateTime.now());
    final differenceFromEnd = dateClose.difference(DateTime.now());
    if (differenceFromStart.inDays > 0) {
      return TextSpan(
        text:
            "\nLineup opens in ${differenceFromStart.inDays} days and ${differenceFromStart.inHours % 24} hours",
      );
    } else if (differenceFromStart.inHours > 0) {
      return TextSpan(
        text:
            "\nLineup opens in ${differenceFromStart.inHours} hours and ${differenceFromStart.inMinutes % 60} minutes",
      );
    } else if (differenceFromStart.inMinutes >= 0) {
      return TextSpan(
        text: "\nLineup opens in ${differenceFromEnd.inMinutes} minutes",
      );
    } else if (differenceFromEnd.inDays > 0) {
      return TextSpan(
        text:
            "\nLineup closes in ${differenceFromEnd.inDays} days and ${differenceFromEnd.inHours % 24} hours",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    } else if (differenceFromEnd.inHours > 0) {
      return TextSpan(
        text:
            "\nLineup closes in ${differenceFromEnd.inHours} hours and ${differenceFromEnd.inMinutes % 60} minutes",
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

  Widget? _goToLineupOrResultsChevron(Race race) {
    return FutureBuilder(
      future: _networkTimeFuture,
      builder: (builder, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return SizedBox(height: 1, width: 1);
        }

        if (snapshot.data!.isAfter(race.dateLineupOpen) &&
            snapshot.data!.isBefore(race.dateLineupClose)) {
          return _chevron(
            onPressed: () async => _onGoToLineupPressed(race.raceId),
          );
        } else if (snapshot.data!.isAfter(race.dateLineupClose)) {
          return _chevron(
            onPressed: () async => _onGoToResultsPressed(race.raceId),
          );
        }
        return SizedBox(height: 1, width: 1);
      },
    );
  }

  Widget _chevron({required void Function()? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          iconSize: 32,
          onPressed: onPressed,
          icon: Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Future<void> _onGoToLineupPressed(String raceId) async {
    final team = await showModalBottomSheet<Team?>(
      context: context,
      builder: (context) {
        return TeamSelectModalBottomSheet();
      },
    );
    if (team == null || !mounted) {
      return;
    }
    context.pushNamed(
      RouteNames.lineup.name,
      pathParameters: {'teamId': team.teamId, 'raceId': raceId},
    );
  }

  Future<void> _onGoToResultsPressed(String raceId) async {
    final team = await showModalBottomSheet<Team?>(
      context: context,
      builder: (context) {
        return TeamSelectModalBottomSheet();
      },
    );

    if (team == null || !mounted) {
      return;
    }
    context.pushNamed(
      RouteNames.raceResults.name,
      pathParameters: {
        'teamId': team.teamId,
        'lobbyId': team.lobbyId,
        'raceId': raceId,
      },
    );
  }
}
