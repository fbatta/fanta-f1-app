import 'package:fanta_f1/component/app_bar_user_action.dart';
import 'package:fanta_f1/component/spinner_centered.dart';
import 'package:fanta_f1/provider/team_provider.dart';
import 'package:fanta_f1/route/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class Home extends ConsumerWidget {
  final _getIt = GetIt.instance;
  late final FirebaseAuth _auth;

  Home({super.key}) {
    _auth = _getIt.get<FirebaseAuth>();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = _auth.currentUser;
    final teams = ref.watch(teamProviderProvider);

    if (teams.isLoading || teams.isRefreshing) {
      return const Scaffold(body: SpinnerCentered(text: "Loading teams..."));
    }
    if (teams.hasError) {
      return Scaffold(
        appBar: _appBar(user),
        body: Center(child: Text(teams.error.toString())),
      );
    }
    if (teams.requireValue.isEmpty) {
      return Scaffold(appBar: _appBar(user), body: _noTeams());
    }

    return Scaffold(appBar: _appBar(user), body: Center());
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
}
