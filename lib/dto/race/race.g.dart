// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Race _$RaceFromJson(Map<String, dynamic> json) => Race(
  raceId: json['raceId'] as String,
  raceName: json['raceName'] as String,
  openF1MeetingKey: (json['openF1MeetingKey'] as num).toInt(),
  circuitImage: json['circuitImage'] as String,
  dateStart: const TimestampConverter().fromJson(
    (json['dateStart'] as num).toInt(),
  ),
  dateEnd: const TimestampConverter().fromJson(
    (json['dateEnd'] as num).toInt(),
  ),
  countryName: json['countryName'] as String,
  countryFlag: json['countryFlag'] as String,
  circuitType: json['circuitType'] as String,
);

const _$RaceFieldMap = <String, String>{
  'raceId': 'raceId',
  'raceName': 'raceName',
  'openF1MeetingKey': 'openF1MeetingKey',
  'circuitImage': 'circuitImage',
  'dateStart': 'dateStart',
  'dateEnd': 'dateEnd',
  'countryName': 'countryName',
  'countryFlag': 'countryFlag',
  'circuitType': 'circuitType',
};

// ignore: unused_element
abstract class _$RacePerFieldToJson {
  // ignore: unused_element
  static Object? raceId(String instance) => instance;
  // ignore: unused_element
  static Object? raceName(String instance) => instance;
  // ignore: unused_element
  static Object? openF1MeetingKey(int instance) => instance;
  // ignore: unused_element
  static Object? circuitImage(String instance) => instance;
  // ignore: unused_element
  static Object? dateStart(DateTime instance) =>
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? dateEnd(DateTime instance) =>
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? countryName(String instance) => instance;
  // ignore: unused_element
  static Object? countryFlag(String instance) => instance;
  // ignore: unused_element
  static Object? circuitType(String instance) => instance;
}

Map<String, dynamic> _$RaceToJson(Race instance) => <String, dynamic>{
  'raceId': instance.raceId,
  'raceName': instance.raceName,
  'openF1MeetingKey': instance.openF1MeetingKey,
  'circuitImage': instance.circuitImage,
  'dateStart': const TimestampConverter().toJson(instance.dateStart),
  'dateEnd': const TimestampConverter().toJson(instance.dateEnd),
  'countryName': instance.countryName,
  'countryFlag': instance.countryFlag,
  'circuitType': instance.circuitType,
};
