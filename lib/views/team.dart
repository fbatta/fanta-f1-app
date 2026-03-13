import 'package:fanta_f1/component/error_card.dart';
import 'package:fanta_f1/component/scores_list.dart';
import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/dto/driver/driver.dart';
import 'package:fanta_f1/dto/driver_cost/driver_cost.dart';
import 'package:fanta_f1/dto/team/team.dart' as team_dto;
import 'package:fanta_f1/helper/color_utils.dart';
import 'package:fanta_f1/provider/driver_provider.dart';
import 'package:fanta_f1/provider/lineup_provider.dart';
import 'package:fanta_f1/provider/team_provider.dart';
import 'package:fanta_f1/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Team extends ConsumerStatefulWidget {
  final String teamId;
  const Team({super.key, required this.teamId});

  @override
  ConsumerState createState() => _TeamState();
}

class _TeamState extends ConsumerState<Team> {
  @override
  Widget build(BuildContext context) {
    final teams = ref.watch(teamProviderProvider);
    final drivers = ref.watch(driverProviderProvider);

    if (teams.isLoading ||
        teams.isRefreshing ||
        drivers.isLoading ||
        drivers.isRefreshing) {
      return Scaffold(
        body: Center(child: SpinnerCentered(text: 'Loading team...')),
      );
    }
    if (teams.hasError || drivers.hasError) {
      return Scaffold(body: Center(child: Text(drivers.error.toString())));
    }
    final team = teams.requireValue[widget.teamId]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(team.teamName),
        actions: [
          IconButton(
            onPressed: () => _onEditTeamPressed(team),
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            _teamAvatar(team),
            _currentStandingsCard(team),
            _latestLineupCard(team, drivers.requireValue),
          ],
        ),
      ),
    );
  }

  Widget _teamAvatar(team_dto.Team team) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: team.teamAvatarUrl != null
                  ? NetworkImage(team.teamAvatarUrl!)
                  : AssetImage('assets/images/idgaf1_default_avatar.png'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _currentStandingsCard(team_dto.Team team) {
    return FutureBuilder<List<team_dto.Team>>(
      future: ref
          .read(teamProviderProvider.notifier)
          .getStandingsForLobby(team.lobbyId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SpinnerCentered(text: 'Loading standings...'),
          );
        }
        if (snapshot.hasError) {
          return Card(child: Text("Could not load standings"));
        }
        final standings = snapshot.requireData;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Standings:', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 8.0),
              Card(
                child: scoresList(
                  standings.map((standing) {
                    return ScoresAndAvatars(
                      name: standing.teamName,
                      score: standing.points[DateTime.now().year]!,
                      avatar: standing.teamAvatarUrl,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _teamScore(team_dto.Team standing, int year) {
    return Text(
      standing.points[year].toString(),
      style: Theme.of(context).textTheme.labelLarge,
    );
  }

  Widget _latestLineupCard(
    team_dto.Team team,
    Map<Driver, DriverCost> drivers,
  ) {
    return FutureBuilder(
      future: ref
          .read(lineupProviderProvider.notifier)
          .findLatestLineupForTeam(team.teamId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SpinnerCentered(),
          );
        }
        if (snapshot.hasError) {
          return ErrorCard(message: 'Could not load latest lineup');
        }
        final lineup = snapshot.data;
        if (lineup == null) {
          return ErrorCard(message: 'No lineup found');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Latest lineup:',
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
                  itemCount: lineup.drivers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.4,
                  ),
                  itemBuilder: (context, index) {
                    final lineupDriver = lineup.drivers[index];
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
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: ColorUtils.convertHexToColor(
                                  driver.teamColour,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onEditTeamPressed(team_dto.Team team) {
    context.pushNamed(
      RouteNames.editTeam.name,
      pathParameters: {'teamId': widget.teamId},
      extra: team,
    );
  }
}
