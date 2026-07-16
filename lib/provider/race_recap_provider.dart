import 'package:fanta_f1/dto/race_recap/race_recap.dart';
import 'package:fanta_f1/repository/race_recap_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'race_recap_provider.g.dart';

@riverpod
class RaceRecapProvider extends _$RaceRecapProvider {
  final _getIt = GetIt.instance;
  late RaceRecapRepository _raceRecapRepository;

  @override
  FutureOr<RaceRecap?> build(String raceId) async {
    _raceRecapRepository = _getIt();
    return await _raceRecapRepository.getRaceRecap(raceId);
  }
}
