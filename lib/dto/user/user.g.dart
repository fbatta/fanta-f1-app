// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  userId: json['userId'] as String,
  displayName: json['displayName'] as String,
  email: json['email'] as String,
  privileges: (json['privileges'] as List<dynamic>)
      .map((e) => $enumDecode(_$UserPrivilegesEnumMap, e))
      .toList(),
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  avatarUrl: json['avatarUrl'] as String?,
  updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
    json['updatedAt'],
    const TimestampConverter().fromJson,
  ),
);

const _$UserFieldMap = <String, String>{
  'userId': 'userId',
  'displayName': 'displayName',
  'email': 'email',
  'avatarUrl': 'avatarUrl',
  'privileges': 'privileges',
  'createdAt': 'createdAt',
  'updatedAt': 'updatedAt',
};

// ignore: unused_element
abstract class _$UserPerFieldToJson {
  // ignore: unused_element
  static Object? userId(String instance) => instance;
  // ignore: unused_element
  static Object? displayName(String instance) => instance;
  // ignore: unused_element
  static Object? email(String instance) => instance;
  // ignore: unused_element
  static Object? avatarUrl(String? instance) => instance;
  // ignore: unused_element
  static Object? privileges(List<UserPrivileges> instance) =>
      instance.map((e) => _$UserPrivilegesEnumMap[e]!).toList();
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

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'userId': instance.userId,
  'displayName': instance.displayName,
  'email': instance.email,
  'avatarUrl': instance.avatarUrl,
  'privileges': instance.privileges
      .map((e) => _$UserPrivilegesEnumMap[e]!)
      .toList(),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
    instance.updatedAt,
    const TimestampConverter().toJson,
  ),
};

const _$UserPrivilegesEnumMap = {
  UserPrivileges.createLobby: 'createLobby',
  UserPrivileges.modifyLobby: 'modifyLobby',
  UserPrivileges.deleteLobby: 'deleteLobby',
  UserPrivileges.createTeam: 'createTeam',
  UserPrivileges.modifyTeam: 'modifyTeam',
  UserPrivileges.deleteTeam: 'deleteTeam',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
