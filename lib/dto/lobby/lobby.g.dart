// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lobby _$LobbyFromJson(Map<String, dynamic> json) => Lobby(
  lobbyId: json['lobbyId'] as String,
  lobbyName: json['lobbyName'] as String,
  ownerId: json['ownerId'] as String,
  memberIds: (json['memberIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  lobbyPassword: json['lobbyPassword'] as String,
  createdAt: const TimestampConverter().fromJson(
    (json['createdAt'] as num).toInt(),
  ),
  updatedAt: const TimestampConverter().fromJson(
    (json['updatedAt'] as num).toInt(),
  ),
);

const _$LobbyFieldMap = <String, String>{
  'lobbyId': 'lobbyId',
  'lobbyName': 'lobbyName',
  'ownerId': 'ownerId',
  'memberIds': 'memberIds',
  'lobbyPassword': 'lobbyPassword',
  'createdAt': 'createdAt',
  'updatedAt': 'updatedAt',
};

// ignore: unused_element
abstract class _$LobbyPerFieldToJson {
  // ignore: unused_element
  static Object? lobbyId(String instance) => instance;
  // ignore: unused_element
  static Object? lobbyName(String instance) => instance;
  // ignore: unused_element
  static Object? ownerId(String instance) => instance;
  // ignore: unused_element
  static Object? memberIds(List<String> instance) => instance;
  // ignore: unused_element
  static Object? lobbyPassword(String instance) => instance;
  // ignore: unused_element
  static Object? createdAt(DateTime instance) =>
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? updatedAt(DateTime instance) =>
      const TimestampConverter().toJson(instance);
}

Map<String, dynamic> _$LobbyToJson(Lobby instance) => <String, dynamic>{
  'lobbyId': instance.lobbyId,
  'lobbyName': instance.lobbyName,
  'ownerId': instance.ownerId,
  'memberIds': instance.memberIds,
  'lobbyPassword': instance.lobbyPassword,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
