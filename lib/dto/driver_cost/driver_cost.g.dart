// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_cost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverCost _$DriverCostFromJson(Map<String, dynamic> json) => DriverCost(
  driverId: json['driverId'] as String,
  driverCost: (json['driverCost'] as num).toDouble(),
);

const _$DriverCostFieldMap = <String, String>{
  'driverId': 'driverId',
  'driverCost': 'driverCost',
};

// ignore: unused_element
abstract class _$DriverCostPerFieldToJson {
  // ignore: unused_element
  static Object? driverId(String instance) => instance;
  // ignore: unused_element
  static Object? driverCost(double instance) => instance;
}

Map<String, dynamic> _$DriverCostToJson(DriverCost instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'driverCost': instance.driverCost,
    };
