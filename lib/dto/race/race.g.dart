// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Race _$RaceFromJson(Map<String, dynamic> json) => Race(
  raceId: json['raceId'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatarUrl'] as String,
  eventStartDate: const TimestampConverter().fromJson(
    json['eventStartDate'] as Timestamp,
  ),
  eventEndDate: const TimestampConverter().fromJson(
    json['eventEndDate'] as Timestamp,
  ),
  lineupStartDate: const TimestampConverter().fromJson(
    json['lineupStartDate'] as Timestamp,
  ),
  lineupEndDate: const TimestampConverter().fromJson(
    json['lineupEndDate'] as Timestamp,
  ),
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
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? eventEndDate(DateTime instance) =>
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? lineupStartDate(DateTime instance) =>
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? lineupEndDate(DateTime instance) =>
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? status(RaceStatus instance) => _$RaceStatusEnumMap[instance]!;
}

Map<String, dynamic> _$RaceToJson(Race instance) => <String, dynamic>{
  'raceId': instance.raceId,
  'name': instance.name,
  'avatarUrl': instance.avatarUrl,
  'eventStartDate': const TimestampConverter().toJson(instance.eventStartDate),
  'eventEndDate': const TimestampConverter().toJson(instance.eventEndDate),
  'lineupStartDate': const TimestampConverter().toJson(
    instance.lineupStartDate,
  ),
  'lineupEndDate': const TimestampConverter().toJson(instance.lineupEndDate),
  'status': _$RaceStatusEnumMap[instance.status]!,
};

const _$RaceStatusEnumMap = {
  RaceStatus.upcoming: 'upcoming',
  RaceStatus.live: 'live',
  RaceStatus.completed: 'completed',
};
