import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:fanta_f1/repository/lobby_repository.dart';
import 'package:fanta_f1/repository/race_weekend_repository.dart';
import 'package:fanta_f1/repository/team_repository.dart';
import 'package:fanta_f1/route/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _registerInstances();
  runApp(ProviderScope(child: const MyApp()));
}

void _registerInstances() {
  final getIt = GetIt.instance;
  getIt.registerSingleton(FirebaseAuth.instance);
  getIt.registerSingleton(FirebaseFirestore.instance);
  getIt.registerSingleton(GoogleAuthProvider());
  getIt.registerSingleton(TimeUtils());
  getIt.registerSingleton(TeamRepository());
  getIt.registerSingleton(LobbyRepository());
  getIt.registerSingleton(RaceWeekendRepository());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
