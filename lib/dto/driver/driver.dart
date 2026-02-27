import 'package:fanta_f1/dto/lineup/lineup_driver.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver.freezed.dart';
part 'driver.g.dart';

@freezed
@JsonSerializable()
class Driver with _$Driver {
  @override
  final String driverId;
  @override
  final int driverNumber;
  @override
  final String acronym;
  @override
  final String driverAvatar;
  @override
  final bool isActive;
  @override
  final String name;
  @override
  final String teamName;
  @override
  final String teamColour;

  const Driver({
    required this.driverId,
    required this.name,
    required this.teamName,
    required this.teamColour,
    required this.driverNumber,
    required this.acronym,
    required this.driverAvatar,
    required this.isActive,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);

  LineupDriver toLineupDriver(double driverCost) => LineupDriver(
    driverNumber: driverNumber,
    driverAcronym: acronym,
    driverCost: driverCost,
    driverId: driverId,
  );
}
