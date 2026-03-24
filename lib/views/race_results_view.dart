import 'package:fanta_f1/component/error_card.dart';
import 'package:fanta_f1/component/scores_list.dart';
import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/dto/driver/driver.dart';
import 'package:fanta_f1/dto/lineup/lineup.dart';
import 'package:fanta_f1/dto/race/race.dart';
import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/helper/color_utils.dart';
import 'package:fanta_f1/provider/driver_provider.dart';
import 'package:fanta_f1/provider/lineup_provider.dart';
import 'package:fanta_f1/provider/lobby_provider.dart';
import 'package:fanta_f1/provider/race_weekend_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RaceResultsView extends ConsumerStatefulWidget {
  final String raceId;
  final String teamId;
  final String lobbyId;
  const RaceResultsView({
    super.key,
    required this.raceId,
    required this.teamId,
    required this.lobbyId,
  });

  @override
  ConsumerState createState() => _RaceResultsViewState();
}

class _RaceResultsViewState extends ConsumerState<RaceResultsView> {
  late final Future<Map<Team, Lineup>> _lineupsFuture;
  late final Future<Race?> _raceFuture;

  @override
  void initState() {
    _lineupsFuture = ref
        .read(lineupProviderProvider.notifier)
        .getLineupsInLobbyForRace(widget.lobbyId, widget.raceId);
    _raceFuture = ref
        .read(raceWeekendProviderProvider.notifier)
        .getRaceById(widget.raceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lobbyProvider = ref.watch(lobbyProviderProvider);
    final driverProvider = ref.watch(driverProviderProvider);

    if (lobbyProvider.isLoading ||
        lobbyProvider.isRefreshing ||
        driverProvider.isLoading ||
        driverProvider.isRefreshing) {
      return Scaffold(
        appBar: _appBar(),
        body: SpinnerCentered(text: 'Loading results'),
      );
    }

    if (lobbyProvider.hasError) {
      return _errorScaffold();
    }
    final lobby = lobbyProvider.requireValue[widget.lobbyId];
    if (lobby == null) {
      return _errorScaffold();
    }

    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            _raceInfo(),
            _scores(
              drivers: {
                for (final driver in driverProvider.requireValue.keys)
                  driver.acronym: driver,
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _raceInfo() {
    return FutureBuilder(
      future: _raceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinnerCentered(text: 'Loading race info');
        }

        if (snapshot.hasError) {
          return ErrorCard(message: 'Error loading race info');
        }

        final race = snapshot.requireData;
        if (race == null) {
          return ErrorCard(message: 'Error loading race info');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text('Race info:', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8.0),
            Card(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.network(race.circuitImage, width: 200),
                        Positioned(
                          right: 0,
                          width: 60,
                          child: Image.network(race.countryFlag),
                        ),
                      ],
                    ),
                    _tableRow(
                      label: 'Name',
                      value: race.raceName,
                      withDivider: true,
                    ),
                    _tableRow(
                      label: 'Country',
                      value: race.countryName,
                      withDivider: true,
                    ),
                    _tableRow(
                      label: 'Date',
                      value: DateFormat('MMMM dd, yyyy').format(race.dateStart),
                      withDivider: true,
                    ),
                    _tableRow(label: 'Circuit type', value: race.circuitType),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _tableRow({
    required String label,
    required String value,
    bool? withDivider = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Spacer(flex: 1),
          Text(value, style: Theme.of(context).textTheme.labelLarge),
          withDivider == true ? Divider() : Container(),
        ],
      ),
    );
  }

  Widget _scores({required Map<String, Driver> drivers}) {
    return FutureBuilder(
      future: _lineupsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinnerCentered(text: 'Loading results');
        }
        if (snapshot.hasError) {
          return ErrorCard(message: 'Error loading results');
        }
        final scoresAndAvatars = snapshot.requireData.entries
            .map(
              (entry) => ScoresAndAvatars(
                name: entry.key.teamName,
                score: entry.value.score ?? 0.0,
                avatar: entry.key.teamAvatarUrl,
                onPressed: () => _showLineupBottomSheet(
                  lineup: entry.value,
                  drivers: drivers,
                ),
              ),
            )
            .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text("Results:", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8.0),
            Card(child: scoresList(scoresAndAvatars)),
          ],
        );
      },
    );
  }

  void _showLineupBottomSheet({
    required Lineup lineup,
    required Map<String, Driver> drivers,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          semanticChildCount: lineup.drivers.length,
          children: [
            SizedBox(height: 16),
            ...lineup.drivers.map((driver) {
              return ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        drivers[driver.driverAcronym]!.driverAvatar,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  '${driver.driverNumber}\t${drivers[driver.driverAcronym]!.name}',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: ColorUtils.convertHexToColor(
                      drivers[driver.driverAcronym]!.teamColour,
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _errorScaffold() {
    return Scaffold(
      appBar: _appBar(),
      body: Center(child: ErrorCard(message: 'Error loading results')),
    );
  }

  PreferredSizeWidget _appBar() => AppBar(title: Text('Race results'));
}
