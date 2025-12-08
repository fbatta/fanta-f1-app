import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/converter.dart';
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
  final String raceId;
  @override
  final int totalBudgetSpent;
  @override
  final int racePoints;
  @override
  final String captainDriverId;
  @override
  final List<String> selectedDriverIds;
  @override
  final bool hasSafetyCar;
  @override
  final bool hasVirtualSafetyCar;
  @override
  final bool hasRedFlag;
  @override
  final bool wetTyresUsed;
  @override
  final bool poleToWin;
  @override
  final bool sameTeamOneTwo;
  @override
  final int teamsInTopTenCount;
  @override
  final int retiredCarsCount;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;


  const Lineup({
    required this.lineupId,
    required this.teamId,
    required this.raceId,
    required this.totalBudgetSpent,
    required this.racePoints,
    required this.captainDriverId,
    required this.selectedDriverIds,
    required this.hasSafetyCar,
    required this.hasVirtualSafetyCar,
    required this.hasRedFlag,
    required this.wetTyresUsed,
    required this.poleToWin,
    required this.sameTeamOneTwo,
    required this.teamsInTopTenCount,
    required this.retiredCarsCount,
    required this.createdAt,
    this.updatedAt,
  });

  factory Lineup.fromJson(Map<String, dynamic> json) => _$LineupFromJson(json);

  Map<String, dynamic> toJson() => _$LineupToJson(this);
}
