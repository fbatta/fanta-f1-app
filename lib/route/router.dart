import 'package:fanta_f1/dto/race/race.dart';
import 'package:fanta_f1/dto/team/team.dart' as team_dto;
import 'package:fanta_f1/route/route_names.dart';
import 'package:fanta_f1/views/account_settings.dart';
import 'package:fanta_f1/views/add_edit_lobby.dart';
import 'package:fanta_f1/views/add_edit_team.dart';
import 'package:fanta_f1/views/calendar.dart';
import 'package:fanta_f1/views/forgot_password.dart';
import 'package:fanta_f1/views/home.dart';
import 'package:fanta_f1/views/lineup_view.dart';
import 'package:fanta_f1/views/race_results_view.dart';
import 'package:fanta_f1/views/sign_in.dart';
import 'package:fanta_f1/views/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../views/team.dart';

final router = GoRouter(
  redirect: (BuildContext context, GoRouterState state) {
    if (state.uri.toString().contains(
      'app-1-436460578056-ios-b21d20492c2b619f04b8bd://firebaseauth',
    )) {
      return RouteNames.signIn.path;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: RouteNames.signIn.path,
      name: RouteNames.signIn.toString(),
      builder: (BuildContext context, GoRouterState state) => const SignIn(),
    ),
    GoRoute(
      path: RouteNames.forgotPassword.path,
      name: RouteNames.forgotPassword.toString(),
      builder: (BuildContext context, GoRouterState state) =>
          const ForgotPassword(),
    ),
    GoRoute(
      path: RouteNames.signUp.path,
      name: RouteNames.signUp.toString(),
      builder: (BuildContext context, GoRouterState state) => const SignUp(),
    ),
    GoRoute(
      path: RouteNames.account.path,
      name: RouteNames.account.name,
      builder: (context, state) => const AccountSettings(),
    ),
    GoRoute(
      path: RouteNames.home.path,
      name: RouteNames.home.toString(),
      builder: (BuildContext context, GoRouterState state) => Home(),
    ),
    GoRoute(
      path: RouteNames.addTeam.path,
      name: RouteNames.addTeam.toString(),
      builder: (BuildContext context, GoRouterState state) => AddEditTeam(),
    ),
    GoRoute(
      path: RouteNames.editTeam.path,
      name: RouteNames.editTeam.name,
      builder: (BuildContext context, GoRouterState state) =>
          AddEditTeam(team: state.extra as team_dto.Team?),
    ),
    GoRoute(
      path: RouteNames.addLobby.path,
      name: RouteNames.addLobby.toString(),
      builder: (BuildContext context, GoRouterState state) => AddEditLobby(),
    ),
    GoRoute(
      path: RouteNames.calendar.path,
      name: RouteNames.calendar.toString(),
      builder: (BuildContext context, GoRouterState state) => Calendar(),
    ),
    GoRoute(
      path: RouteNames.team.path,
      name: RouteNames.team.toString(),
      builder: (BuildContext context, GoRouterState state) =>
          Team(teamId: state.pathParameters['teamId']!),
    ),
    GoRoute(
      path: RouteNames.lineup.path,
      name: RouteNames.lineup.name,
      builder: (context, state) => LineupView(
        raceId: state.pathParameters['raceId']!,
        teamId: state.pathParameters['teamId']!,
        race: state.extra as Race,
      ),
    ),
    GoRoute(
      path: RouteNames.raceResults.path,
      name: RouteNames.raceResults.name,
      builder: (context, state) => RaceResultsView(
        race: state.extra as Race,
        teamId: state.pathParameters['teamId']!,
        lobbyId: state.pathParameters['lobbyId']!,
      ),
    ),
  ],
);
