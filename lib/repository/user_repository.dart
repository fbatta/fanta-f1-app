import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/user/user.dart';
import 'package:fanta_f1/exception/user_already_exists_exception.dart';
import 'package:get_it/get_it.dart';

class UserRepository {
  final _getIt = GetIt.instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _usersCollection;

  UserRepository() {
    _firestore = _getIt();
    _usersCollection = _firestore.collection('users');
  }

  ///
  /// Get user by id
  ///
  /// Returns null if user is not found
  Future<User?> findUser(String userId) async {
    try {
      final doc = await _usersCollection.doc(userId).get();
      return User.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  ///
  /// Create a new user
  ///
  /// Throws [UserAlreadyExistsException] if user already exists
  Future<void> createOrUpdateUser(User user) async {
    await _usersCollection.doc(user.userId).set(user.toJson());
  }
}
