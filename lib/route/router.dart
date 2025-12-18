import 'package:fanta_f1/route/route_names.dart';
import 'package:fanta_f1/views/forgot_password.dart';
import 'package:fanta_f1/views/home.dart';
import 'package:fanta_f1/views/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  redirect: (BuildContext context, GoRouterState state) {
    if(state.uri.toString().contains('app-1-436460578056-ios-fd0ac0f69f0bfdce04b8bd://firebaseauth')) {
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
      builder: (BuildContext context, GoRouterState state) =>
          const SignIn()
    ),
    GoRoute(
      path: RouteNames.home.path,
      name: RouteNames.home.toString(),
      builder: (BuildContext context, GoRouterState state) =>
          const Home()
    )
  ],
);
