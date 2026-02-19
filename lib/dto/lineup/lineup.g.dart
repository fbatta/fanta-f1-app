// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lineup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lineup _$LineupFromJson(Map<String, dynamic> json) => Lineup(
  lineupId: json['lineupId'] as String,
  teamId: json['teamId'] as String,
  raceId: json['raceId'] as String,
  drivers: (json['drivers'] as List<dynamic>)
      .map((e) => LineupDriver.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  version: (json['version'] as num).toInt(),
  score: (json['score'] as num?)?.toDouble(),
);

const _$LineupFieldMap = <String, String>{
  'lineupId': 'lineupId',
  'teamId': 'teamId',
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
  static Object? raceId(String instance) => instance;
  // ignore: unused_element
  static Object? drivers(List<LineupDriver> instance) => instance;
  // ignore: unused_element
  static Object? createdAt(DateTime instance) => instance.toIso8601String();
  // ignore: unused_element
  static Object? updatedAt(DateTime instance) => instance.toIso8601String();
  // ignore: unused_element
  static Object? version(int instance) => instance;
  // ignore: unused_element
  static Object? score(double? instance) => instance;
}

Map<String, dynamic> _$LineupToJson(Lineup instance) => <String, dynamic>{
  'lineupId': instance.lineupId,
  'teamId': instance.teamId,
  'raceId': instance.raceId,
  'drivers': instance.drivers,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'version': instance.version,
  'score': instance.score,
};
