// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Driver _$DriverFromJson(Map<String, dynamic> json) => Driver(
  driverId: json['driverId'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatarUrl'] as String,
  initialCost: (json['initialCost'] as num).toInt(),
  currentCost: (json['currentCost'] as num).toInt(),
  isActive: json['isActive'] as bool,
);

const _$DriverFieldMap = <String, String>{
  'driverId': 'driverId',
  'name': 'name',
  'avatarUrl': 'avatarUrl',
  'initialCost': 'initialCost',
  'currentCost': 'currentCost',
  'isActive': 'isActive',
};

// ignore: unused_element
abstract class _$DriverPerFieldToJson {
  // ignore: unused_element
  static Object? driverId(String instance) => instance;
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? avatarUrl(String instance) => instance;
  // ignore: unused_element
  static Object? initialCost(int instance) => instance;
  // ignore: unused_element
  static Object? currentCost(int instance) => instance;
  // ignore: unused_element
  static Object? isActive(bool instance) => instance;
}

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
  'driverId': instance.driverId,
  'name': instance.name,
  'avatarUrl': instance.avatarUrl,
  'initialCost': instance.initialCost,
  'currentCost': instance.currentCost,
  'isActive': instance.isActive,
};
