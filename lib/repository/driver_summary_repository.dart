import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/driver_summary/driver_summary.dart';
import 'package:get_it/get_it.dart';

class DriverSummaryRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _driverSummariesCollection;

  DriverSummaryRepository() {
    _firestore = _getIt();
    _driverSummariesCollection = _firestore.collection('driver_summaries');
  }

  Future<DriverSummary?> getDriverSummary(String driverId) async {
    final snapshot = await _driverSummariesCollection.doc(driverId).get();
    if (!snapshot.exists) {
      return null;
    }
    return DriverSummary.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}
