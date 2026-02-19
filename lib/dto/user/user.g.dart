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
  createdAt: DateTime.parse(json['createdAt'] as String),
  avatarUrl: json['avatarUrl'] as String?,
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
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
  static Object? createdAt(DateTime instance) => instance.toIso8601String();
  // ignore: unused_element
  static Object? updatedAt(DateTime? instance) => instance?.toIso8601String();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'userId': instance.userId,
  'displayName': instance.displayName,
  'email': instance.email,
  'avatarUrl': instance.avatarUrl,
  'privileges': instance.privileges
      .map((e) => _$UserPrivilegesEnumMap[e]!)
      .toList(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$UserPrivilegesEnumMap = {
  UserPrivileges.createLobby: 'createLobby',
  UserPrivileges.modifyLobby: 'modifyLobby',
  UserPrivileges.deleteLobby: 'deleteLobby',
  UserPrivileges.createTeam: 'createTeam',
  UserPrivileges.modifyTeam: 'modifyTeam',
  UserPrivileges.deleteTeam: 'deleteTeam',
};
