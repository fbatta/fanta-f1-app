import 'package:fanta_f1/converter/timestamp_converter.dart';
import 'package:fanta_f1/dto/lineup/lineup_driver.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lineup.freezed.dart';
part 'lineup.g.dart';

@freezed
@JsonSerializable()
class Lineup with _$Lineup {
  @override
  final String lineupId;
  @override
  final String teamId;
  @override
  final String ownerId;
  @override
  final String raceId;
  @override
  final List<LineupDriver> drivers;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;
  @override
  final int version;
  @override
  final double? score;

  const Lineup({
    required this.lineupId,
    required this.teamId,
    required this.ownerId,
    required this.raceId,
    required this.drivers,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.score,
  });

  factory Lineup.fromJson(Map<String, dynamic> json) => _$LineupFromJson(json);

  Map<String, dynamic> toJson() => _$LineupToJson(this);
}
