import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_preferences.freezed.dart';
part 'app_preferences.g.dart';

@freezed
@JsonSerializable()
class AppPreferences with _$AppPreferences {
  @override
  final String appName;
  @override
  final String packageName;
  @override
  final String appVersion;
  @override
  final String buildNumber;

  const AppPreferences({
    required this.appName,
    required this.packageName,
    required this.appVersion,
    required this.buildNumber,
  });

  factory AppPreferences.fromJson(Map<String, dynamic> json) =>
      _$AppPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$AppPreferencesToJson(this);
}
