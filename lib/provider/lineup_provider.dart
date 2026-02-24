import 'package:fanta_f1/repository/lineup_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lineup_provider.g.dart';

@riverpod
class LineupProvider extends _$LineupProvider {
  final _getIt = GetIt.instance;
  late final LineupRepository _lineupRepository;

  @override
  FutureOr<void> build() async {
    _lineupRepository = _getIt();
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
}
