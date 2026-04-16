import 'dart:io';

import 'package:fanta_f1/component/app_bar_user_action.dart';
import 'package:fanta_f1/component/main_bottom_navigation_bar.dart';
import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/dto/app_preferences.dart';
import 'package:fanta_f1/dto/lobby/lobby.dart';
import 'package:fanta_f1/dto/team/team.dart';
import 'package:fanta_f1/provider/lobby_provider.dart';
import 'package:fanta_f1/provider/preferences_provider.dart';
import 'package:fanta_f1/provider/team_provider.dart';
import 'package:fanta_f1/provider/user_provider.dart';
import 'package:fanta_f1/route/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final _getIt = GetIt.instance;
  late final FirebaseAuth _auth;
  late final FirebaseMessaging _messaging;

  @override
  void initState() {
    _auth = _getIt();
    _messaging = _getIt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final teams = ref.watch(teamProviderProvider);
    final lobbies = ref.watch(lobbyProviderProvider);
    final userInfo = ref.watch(userProviderProvider);
    final preferences = ref.watch(preferencesProviderProvider);

    if (!userInfo.isLoading &&
        !userInfo.hasError &&
        userInfo.hasValue &&
        !preferences.isLoading &&
        !preferences.hasError &&
        preferences.hasValue) {
      Future.delayed(
        Duration.zero,
        () async => _requestNotificationsPermission(preferences.requireValue),
      );
    }

    if (teams.isLoading ||
        teams.isRefreshing ||
        lobbies.isLoading ||
        lobbies.isRefreshing) {
      return const Scaffold(body: SpinnerCentered(text: "Loading teams..."));
    }
    if (teams.hasError || lobbies.hasError) {
      return Scaffold(
        appBar: _appBar(user),
        body: Center(child: Text(teams.error.toString())),
      );
    }
    if (teams.requireValue.isEmpty) {
      return Scaffold(appBar: _appBar(user), body: _noTeams());
    }

    return Scaffold(
      appBar: _appBar(user),
      body: _teamsList(teams.requireValue, lobbies.requireValue),
      bottomNavigationBar: MainBottomNavigationBar(),
    );
  }

  Widget _teamsList(Map<String, Team> teams, Map<String, Lobby> lobbies) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams.values.elementAt(index);
              final lobby = lobbies[team.lobbyId];

              return _teamCard(team, lobby!);
            },
          ),
        ),
        Positioned(bottom: 40, right: 20, child: _createTeamOrLobbyFab()),
      ],
    );
  }

  Widget _teamCard(Team team, Lobby lobby) {
    return InkWell(
      onTap: () => context.pushNamed(
        RouteNames.team.toString(),
        pathParameters: {'teamId': team.teamId},
      ),
      child: Card(
        child: ListTile(
          title: Text(team.teamName),
          subtitle: Text("Lobby: ${lobby.lobbyName}"),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(25.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: team.teamAvatarUrl != null
                    ? NetworkImage(team.teamAvatarUrl!)
                    : AssetImage('assets/images/idgaf1_default_avatar.png'),
              ),
            ),
          ),
          trailing: Text(
            team.points[DateTime.now().year].toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }

  Widget _noTeams() {
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No teams found'),
                  const SizedBox(height: 24.0),
                  FilledButton(
                    onPressed: () => _onAddNewTeamPressed(context),
                    child: const Text('Add new'),
                  ),
                ],
              ),
            ),
            Positioned(bottom: 40, right: 20, child: _createTeamOrLobbyFab()),
          ],
        );
      },
    );
  }

  Widget _createTeamOrLobbyFab() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              tooltip: 'Create new lobby',
              heroTag: 'createNewLobbyFab',
              onPressed: () => _onAddNewLobbyPressed(context),
              child: Icon(Icons.groups),
            ),
            SizedBox(height: 12.0),
            FloatingActionButton.extended(
              tooltip: 'Create new team',
              heroTag: 'createNewTeamFab',
              onPressed: () => _onAddNewTeamPressed(context),
              icon: Icon(Icons.add),
              label: Text('New team'),
            ),
          ],
        );
      },
    );
  }

  PreferredSizeWidget _appBar(User? user) {
    return AppBar(
      title: Text('Home'),
      actions: [AppBarUserAction(user: user)],
    );
  }

  void _onAddNewTeamPressed(BuildContext context) {
    context.pushNamed(RouteNames.addTeam.name);
  }

  void _onAddNewLobbyPressed(BuildContext context) {
    context.pushNamed(RouteNames.addLobby.name);
  }

  Future<void> _requestNotificationsPermission(
    AppPreferences preferences,
  ) async {
    if (!preferences.hasRequestedNotificationsPermission) {
      final notificationSettings = await _messaging.requestPermission();
      if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.authorized) {
        if (Platform.isIOS) {
          await _messaging.getAPNSToken();
        }
        final token = await _messaging.getToken();
        if (token != null) {
          await ref
              .read(preferencesProviderProvider.notifier)
              .setNotificationsPermission(true, token);
        }
      } else {
        await ref
            .read(preferencesProviderProvider.notifier)
            .setNotificationsPermission(false, null);
      }
    }
  }
}
