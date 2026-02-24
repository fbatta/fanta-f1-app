import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_cost.freezed.dart';
part 'driver_cost.g.dart';

@freezed
@JsonSerializable()
class DriverCost with _$DriverCost {
  @override
  final String driverId;
  @override
  final double driverCost;

  const DriverCost({required this.driverId, required this.driverCost});

  factory DriverCost.fromJson(Map<String, dynamic> json) =>
      _$DriverCostFromJson(json);

  Map<String, dynamic> toJson() => _$DriverCostToJson(this);
}
