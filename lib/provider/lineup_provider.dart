import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:fanta_f1/provider/team_provider.dart';
import 'package:fanta_f1/repository/lineup_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../dto/lineup/lineup.dart';

part 'lineup_provider.g.dart';

@riverpod
class LineupProvider extends _$LineupProvider {
  final _getIt = GetIt.instance;
  late LineupRepository _lineupRepository;
  late TimeUtils _timeUtils;

  @override
  FutureOr<void> build() async {
    _lineupRepository = _getIt();
    _timeUtils = _getIt();
  }

  Future<Lineup?> findLatestLineupForTeam(String teamId) async {
    final year = (await _timeUtils.tryGetNetworkTime()).toUtc().year;
    return await _lineupRepository.findLatestLineupByTeamId(teamId, year);
  }

  Future<Lineup?> findLineupByRaceId(String teamId, String raceId) async {
    try {
      final lineup = await _lineupRepository.findLineupById(teamId, raceId);
      return lineup;
    } catch (e) {
      // TODO: report error
      return null;
    }
  }

  Future<double> getTotalPointsForTeam(String teamId) async {
    final lineups = await _lineupRepository.getLineupsByTeamId(teamId);

    final score = lineups.fold(0.0, (acc, lineup) {
      if (lineup.score != null) {
        return acc + lineup.score!;
      }
      return acc;
    });

    return score;
  }

  Future<void> createOrUpdateLineup(Lineup lineup) async {
    await _lineupRepository.createOrUpdateLineup(lineup);
  }

  Future<Map<Team, Lineup>> getLineupsInLobbyForRace(
    String lobbyId,
    String raceId,
  ) async {
    final teams = await ref
        .watch(teamProviderProvider.notifier)
        .getTeamsInLobby(lobbyId);
    final teamIds = teams.map((team) => team.teamId).toList();
    final lineups = await _lineupRepository.getLineupsByTeamIdsAndRaceId(
      teamIds,
      raceId,
    );
    final lineupsMap = <Team, Lineup>{};
    for (final lineup in lineups) {
      final team = teams.firstWhere((team) => team.teamId == lineup.teamId);
      lineupsMap[team] = lineup;
    }
    return lineupsMap;
  }
}
