// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotification _$PushNotificationFromJson(Map<String, dynamic> json) =>
    PushNotification(
      title: json['title'] as String,
      type: $enumDecode(_$PushNotificationTypeEnumMap, json['type']),
      raceId: json['raceId'] as String?,
    );

const _$PushNotificationFieldMap = <String, String>{
  'title': 'title',
  'type': 'type',
  'raceId': 'raceId',
};

// ignore: unused_element
abstract class _$PushNotificationPerFieldToJson {
  // ignore: unused_element
  static Object? title(String instance) => instance;
  // ignore: unused_element
  static Object? type(PushNotificationType instance) =>
      _$PushNotificationTypeEnumMap[instance]!;
  // ignore: unused_element
  static Object? raceId(String? instance) => instance;
}

Map<String, dynamic> _$PushNotificationToJson(PushNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': _$PushNotificationTypeEnumMap[instance.type]!,
      'raceId': instance.raceId,
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
