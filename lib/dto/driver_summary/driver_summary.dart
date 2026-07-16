import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_summary.freezed.dart';
part 'driver_summary.g.dart';

@freezed
@JsonSerializable()
class DriverSummary with _$DriverSummary {
  @override
  final String driverId;
  @override
  final String driverAcronym;
  @override
  final String driverName;
  @override
  final int driverNumber;
  @override
  final List<String> summaryParagraphs;

  const DriverSummary({
    required this.driverId,
    required this.driverAcronym,
    required this.driverName,
    required this.driverNumber,
    required this.summaryParagraphs,
  });

  factory DriverSummary.fromJson(Map<String, dynamic> json) =>
      _$DriverSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$DriverSummaryToJson(this);
}
