// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
  teamId: json['teamId'] as String,
  ownerId: json['ownerId'] as String,
  teamName: json['teamName'] as String,
  teamAvatarUrl: json['teamAvatarUrl'] as String?,
  lobbyId: json['lobbyId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

const _$TeamFieldMap = <String, String>{
  'teamId': 'teamId',
  'ownerId': 'ownerId',
  'teamName': 'teamName',
  'teamAvatarUrl': 'teamAvatarUrl',
  'lobbyId': 'lobbyId',
  'createdAt': 'createdAt',
  'updatedAt': 'updatedAt',
};

// ignore: unused_element
abstract class _$TeamPerFieldToJson {
  // ignore: unused_element
  static Object? teamId(String instance) => instance;
  // ignore: unused_element
  static Object? ownerId(String instance) => instance;
  // ignore: unused_element
  static Object? teamName(String instance) => instance;
  // ignore: unused_element
  static Object? teamAvatarUrl(String? instance) => instance;
  // ignore: unused_element
  static Object? lobbyId(String instance) => instance;
  // ignore: unused_element
  static Object? createdAt(DateTime instance) => instance.toIso8601String();
  // ignore: unused_element
  static Object? updatedAt(DateTime instance) => instance.toIso8601String();
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
  'teamId': instance.teamId,
  'ownerId': instance.ownerId,
  'teamName': instance.teamName,
  'teamAvatarUrl': instance.teamAvatarUrl,
  'lobbyId': instance.lobbyId,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
