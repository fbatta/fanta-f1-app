import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/race_recap/race_recap.dart';
import 'package:get_it/get_it.dart';

class RaceRecapRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _raceRecapCollection;

  RaceRecapRepository() {
    _firestore = _getIt();
    _raceRecapCollection = _firestore.collection('race_weekend_recaps');
  }

  Future<RaceRecap?> getRaceRecap(String raceId) async {
    final snapshot = await _raceRecapCollection.doc(raceId).get();
    if (!snapshot.exists) {
      return null;
    }
    return RaceRecap.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}
