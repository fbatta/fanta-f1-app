import 'package:fanta_f1/component/main_bottom_navigation_bar.dart';
import 'package:fanta_f1/dto/app_preferences.dart';
import 'package:fanta_f1/provider/preferences_provider.dart';
import 'package:fanta_f1/route/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  late final FirebaseMessaging _messaging;

  @override
  void initState() {
    _auth = _getIt();
    _messaging = _getIt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appPreferences = ref.watch(preferencesProviderProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Account settings')),
      bottomNavigationBar: MainBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          children: [
            appPreferences.hasValue
                ? _appVersion(appPreferences.requireValue)
                : Container(),
            _signOffButton(),
          ],
        ),
      ),
    );
  }

  Widget _signOffButton() {
    return FilledButton(
      onPressed: _onSignOffPressed,
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.error,
        foregroundColor: Theme.of(context).colorScheme.onError,
      ),
      child: Text('Sign off'),
    );
  }

  Widget _appVersion(AppPreferences appPreferences) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Text(
          'App version: ${appPreferences.appVersion} build number: ${appPreferences.buildNumber}',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
    );
  }

  Future<void> _onSignOffPressed() async {
    await _auth.signOut();
    if (!mounted) return;
    context.goNamed(RouteNames.signIn.name);
  }
}
