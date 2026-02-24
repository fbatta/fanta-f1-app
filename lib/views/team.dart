import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/dto/team/team.dart' as team_dto;
import 'package:fanta_f1/provider/team_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    if (teams.isLoading || teams.isRefreshing) {
      return Scaffold(
        body: Center(child: SpinnerCentered(text: 'Loading team...')),
      );
    }
    if (teams.hasError) {
      return Scaffold(body: Center(child: Text(teams.error.toString())));
    }
    final team = teams.requireValue[widget.teamId]!;

    return Scaffold(
      appBar: AppBar(title: Text(team.teamName)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(children: [_teamAvatar(team), _currentStandings(team)]),
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
              image: team.teamAvatarUrl != null
                  ? NetworkImage(team.teamAvatarUrl!)
                  : AssetImage('assets/images/idgaf1_default_avatar.png'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _currentStandings(team_dto.Team team) {
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
                child: Column(
                  children: [
                    SizedBox(height: 8.0),
                    ...standings.map(
                      (standing) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(standing.teamName),
                            Text(
                              standing.points[team.createdAt.year].toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
