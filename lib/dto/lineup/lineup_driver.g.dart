// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lineup_driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineupDriver _$LineupDriverFromJson(Map<String, dynamic> json) => LineupDriver(
  driverNumber: (json['driverNumber'] as num).toInt(),
  driverAcronym: json['driverAcronym'] as String,
);

const _$LineupDriverFieldMap = <String, String>{
  'driverNumber': 'driverNumber',
  'driverAcronym': 'driverAcronym',
};

// ignore: unused_element
abstract class _$LineupDriverPerFieldToJson {
  // ignore: unused_element
  static Object? driverNumber(int instance) => instance;
  // ignore: unused_element
  static Object? driverAcronym(String instance) => instance;
}

Map<String, dynamic> _$LineupDriverToJson(LineupDriver instance) =>
    <String, dynamic>{
      'driverNumber': instance.driverNumber,
      'driverAcronym': instance.driverAcronym,
    };
