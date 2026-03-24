import 'package:fanta_f1/dto/race/race.dart';
import 'package:fanta_f1/repository/race_weekend_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'race_weekend_provider.g.dart';

@riverpod
class RaceWeekendProvider extends _$RaceWeekendProvider {
  final _getIt = GetIt.instance;
  late RaceWeekendRepository _raceWeekendRepository;

  @override
  FutureOr<RaceWeekendProviderModel> build() async {
    _raceWeekendRepository = _getIt();

    final currentYear = DateTime.now().year;
    final futureRaces = await _raceWeekendRepository.getFutureRacesForYear(
      currentYear,
    );
    final currentRace = await _raceWeekendRepository.getCurrentRace();
    final pastRaces = await _raceWeekendRepository.getPastRacesForYear(
      currentYear,
    );

    return RaceWeekendProviderModel(
      currentRace: currentRace,
      futureRaces: futureRaces,
      pastRaces: pastRaces,
      allRaces: futureRaces + pastRaces + [?currentRace],
    );
  }

  Future<Race?> getRaceById(String raceId) async {
    final currentState = state.requireValue;

    final race = currentState.allRaces.firstWhere(
      (race) => race.raceId == raceId,
      orElse: () => Race.emptyRace(),
    );
    if (race.raceId != '') {
      return race;
    }

    try {
      return await _raceWeekendRepository.getRaceById(raceId);
    } catch (e) {
      // TODO: report error
      return null;
    }
  }
}

class RaceWeekendProviderModel {
  final Race? currentRace;
  final List<Race> futureRaces;
  final List<Race> pastRaces;
  final List<Race> allRaces;

  const RaceWeekendProviderModel({
    this.currentRace,
    required this.futureRaces,
    required this.pastRaces,
    required this.allRaces,
  });
}
