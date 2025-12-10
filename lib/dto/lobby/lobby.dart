import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/converter/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lobby.freezed.dart';
part 'lobby.g.dart';

@freezed
@JsonSerializable()
class Lobby with _$Lobby {
  @override
  final String lobbyId;
  @override
  final String name;
  @override
  final String description;
  @override
  final String ownerId;
  @override
  final List<String> memberIds;
  @override
  final String inviteCode;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  const Lobby({
    required this.lobbyId,
    required this.name,
    required this.description,
    required this.ownerId,
    required this.memberIds,
    required this.inviteCode,
    required this.createdAt,
    this.updatedAt,
  });

  factory Lobby.fromJson(Map<String, dynamic> json) => _$LobbyFromJson(json);

  Map<String, dynamic> toJson() => _$LobbyToJson(this);
}
