import 'package:freezed_annotation/freezed_annotation.dart';

part 'lineup_driver.freezed.dart';
part 'lineup_driver.g.dart';

@freezed
@JsonSerializable()
class LineupDriver with _$LineupDriver {
  @override
  final int driverNumber;
  @override
  final String driverAcronym;

  const LineupDriver({required this.driverNumber, required this.driverAcronym});

  factory LineupDriver.fromJson(Map<String, dynamic> json) =>
      _$LineupDriverFromJson(json);

  Map<String, dynamic> toJson() => _$LineupDriverToJson(this);
}
