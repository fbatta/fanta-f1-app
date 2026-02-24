import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/race/race.dart';
import 'package:get_it/get_it.dart';

class RaceWeekendRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _races;

  RaceWeekendRepository() {
    _firestore = _getIt();
    _races = _firestore.collection('races');
  }

  Future<List<Race>> getFutureRacesForYear(int year) async {
    final dateStart = DateTime.now();
    final dateEnd = DateTime(year, 12, 31);

    final snapshot = await _races
        .where(
          'dateEnd',
          isGreaterThanOrEqualTo: dateStart.millisecondsSinceEpoch,
        )
        .where('dateStart', isLessThanOrEqualTo: dateEnd.millisecondsSinceEpoch)
        .orderBy('dateStart')
        .get();
    return snapshot.docs
        .map((doc) => Race.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
