import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_score.freezed.dart';
part 'driver_score.g.dart';

@freezed
@JsonSerializable()
class DriverScore with _$DriverScore {
  @override
  final String raceId;
  @override
  final String driverId;
  @override
  final int points;
  @override
  final int startPosition;
  @override
  final int finishPosition;
  @override
  final bool isDnf;
  @override
  final bool isDns;
  @override
  final bool hasPenalties;
  @override
  final bool reachedQ1;
  @override
  final bool reachedQ2;
  @override
  final bool reachedQ3;
  @override
  final bool beatTeammateInQuali;
  @override
  final bool beatTeammateInRace;
  @override
  @TimestampConverter()
  final DateTime? calculatedAt;

  const DriverScore({
    required this.raceId,
    required this.driverId,
    required this.points,
    required this.startPosition,
    required this.finishPosition,
    required this.isDnf,
    required this.isDns,
    required this.hasPenalties,
    required this.reachedQ1,
    required this.reachedQ2,
    required this.reachedQ3,
    required this.beatTeammateInQuali,
    required this.beatTeammateInRace,
    this.calculatedAt
  });

  factory DriverScore.fromJson(Map<String, dynamic> json) => _$DriverScoreFromJson(json);

  Map<String, dynamic> toJson() => _$DriverScoreToJson(this);
}
