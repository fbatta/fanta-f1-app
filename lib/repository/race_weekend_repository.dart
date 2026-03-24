import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/race/race.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:get_it/get_it.dart';

class RaceWeekendRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _races;
  late final TimeUtils _timeUtils;

  RaceWeekendRepository() {
    _firestore = _getIt();
    _timeUtils = _getIt();
    _races = _firestore.collection('races');
  }

  Future<Race?> getRaceById(String raceId) async {
    final snapshot = await _races.doc(raceId).get();
    return snapshot.exists
        ? Race.fromJson(snapshot.data() as Map<String, dynamic>)
        : null;
  }

  Future<List<Race>> getFutureRacesForYear(int year) async {
    final dateStart = (await _timeUtils.tryGetNetworkTime()).toUtc();
    final dateEnd = DateTime(year, 12, 31).toUtc();

    final snapshot = await _races
        .where('dateEnd', isLessThanOrEqualTo: dateEnd.millisecondsSinceEpoch)
        .where('dateStart', isGreaterThan: dateStart.millisecondsSinceEpoch)
        .orderBy('dateStart')
        .get();
    return snapshot.docs
        .map((doc) => Race.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<Race?> getCurrentRace() async {
    final dateStart = (await _timeUtils.tryGetNetworkTime()).toUtc();
    final snapshot = await _races
        .where(
          'dateStart',
          isLessThanOrEqualTo: dateStart.millisecondsSinceEpoch,
        )
        .where(
          'dateEnd',
          isGreaterThanOrEqualTo: dateStart.millisecondsSinceEpoch,
        )
        .orderBy('dateStart')
        .get();
    return snapshot.docs.isEmpty
        ? null
        : Race.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);
  }

  Future<List<Race>> getPastRacesForYear(int year) async {
    final dateEnd = (await _timeUtils.tryGetNetworkTime()).toUtc();
    final dateStart = DateTime(year, 1, 1).toUtc();

    final snapshot = await _races
        .where('dateEnd', isLessThanOrEqualTo: dateEnd.millisecondsSinceEpoch)
        .where('dateStart', isGreaterThan: dateStart.millisecondsSinceEpoch)
        .orderBy('dateStart')
        .get();
    return snapshot.docs
        .map((doc) => Race.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
