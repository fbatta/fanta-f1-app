import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/converter.dart';
import 'package:fanta_f1/enum/race_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'race.freezed.dart';
part 'race.g.dart';

@freezed
@JsonSerializable()
class Race with _$Race {
  @override
  final String raceId;
  @override
  final String name;
  @override
  final String avatarUrl;
  @override
  @TimestampConverter()
  final DateTime eventStartDate;
  @override
  @TimestampConverter()
  final DateTime eventEndDate;
  @override
  @TimestampConverter()
  final DateTime lineupStartDate;
  @override
  @TimestampConverter()
  final DateTime lineupEndDate;
  @override
  final RaceStatus status;

  const Race({
    required this.raceId,
    required this.name,
    required this.avatarUrl,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.lineupStartDate,
    required this.lineupEndDate,
    required this.status,
  });

  factory Race.fromJson(Map<String, dynamic> json) => _$RaceFromJson(json);

  Map<String, dynamic> toJson() => _$RaceToJson(this);
}