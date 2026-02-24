import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/driver/driver.dart';
import 'package:get_it/get_it.dart';

class DriverRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _driversCollection;

  DriverRepository() {
    _firestore = _getIt();
    _driversCollection = _firestore.collection('drivers');
  }

  Future<List<Driver>> getDrivers() async {
    final snapshot = await _driversCollection.get();
    return snapshot.docs
        .map((doc) => Driver.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
