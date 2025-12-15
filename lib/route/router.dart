import 'package:fanta_f1/route/route_names.dart';
import 'package:fanta_f1/views/forgot_password.dart';
import 'package:fanta_f1/views/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.signIn.toString(),
      builder: (BuildContext context, GoRouterState state) => const SignIn(),
    ),
    GoRoute(
      path: '/forgotPassword',
      name: RouteNames.forgotPassword.toString(),
      builder: (BuildContext context, GoRouterState state) =>
          const ForgotPassword(),
    ),
    GoRoute(
      path: '/signUp',
      name: RouteNames.signUp.toString(),
      builder: (BuildContext context, GoRouterState state) =>
          const SignIn()
    )
  ],
);
