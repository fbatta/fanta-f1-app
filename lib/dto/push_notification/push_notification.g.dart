// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotification _$PushNotificationFromJson(Map<String, dynamic> json) =>
    PushNotification(
      type: $enumDecode(_$PushNotificationTypeEnumMap, json['type']),
      raceId: json['raceId'] as String?,
      teamId: json['teamId'] as String?,
      lobbyId: json['lobbyId'] as String?,
    );

const _$PushNotificationFieldMap = <String, String>{
  'type': 'type',
  'raceId': 'raceId',
  'teamId': 'teamId',
  'lobbyId': 'lobbyId',
};

// ignore: unused_element
abstract class _$PushNotificationPerFieldToJson {
  // ignore: unused_element
  static Object? type(PushNotificationType instance) =>
      _$PushNotificationTypeEnumMap[instance]!;
  // ignore: unused_element
  static Object? raceId(String? instance) => instance;
  // ignore: unused_element
  static Object? teamId(String? instance) => instance;
  // ignore: unused_element
  static Object? lobbyId(String? instance) => instance;
}

Map<String, dynamic> _$PushNotificationToJson(PushNotification instance) =>
    <String, dynamic>{
      'type': _$PushNotificationTypeEnumMap[instance.type]!,
      'raceId': instance.raceId,
      'teamId': instance.teamId,
      'lobbyId': instance.lobbyId,
    };

const _$PushNotificationTypeEnumMap = {
  PushNotificationType.lineupOpen: 'lineupOpen',
  PushNotificationType.lineupReminder: 'lineupReminder',
  PushNotificationType.lineupClosing: 'lineupClosing',
  PushNotificationType.lineupClosed: 'lineupClosed',
  PushNotificationType.raceWeekendResultsAvailable:
      'raceWeekendResultsAvailable',
  PushNotificationType.driversPricesUpdated: 'driversPricesUpdated',
};
