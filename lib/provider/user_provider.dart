import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fanta_f1/dto/user/user.dart';
import 'package:fanta_f1/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserProvider extends _$UserProvider {
  final GetIt _getIt = GetIt.instance;
  late UserRepository _userRepository;
  late FirebaseAuth _firebaseAuth;
  late final AndroidDeviceInfo _androidDeviceInfo;
  late final IosDeviceInfo _iosDeviceInfo;
  late final String? userId;

  @override
  FutureOr<User?> build() async {
    _userRepository = _getIt();
    _firebaseAuth = _getIt();
    userId = _firebaseAuth.currentUser?.uid;
    if (Platform.isAndroid) {
      _androidDeviceInfo = _getIt();
    }
    if (Platform.isIOS) {
      _iosDeviceInfo = _getIt();
    }

    final user = await _userRepository.findUser(userId!);
    if (user == null) {
      final newUser = User(
        userId: userId!,
        privileges: [],
        deviceRegistrationTokens: {},
      );
      await _userRepository.createOrUpdateUser(newUser);
      return newUser;
    }
    return user;
  }

  Future<void> addDeviceRegistrationToken(String token) async {
    User? user = state.value;
    if (user == null) {
      user = User(
        userId: userId!,
        privileges: [],
        deviceRegistrationTokens: {token: _getDeviceModel()},
      );
      await _userRepository.createOrUpdateUser(user);
    } else {
      user.deviceRegistrationTokens[token] = _getDeviceModel();
      await _userRepository.createOrUpdateUser(user);
    }

    state = AsyncValue.data(user);
  }

  Future<void> removeDeviceRegistrationToken(String token) async {
    User? user = state.value;
    if (user == null) return;

    user.deviceRegistrationTokens.remove(token);
    await _userRepository.createOrUpdateUser(user);

    state = AsyncValue.data(user);
  }

  String _getDeviceModel() {
    if (Platform.isAndroid) {
      return _androidDeviceInfo.model;
    }
    if (Platform.isIOS) {
      return _iosDeviceInfo.model;
    }
    return 'Unknown device';
  }
}
