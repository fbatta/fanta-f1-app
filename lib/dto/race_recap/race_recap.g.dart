// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_recap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RaceRecap _$RaceRecapFromJson(Map<String, dynamic> json) => RaceRecap(
  raceId: json['raceId'] as String,
  raceName: json['raceName'] as String,
  recapParagraphs: (json['recapParagraphs'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

const _$RaceRecapFieldMap = <String, String>{
  'raceId': 'raceId',
  'raceName': 'raceName',
  'recapParagraphs': 'recapParagraphs',
};

// ignore: unused_element
abstract class _$RaceRecapPerFieldToJson {
  // ignore: unused_element
  static Object? raceId(String instance) => instance;
  // ignore: unused_element
  static Object? raceName(String instance) => instance;
  // ignore: unused_element
  static Object? recapParagraphs(List<String> instance) => instance;
}

Map<String, dynamic> _$RaceRecapToJson(RaceRecap instance) => <String, dynamic>{
  'raceId': instance.raceId,
  'raceName': instance.raceName,
  'recapParagraphs': instance.recapParagraphs,
};
