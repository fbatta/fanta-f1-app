// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lineup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lineup _$LineupFromJson(Map<String, dynamic> json) => Lineup(
  lineupId: json['lineupId'] as String,
  teamId: json['teamId'] as String,
  raceId: json['raceId'] as String,
  totalBudgetSpent: (json['totalBudgetSpent'] as num).toInt(),
  racePoints: (json['racePoints'] as num).toInt(),
  captainDriverId: json['captainDriverId'] as String,
  selectedDriverIds: (json['selectedDriverIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  hasSafetyCar: json['hasSafetyCar'] as bool,
  hasVirtualSafetyCar: json['hasVirtualSafetyCar'] as bool,
  hasRedFlag: json['hasRedFlag'] as bool,
  wetTyresUsed: json['wetTyresUsed'] as bool,
  poleToWin: json['poleToWin'] as bool,
  sameTeamOneTwo: json['sameTeamOneTwo'] as bool,
  teamsInTopTenCount: (json['teamsInTopTenCount'] as num).toInt(),
  retiredCarsCount: (json['retiredCarsCount'] as num).toInt(),
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
    json['updatedAt'],
    const TimestampConverter().fromJson,
  ),
);

const _$LineupFieldMap = <String, String>{
  'lineupId': 'lineupId',
  'teamId': 'teamId',
  'raceId': 'raceId',
  'totalBudgetSpent': 'totalBudgetSpent',
  'racePoints': 'racePoints',
  'captainDriverId': 'captainDriverId',
  'selectedDriverIds': 'selectedDriverIds',
  'hasSafetyCar': 'hasSafetyCar',
  'hasVirtualSafetyCar': 'hasVirtualSafetyCar',
  'hasRedFlag': 'hasRedFlag',
  'wetTyresUsed': 'wetTyresUsed',
  'poleToWin': 'poleToWin',
  'sameTeamOneTwo': 'sameTeamOneTwo',
  'teamsInTopTenCount': 'teamsInTopTenCount',
  'retiredCarsCount': 'retiredCarsCount',
  'createdAt': 'createdAt',
  'updatedAt': 'updatedAt',
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
  static Object? totalBudgetSpent(int instance) => instance;
  // ignore: unused_element
  static Object? racePoints(int instance) => instance;
  // ignore: unused_element
  static Object? captainDriverId(String instance) => instance;
  // ignore: unused_element
  static Object? selectedDriverIds(List<String> instance) => instance;
  // ignore: unused_element
  static Object? hasSafetyCar(bool instance) => instance;
  // ignore: unused_element
  static Object? hasVirtualSafetyCar(bool instance) => instance;
  // ignore: unused_element
  static Object? hasRedFlag(bool instance) => instance;
  // ignore: unused_element
  static Object? wetTyresUsed(bool instance) => instance;
  // ignore: unused_element
  static Object? poleToWin(bool instance) => instance;
  // ignore: unused_element
  static Object? sameTeamOneTwo(bool instance) => instance;
  // ignore: unused_element
  static Object? teamsInTopTenCount(int instance) => instance;
  // ignore: unused_element
  static Object? retiredCarsCount(int instance) => instance;
  // ignore: unused_element
  static Object? createdAt(DateTime instance) =>
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? updatedAt(DateTime? instance) =>
      _$JsonConverterToJson<Timestamp, DateTime>(
        instance,
        const TimestampConverter().toJson,
      );
}

Map<String, dynamic> _$LineupToJson(Lineup instance) => <String, dynamic>{
  'lineupId': instance.lineupId,
  'teamId': instance.teamId,
  'raceId': instance.raceId,
  'totalBudgetSpent': instance.totalBudgetSpent,
  'racePoints': instance.racePoints,
  'captainDriverId': instance.captainDriverId,
  'selectedDriverIds': instance.selectedDriverIds,
  'hasSafetyCar': instance.hasSafetyCar,
  'hasVirtualSafetyCar': instance.hasVirtualSafetyCar,
  'hasRedFlag': instance.hasRedFlag,
  'wetTyresUsed': instance.wetTyresUsed,
  'poleToWin': instance.poleToWin,
  'sameTeamOneTwo': instance.sameTeamOneTwo,
  'teamsInTopTenCount': instance.teamsInTopTenCount,
  'retiredCarsCount': instance.retiredCarsCount,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
    instance.updatedAt,
    const TimestampConverter().toJson,
  ),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
