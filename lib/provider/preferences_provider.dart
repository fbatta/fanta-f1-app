import 'package:fanta_f1/dto/app_preferences.dart';
import 'package:fanta_f1/enum/shared_preferences_keys.dart';
import 'package:fanta_f1/provider/user_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_provider.g.dart';

@riverpod
class PreferencesProvider extends _$PreferencesProvider {
  final _getIt = GetIt.instance;
  late final PackageInfo _packageInfo;
  late final SharedPreferences _sharedPreferences;

  PreferencesProvider() {
    _packageInfo = _getIt();
    _sharedPreferences = _getIt();
  }

  @override
  FutureOr<AppPreferences> build() async {
    final hasRequestedNotificationsPermission =
        _sharedPreferences.getBool(
          SharedPreferencesKeys.hasRequestedNotificationsPermission.name,
        ) ??
        false;
    final areNotificationsEnabled =
        _sharedPreferences.getBool(
          SharedPreferencesKeys.areNotificationsEnabled.name,
        ) ??
        false;

    return AppPreferences(
      appName: _packageInfo.appName,
      packageName: _packageInfo.packageName,
      appVersion: _packageInfo.version,
      buildNumber: _packageInfo.buildNumber,
      hasRequestedNotificationsPermission: hasRequestedNotificationsPermission,
      areNotificationsEnabled: areNotificationsEnabled,
    );
  }

  Future<void> setNotificationsPermission(bool isGranted, String? token) async {
    if (isGranted && token != null) {
      updateDeviceToken(token);
    }
    await _sharedPreferences.setBool(
      SharedPreferencesKeys.hasRequestedNotificationsPermission.name,
      true,
    );
    await _sharedPreferences.setBool(
      SharedPreferencesKeys.areNotificationsEnabled.name,
      isGranted,
    );
    final newState = state.value!.copyWith(
      hasRequestedNotificationsPermission: true,
      areNotificationsEnabled: isGranted,
    );

    state = AsyncValue.data(newState);
  }

  Future<void> updateDeviceToken(String token) async {
    await ref
        .read(userProviderProvider.notifier)
        .addDeviceRegistrationToken(token);
  }
}
