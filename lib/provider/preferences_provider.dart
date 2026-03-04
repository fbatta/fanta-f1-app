import 'package:fanta_f1/dto/app_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'preferences_provider.g.dart';

@riverpod
class PreferencesProvider extends _$PreferencesProvider {
  final _getIt = GetIt.instance;
  late final PackageInfo _packageInfo;

  PreferencesProvider() {
    _packageInfo = _getIt();
  }

  @override
  FutureOr<AppPreferences> build() async {
    return AppPreferences(
      appName: _packageInfo.appName,
      packageName: _packageInfo.packageName,
      appVersion: _packageInfo.version,
      buildNumber: _packageInfo.buildNumber,
    );
  }
}
