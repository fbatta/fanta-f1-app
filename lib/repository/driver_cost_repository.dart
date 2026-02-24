import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/driver_cost/driver_cost.dart';
import 'package:get_it/get_it.dart';

class DriverCostRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _driverCostsCollection;

  DriverCostRepository() {
    _firestore = _getIt();
    _driverCostsCollection = _firestore.collection('driver_costs');
  }

  Future<List<DriverCost>> getDriverCosts() async {
    final snapshot = await _driverCostsCollection.get();
    return snapshot.docs
        .map((doc) => DriverCost.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
