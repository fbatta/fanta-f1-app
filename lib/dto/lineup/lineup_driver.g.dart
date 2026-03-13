// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lineup_driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineupDriver _$LineupDriverFromJson(Map<String, dynamic> json) => LineupDriver(
  driverNumber: (json['driverNumber'] as num).toInt(),
  driverAcronym: json['driverAcronym'] as String,
  driverCost: (json['driverCost'] as num?)?.toDouble() ?? 0.0,
  driverId: json['driverId'] as String?,
);

const _$LineupDriverFieldMap = <String, String>{
  'driverId': 'driverId',
  'driverNumber': 'driverNumber',
  'driverAcronym': 'driverAcronym',
  'driverCost': 'driverCost',
};

// ignore: unused_element
abstract class _$LineupDriverPerFieldToJson {
  // ignore: unused_element
  static Object? driverId(String? instance) => instance;
  // ignore: unused_element
  static Object? driverNumber(int instance) => instance;
  // ignore: unused_element
  static Object? driverAcronym(String instance) => instance;
  // ignore: unused_element
  static Object? driverCost(double? instance) => instance;
}

Map<String, dynamic> _$LineupDriverToJson(LineupDriver instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'driverNumber': instance.driverNumber,
      'driverAcronym': instance.driverAcronym,
      'driverCost': instance.driverCost,
    };
