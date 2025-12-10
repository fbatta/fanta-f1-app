import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/user/user.dart';
import 'package:fanta_f1/exception/user_already_exists_exception.dart';
import 'package:fanta_f1/exception/user_not_found_exception.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  late final FirebaseFirestore _firestore;
  late final FirebaseStorage _storage;
  late final CollectionReference _usersCollection;

  UserRepository(FirebaseFirestore firestoreInstance, FirebaseStorage storageInstance) {
    _firestore = firestoreInstance;
    _storage = storageInstance;
    _usersCollection = _firestore.collection('users');
  }

  ///
  /// Get user by id
  ///
  /// Throws [UserNotFoundException] if user is not found
  ///
  Future<User> getUser(String userId) async {
    final doc = await _usersCollection.doc(userId).get();
    if(!doc.exists) {
      throw UserNotFoundException("Cannot find user with id $userId");
    }
    return User.fromJson(doc.data() as Map<String, dynamic>);
  }

  ///
  /// Get user by id
  ///
  /// Returns null if user is not found
  Future<User?> findUser(String userId) async {
    try {
      return await getUser(userId);
    } on UserNotFoundException {
      return null;
    }
  }

  ///
  /// Create a new user
  ///
  /// Throws [UserAlreadyExistsException] if user already exists
  Future<void> createUser(User user) async {
    final ref = _usersCollection.doc(user.userId);
    final snapshot = await ref.get();
    if(snapshot.exists) {
      throw UserAlreadyExistsException("User with id ${user.userId} already exists and cannot be overwritten");
    }
    await ref.set(user.toJson());
  }

  ///
  /// Update an existing user
  ///
  /// Throws [UserNotFoundException] if user is not found
  Future<void> updateUser(User user) async {
    final ref = _usersCollection.doc(user.userId);
    final snapshot = await ref.get();
    if(!snapshot.exists) {
      throw UserNotFoundException("Cannot find user with id ${user.userId}");
    }
    await ref.update(user.toJson());
  }

  Future<String> uploadAvatar(String userId, File file) async {
    final ref = _storage.ref('/avatars/$userId');
    final task = await ref.putFile(file);
    return task.ref.getDownloadURL();
  }
}