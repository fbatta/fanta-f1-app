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
    );
  }
}

class RaceWeekendProviderModel {
  final Race? currentRace;
  final List<Race> futureRaces;
  final List<Race> pastRaces;

  const RaceWeekendProviderModel({
    this.currentRace,
    required this.futureRaces,
    required this.pastRaces,
  });
}
