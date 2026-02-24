// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Driver _$DriverFromJson(Map<String, dynamic> json) => Driver(
  driverId: json['driverId'] as String,
  name: json['name'] as String,
  teamName: json['teamName'] as String,
  teamColour: json['teamColour'] as String,
  driverNumber: (json['driverNumber'] as num).toInt(),
  acronym: json['acronym'] as String,
  driverAvatar: json['driverAvatar'] as String,
  isActive: json['isActive'] as bool,
);

const _$DriverFieldMap = <String, String>{
  'driverId': 'driverId',
  'driverNumber': 'driverNumber',
  'acronym': 'acronym',
  'driverAvatar': 'driverAvatar',
  'isActive': 'isActive',
  'name': 'name',
  'teamName': 'teamName',
  'teamColour': 'teamColour',
};

// ignore: unused_element
abstract class _$DriverPerFieldToJson {
  // ignore: unused_element
  static Object? driverId(String instance) => instance;
  // ignore: unused_element
  static Object? driverNumber(int instance) => instance;
  // ignore: unused_element
  static Object? acronym(String instance) => instance;
  // ignore: unused_element
  static Object? driverAvatar(String instance) => instance;
  // ignore: unused_element
  static Object? isActive(bool instance) => instance;
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? teamName(String instance) => instance;
  // ignore: unused_element
  static Object? teamColour(String instance) => instance;
}

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
  'driverId': instance.driverId,
  'driverNumber': instance.driverNumber,
  'acronym': instance.acronym,
  'driverAvatar': instance.driverAvatar,
  'isActive': instance.isActive,
  'name': instance.name,
  'teamName': instance.teamName,
  'teamColour': instance.teamColour,
};
