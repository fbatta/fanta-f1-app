import 'package:fanta_f1/route/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AccountSettings extends ConsumerStatefulWidget {
  const AccountSettings({super.key});

  @override
  ConsumerState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends ConsumerState<AccountSettings> {
  final _getIt = GetIt.instance;
  late final FirebaseAuth _auth;

  @override
  void initState() {
    _auth = _getIt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account settings')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(children: [_signOffButton()]),
      ),
    );
  }

  Widget _signOffButton() {
    return FilledButton(
      onPressed: _onSignOffPressed,
      child: Text('Sign off'),
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.error,
        foregroundColor: Theme.of(context).colorScheme.onError,
      ),
    );
  }

  Future<void> _onSignOffPressed() async {
    await _auth.signOut();
    if (context.mounted) {
      context.goNamed(RouteNames.signIn.name);
    }
  }
}
