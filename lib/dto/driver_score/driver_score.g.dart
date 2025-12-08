// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverScore _$DriverScoreFromJson(Map<String, dynamic> json) => DriverScore(
  raceId: json['raceId'] as String,
  driverId: json['driverId'] as String,
  points: (json['points'] as num).toInt(),
  startPosition: (json['startPosition'] as num).toInt(),
  finishPosition: (json['finishPosition'] as num).toInt(),
  isDnf: json['isDnf'] as bool,
  isDns: json['isDns'] as bool,
  hasPenalties: json['hasPenalties'] as bool,
  reachedQ1: json['reachedQ1'] as bool,
  reachedQ2: json['reachedQ2'] as bool,
  reachedQ3: json['reachedQ3'] as bool,
  beatTeammateInQuali: json['beatTeammateInQuali'] as bool,
  beatTeammateInRace: json['beatTeammateInRace'] as bool,
  calculatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
    json['calculatedAt'],
    const TimestampConverter().fromJson,
  ),
);

const _$DriverScoreFieldMap = <String, String>{
  'raceId': 'raceId',
  'driverId': 'driverId',
  'points': 'points',
  'startPosition': 'startPosition',
  'finishPosition': 'finishPosition',
  'isDnf': 'isDnf',
  'isDns': 'isDns',
  'hasPenalties': 'hasPenalties',
  'reachedQ1': 'reachedQ1',
  'reachedQ2': 'reachedQ2',
  'reachedQ3': 'reachedQ3',
  'beatTeammateInQuali': 'beatTeammateInQuali',
  'beatTeammateInRace': 'beatTeammateInRace',
  'calculatedAt': 'calculatedAt',
};

// ignore: unused_element
abstract class _$DriverScorePerFieldToJson {
  // ignore: unused_element
  static Object? raceId(String instance) => instance;
  // ignore: unused_element
  static Object? driverId(String instance) => instance;
  // ignore: unused_element
  static Object? points(int instance) => instance;
  // ignore: unused_element
  static Object? startPosition(int instance) => instance;
  // ignore: unused_element
  static Object? finishPosition(int instance) => instance;
  // ignore: unused_element
  static Object? isDnf(bool instance) => instance;
  // ignore: unused_element
  static Object? isDns(bool instance) => instance;
  // ignore: unused_element
  static Object? hasPenalties(bool instance) => instance;
  // ignore: unused_element
  static Object? reachedQ1(bool instance) => instance;
  // ignore: unused_element
  static Object? reachedQ2(bool instance) => instance;
  // ignore: unused_element
  static Object? reachedQ3(bool instance) => instance;
  // ignore: unused_element
  static Object? beatTeammateInQuali(bool instance) => instance;
  // ignore: unused_element
  static Object? beatTeammateInRace(bool instance) => instance;
  // ignore: unused_element
  static Object? calculatedAt(DateTime? instance) =>
      _$JsonConverterToJson<Timestamp, DateTime>(
        instance,
        const TimestampConverter().toJson,
      );
}

Map<String, dynamic> _$DriverScoreToJson(DriverScore instance) =>
    <String, dynamic>{
      'raceId': instance.raceId,
      'driverId': instance.driverId,
      'points': instance.points,
      'startPosition': instance.startPosition,
      'finishPosition': instance.finishPosition,
      'isDnf': instance.isDnf,
      'isDns': instance.isDns,
      'hasPenalties': instance.hasPenalties,
      'reachedQ1': instance.reachedQ1,
      'reachedQ2': instance.reachedQ2,
      'reachedQ3': instance.reachedQ3,
      'beatTeammateInQuali': instance.beatTeammateInQuali,
      'beatTeammateInRace': instance.beatTeammateInRace,
      'calculatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
        instance.calculatedAt,
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
