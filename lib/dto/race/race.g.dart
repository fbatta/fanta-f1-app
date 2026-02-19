// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Race _$RaceFromJson(Map<String, dynamic> json) => Race(
  raceId: json['raceId'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatarUrl'] as String,
  eventStartDate: DateTime.parse(json['eventStartDate'] as String),
  eventEndDate: DateTime.parse(json['eventEndDate'] as String),
  lineupStartDate: DateTime.parse(json['lineupStartDate'] as String),
  lineupEndDate: DateTime.parse(json['lineupEndDate'] as String),
  status: $enumDecode(_$RaceStatusEnumMap, json['status']),
);

const _$RaceFieldMap = <String, String>{
  'raceId': 'raceId',
  'name': 'name',
  'avatarUrl': 'avatarUrl',
  'eventStartDate': 'eventStartDate',
  'eventEndDate': 'eventEndDate',
  'lineupStartDate': 'lineupStartDate',
  'lineupEndDate': 'lineupEndDate',
  'status': 'status',
};

// ignore: unused_element
abstract class _$RacePerFieldToJson {
  // ignore: unused_element
  static Object? raceId(String instance) => instance;
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? avatarUrl(String instance) => instance;
  // ignore: unused_element
  static Object? eventStartDate(DateTime instance) =>
      instance.toIso8601String();
  // ignore: unused_element
  static Object? eventEndDate(DateTime instance) => instance.toIso8601String();
  // ignore: unused_element
  static Object? lineupStartDate(DateTime instance) =>
      instance.toIso8601String();
  // ignore: unused_element
  static Object? lineupEndDate(DateTime instance) => instance.toIso8601String();
  // ignore: unused_element
  static Object? status(RaceStatus instance) => _$RaceStatusEnumMap[instance]!;
}

Map<String, dynamic> _$RaceToJson(Race instance) => <String, dynamic>{
  'raceId': instance.raceId,
  'name': instance.name,
  'avatarUrl': instance.avatarUrl,
  'eventStartDate': instance.eventStartDate.toIso8601String(),
  'eventEndDate': instance.eventEndDate.toIso8601String(),
  'lineupStartDate': instance.lineupStartDate.toIso8601String(),
  'lineupEndDate': instance.lineupEndDate.toIso8601String(),
  'status': _$RaceStatusEnumMap[instance.status]!,
};

const _$RaceStatusEnumMap = {
  RaceStatus.upcoming: 'upcoming',
  RaceStatus.live: 'live',
  RaceStatus.completed: 'completed',
};
