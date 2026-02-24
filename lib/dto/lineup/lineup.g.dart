// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lineup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lineup _$LineupFromJson(Map<String, dynamic> json) => Lineup(
  lineupId: json['lineupId'] as String,
  teamId: json['teamId'] as String,
  ownerId: json['ownerId'] as String,
  raceId: json['raceId'] as String,
  drivers: (json['drivers'] as List<dynamic>)
      .map((e) => LineupDriver.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: const TimestampConverter().fromJson(
    (json['createdAt'] as num).toInt(),
  ),
  updatedAt: const TimestampConverter().fromJson(
    (json['updatedAt'] as num).toInt(),
  ),
  version: (json['version'] as num).toInt(),
  score: (json['score'] as num?)?.toDouble(),
);

const _$LineupFieldMap = <String, String>{
  'lineupId': 'lineupId',
  'teamId': 'teamId',
  'ownerId': 'ownerId',
  'raceId': 'raceId',
  'drivers': 'drivers',
  'createdAt': 'createdAt',
  'updatedAt': 'updatedAt',
  'version': 'version',
  'score': 'score',
};

// ignore: unused_element
abstract class _$LineupPerFieldToJson {
  // ignore: unused_element
  static Object? lineupId(String instance) => instance;
  // ignore: unused_element
  static Object? teamId(String instance) => instance;
  // ignore: unused_element
  static Object? ownerId(String instance) => instance;
  // ignore: unused_element
  static Object? raceId(String instance) => instance;
  // ignore: unused_element
  static Object? drivers(List<LineupDriver> instance) => instance;
  // ignore: unused_element
  static Object? createdAt(DateTime instance) =>
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? updatedAt(DateTime instance) =>
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? version(int instance) => instance;
  // ignore: unused_element
  static Object? score(double? instance) => instance;
}

Map<String, dynamic> _$LineupToJson(Lineup instance) => <String, dynamic>{
  'lineupId': instance.lineupId,
  'teamId': instance.teamId,
  'ownerId': instance.ownerId,
  'raceId': instance.raceId,
  'drivers': instance.drivers,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'version': instance.version,
  'score': instance.score,
};
