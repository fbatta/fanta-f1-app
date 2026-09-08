import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fanta_f1/dto/push_notification/push_notification.dart';
import 'package:fanta_f1/dto/push_notification/push_notification_type.dart';
import 'package:fanta_f1/helper/time_utils.dart';
import 'package:fanta_f1/provider/preferences_provider.dart';
import 'package:fanta_f1/provider/race_weekend_provider.dart';
import 'package:fanta_f1/provider/team_provider.dart';
import 'package:fanta_f1/repository/driver_cost_repository.dart';
import 'package:fanta_f1/repository/driver_repository.dart';
import 'package:fanta_f1/repository/driver_summary_repository.dart';
import 'package:fanta_f1/repository/lineup_repository.dart';
import 'package:fanta_f1/repository/lobby_repository.dart';
import 'package:fanta_f1/repository/race_recap_repository.dart';
import 'package:fanta_f1/repository/race_weekend_repository.dart';
import 'package:fanta_f1/repository/team_repository.dart';
import 'package:fanta_f1/repository/user_repository.dart';
import 'package:fanta_f1/route/route_names.dart';
import 'package:fanta_f1/route/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
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

class MyApp extends ConsumerStatefulWidget {
  final GoRouter? routerConfig;
  final Stream<RemoteMessage>? onMessageOpenedApp;
  const MyApp({
    super.key,
    this.routerConfig,
    this.onMessageOpenedApp,
  });

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _getIt = GetIt.instance;
  late final FirebaseMessaging _messaging;
  late final FirebaseAuth _auth;

  GoRouter get _router => widget.routerConfig ?? router;

  @override
  void initState() {
    _messaging = _getIt();
    _auth = _getIt();
    super.initState();

    _setupInteractedMessage();

    _messaging.onTokenRefresh.listen(_onDeviceTokenRefreshed);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'IDGAF-1',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
    );
  }

  Future<void> _onDeviceTokenRefreshed(String token) async {
    await ref
        .read(preferencesProviderProvider.notifier)
        .updateDeviceToken(token);
  }

  Future<void> _setupInteractedMessage() async {
    final initialMessage = await _messaging.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    final messageOpenedStream =
        widget.onMessageOpenedApp ?? FirebaseMessaging.onMessageOpenedApp;
    messageOpenedStream.listen(_handleMessage);
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    final data = PushNotification.fromJson(message.data);
    if (_auth.currentUser == null) {
      _router.goNamed(RouteNames.signIn.name);
      return;
    }

    switch (data.type) {
      case PushNotificationType.lineupOpen:
      case PushNotificationType.lineupReminder:
      case PushNotificationType.lineupClosing:
        final race = await ref
            .read(raceWeekendProviderProvider.notifier)
            .getRaceById(data.raceId ?? '');
        if (!mounted) return;
        if (race == null) {
          _router.goNamed(RouteNames.signIn.name);
        }
        _router.goNamed(RouteNames.calendar.name);
        break;
      case PushNotificationType.lineupClosed:
        // TODO: Handle this case.
        throw UnimplementedError();
      case PushNotificationType.raceWeekendResultsAvailable:
        final raceId = data.raceId;
        final teamId = data.teamId;
        if (raceId == null ||
            raceId.isEmpty ||
            teamId == null ||
            teamId.isEmpty) {
          _router.goNamed(RouteNames.calendar.name);
          break;
        }

        final team = await ref
            .read(teamProviderProvider.notifier)
            .getTeamById(teamId);
        if (!mounted) return;
        if (team == null) {
          _router.goNamed(RouteNames.calendar.name);
          break;
        }

        final lobbyId = (data.lobbyId != null && data.lobbyId!.isNotEmpty)
            ? data.lobbyId!
            : team.lobbyId;

        if (lobbyId.isEmpty) {
          _router.goNamed(RouteNames.calendar.name);
          break;
        }

        _router.goNamed(
          RouteNames.raceResults.name,
          pathParameters: {
            'raceId': raceId,
            'teamId': teamId,
            'lobbyId': lobbyId,
          },
        );
        break;
      case PushNotificationType.driversPricesUpdated:
        _router.goNamed(RouteNames.home.name);
        break;
    }
  }
}
