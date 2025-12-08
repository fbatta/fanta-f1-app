import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver.freezed.dart';
part 'driver.g.dart';

@freezed
@JsonSerializable()
class Driver with _$Driver {
  @override
  final String driverId;
  @override
  final String name;
  @override
  final String avatarUrl;
  @override
  final int initialCost;
  @override
  final int currentCost;
  @override
  final bool isActive;

  const Driver({
    required this.driverId,
    required this.name,
    required this.avatarUrl,
    required this.initialCost,
    required this.currentCost,
    required this.isActive,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);
}