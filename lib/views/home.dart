import 'package:fanta_f1/component/app_bar_user_action.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class Home extends ConsumerWidget {
  final _getIt = GetIt.instance;
  late final FirebaseAuth _auth;

  Home({super.key}) {
    _auth = _getIt.get<FirebaseAuth>();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [AppBarUserAction(user: user)],
      ),
      body: Center(),
    );
  }
}
