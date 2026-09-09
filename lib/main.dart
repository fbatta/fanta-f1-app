import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fanta_f1/app.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:fanta_f1/repository/driver_cost_repository.dart';
import 'package:fanta_f1/repository/driver_repository.dart';
import 'package:fanta_f1/repository/driver_summary_repository.dart';
import 'package:fanta_f1/repository/lineup_repository.dart';
import 'package:fanta_f1/repository/lobby_repository.dart';
import 'package:fanta_f1/repository/race_recap_repository.dart';
import 'package:fanta_f1/repository/race_weekend_repository.dart';
import 'package:fanta_f1/repository/team_repository.dart';
import 'package:fanta_f1/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _registerInstances();
  runApp(ProviderScope(child: const MyApp()));
}

Future<void> _registerInstances() async {
  final getIt = GetIt.instance;
  final packageInfo = await PackageInfo.fromPlatform();
  final sharedPreferences = await SharedPreferences.getInstance();
  if (Platform.isAndroid) {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    getIt.registerSingleton(deviceInfo);
  }
  if (Platform.isIOS) {
    final deviceInfo = await DeviceInfoPlugin().iosInfo;
    getIt.registerSingleton(deviceInfo);
  }

  getIt.registerSingleton(FirebaseFirestore.instance);
  getIt.registerSingleton(FirebaseStorage.instance);
  getIt.registerSingleton(FirebaseMessaging.instance);
  getIt.registerSingleton(FirebaseAuth.instance);

  getIt.registerSingleton(GoogleAuthProvider());
  getIt.registerSingleton(TimeUtils());
  getIt.registerSingleton(UserRepository());
  getIt.registerSingleton(TeamRepository());
  getIt.registerSingleton(LobbyRepository());
  getIt.registerSingleton(RaceWeekendRepository());
  getIt.registerSingleton(LineupRepository());
  getIt.registerSingleton(DriverRepository());
  getIt.registerSingleton(DriverCostRepository());
  getIt.registerSingleton(DriverSummaryRepository());
  getIt.registerSingleton(RaceRecapRepository());
  getIt.registerSingleton(packageInfo);
  getIt.registerSingleton(sharedPreferences);
}
