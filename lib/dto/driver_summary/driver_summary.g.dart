// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverSummary _$DriverSummaryFromJson(Map<String, dynamic> json) =>
    DriverSummary(
      driverId: json['driverId'] as String,
      driverAcronym: json['driverAcronym'] as String,
      driverName: json['driverName'] as String,
      driverNumber: (json['driverNumber'] as num).toInt(),
      summaryParagraphs: (json['summaryParagraphs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

const _$DriverSummaryFieldMap = <String, String>{
  'driverId': 'driverId',
  'driverAcronym': 'driverAcronym',
  'driverName': 'driverName',
  'driverNumber': 'driverNumber',
  'summaryParagraphs': 'summaryParagraphs',
};

// ignore: unused_element
abstract class _$DriverSummaryPerFieldToJson {
  // ignore: unused_element
  static Object? driverId(String instance) => instance;
  // ignore: unused_element
  static Object? driverAcronym(String instance) => instance;
  // ignore: unused_element
  static Object? driverName(String instance) => instance;
  // ignore: unused_element
  static Object? driverNumber(int instance) => instance;
  // ignore: unused_element
  static Object? summaryParagraphs(List<String> instance) => instance;
}

Map<String, dynamic> _$DriverSummaryToJson(DriverSummary instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'driverAcronym': instance.driverAcronym,
      'driverName': instance.driverName,
      'driverNumber': instance.driverNumber,
      'summaryParagraphs': instance.summaryParagraphs,
    };
