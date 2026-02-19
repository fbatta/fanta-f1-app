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
  final String lobbyName;
  @override
  final String ownerId;
  @override
  final List<String> memberIds;
  @override
  final String lobbyPassword;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  const Lobby({
    required this.lobbyId,
    required this.lobbyName,
    required this.ownerId,
    required this.memberIds,
    required this.lobbyPassword,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lobby.fromJson(Map<String, dynamic> json) => _$LobbyFromJson(json);

  Map<String, dynamic> toJson() => _$LobbyToJson(this);
}
