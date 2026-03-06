// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppPreferences _$AppPreferencesFromJson(Map<String, dynamic> json) =>
    AppPreferences(
      appName: json['appName'] as String,
      packageName: json['packageName'] as String,
      appVersion: json['appVersion'] as String,
      buildNumber: json['buildNumber'] as String,
      hasRequestedNotificationsPermission:
          json['hasRequestedNotificationsPermission'] as bool,
      areNotificationsEnabled: json['areNotificationsEnabled'] as bool,
    );

const _$AppPreferencesFieldMap = <String, String>{
  'appName': 'appName',
  'packageName': 'packageName',
  'appVersion': 'appVersion',
  'buildNumber': 'buildNumber',
  'hasRequestedNotificationsPermission': 'hasRequestedNotificationsPermission',
  'areNotificationsEnabled': 'areNotificationsEnabled',
};

// ignore: unused_element
abstract class _$AppPreferencesPerFieldToJson {
  // ignore: unused_element
  static Object? appName(String instance) => instance;
  // ignore: unused_element
  static Object? packageName(String instance) => instance;
  // ignore: unused_element
  static Object? appVersion(String instance) => instance;
  // ignore: unused_element
  static Object? buildNumber(String instance) => instance;
  // ignore: unused_element
  static Object? hasRequestedNotificationsPermission(bool instance) => instance;
  // ignore: unused_element
  static Object? areNotificationsEnabled(bool instance) => instance;
}

Map<String, dynamic> _$AppPreferencesToJson(AppPreferences instance) =>
    <String, dynamic>{
      'appName': instance.appName,
      'packageName': instance.packageName,
      'appVersion': instance.appVersion,
      'buildNumber': instance.buildNumber,
      'hasRequestedNotificationsPermission':
          instance.hasRequestedNotificationsPermission,
      'areNotificationsEnabled': instance.areNotificationsEnabled,
    };
