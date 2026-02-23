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
  createdAt: const TimestampConverter().fromJson(
    (json['createdAt'] as num).toInt(),
  ),
  updatedAt: const TimestampConverter().fromJson(
    (json['updatedAt'] as num).toInt(),
  ),
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
  static Object? createdAt(DateTime instance) =>
      const TimestampConverter().toJson(instance);
  // ignore: unused_element
  static Object? updatedAt(DateTime instance) =>
      const TimestampConverter().toJson(instance);
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
  'teamId': instance.teamId,
  'ownerId': instance.ownerId,
  'teamName': instance.teamName,
  'teamAvatarUrl': instance.teamAvatarUrl,
  'lobbyId': instance.lobbyId,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
