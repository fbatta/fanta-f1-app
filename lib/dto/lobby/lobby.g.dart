// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lobby _$LobbyFromJson(Map<String, dynamic> json) => Lobby(
  lobbyId: json['lobbyId'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  ownerId: json['ownerId'] as String,
  memberIds: (json['memberIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  inviteCode: json['inviteCode'] as String,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
    json['updatedAt'],
    const TimestampConverter().fromJson,
  ),
);

const _$LobbyFieldMap = <String, String>{
  'lobbyId': 'lobbyId',
  'name': 'name',
  'description': 'description',
  'ownerId': 'ownerId',
  'memberIds': 'memberIds',
  'inviteCode': 'inviteCode',
  'createdAt': 'createdAt',
  'updatedAt': 'updatedAt',
};

// ignore: unused_element
abstract class _$LobbyPerFieldToJson {
  // ignore: unused_element
  static Object? lobbyId(String instance) => instance;
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? description(String instance) => instance;
  // ignore: unused_element
  static Object? ownerId(String instance) => instance;
  // ignore: unused_element
  static Object? memberIds(List<String> instance) => instance;
  // ignore: unused_element
  static Object? inviteCode(String instance) => instance;
  // ignore: unused_element
  static Object? createdAt(DateTime instance) =>
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? updatedAt(DateTime? instance) =>
      _$JsonConverterToJson<Timestamp, DateTime>(
        instance,
        const TimestampConverter().toJson,
      );
}

Map<String, dynamic> _$LobbyToJson(Lobby instance) => <String, dynamic>{
  'lobbyId': instance.lobbyId,
  'name': instance.name,
  'description': instance.description,
  'ownerId': instance.ownerId,
  'memberIds': instance.memberIds,
  'inviteCode': instance.inviteCode,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
    instance.updatedAt,
    const TimestampConverter().toJson,
  ),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
