import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/dto/user/user.dart';
import 'package:fanta_f1/exception/user_not_found_exception.dart';
import 'package:fanta_f1/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../exception/validation_exception.dart';

part 'user_provider.g.dart';

@riverpod
class UserProvider extends _$UserProvider {
  late final GetIt _getIt = GetIt.instance;
  late final UserRepository _userRepository;
  late final FirebaseAuth _firebaseAuth;
  late final String? userId;

  @override
  FutureOr<User?> build() async {
    _userRepository = _getIt<UserRepository>();
    _firebaseAuth = _getIt<FirebaseAuth>();
    userId = _firebaseAuth.currentUser?.uid;

    if(userId == null) return null;

    return await _userRepository.findUser(userId!);
  }

  Future<void> updateDisplayName(String displayName) async {
    if(!_isValidDisplayName(displayName)) {
      throw ValidationException("Display name must be between 3 and 80 characters");
    }
    final user = state.value?.copyWith(
        displayName: displayName,
        updatedAt: DateTime.parse(FieldValue.serverTimestamp().toString())
    );
    if(user == null) {
      throw UserNotFoundException("Cannot update display name for user because it doesn't exist");
    }
    await _userRepository.updateUser(user);
    state = AsyncValue.data(user);
  }

  Future<void> uploadAvatar(File file) async {
    if(userId == null || state.value == null ) {
      throw UserNotFoundException('Cannot upload avatar because user is not signed in');
    }
    final fileStat = await file.stat();
    if(!_validateAvatarFileSize(fileStat)) {
      throw ValidationException("The uploaded file is too large");
    }
    final downloadUrl = await _userRepository.uploadAvatar(userId!, file);
    final user = state.value!.copyWith(
      avatarUrl: downloadUrl,
      updatedAt: DateTime.parse(FieldValue.serverTimestamp().toString())
    );
    await _userRepository.updateUser(user);
    state = AsyncValue.data(user);
  }

  bool _isValidDisplayName(String displayName) {
    if (displayName.length < 3 || displayName.length > 80) {
      return false;
    }
    return true;
  }

  ///
  /// Make sure avatar file size is less than 1mb
  bool _validateAvatarFileSize(FileStat stat) {
    return stat.size < 1 * 1024 * 1024;
  }
}
