import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/converter/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';
part 'team.g.dart';

@freezed
@JsonSerializable()
class Team with _$Team {
  @override
  final String teamId;
  @override
  final String ownerId;
  @override
  final String name;
  @override
  final String? logoUrl;
  @override
  final String lobbyId;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  const Team({
    required this.teamId,
    required this.ownerId,
    required this.name,
    this.logoUrl,
    required this.lobbyId,
    required this.createdAt,
    this.updatedAt
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}