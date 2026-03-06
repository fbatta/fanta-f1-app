// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  userId: json['userId'] as String,
  privileges: (json['privileges'] as List<dynamic>)
      .map((e) => $enumDecode(_$UserPrivilegesEnumMap, e))
      .toList(),
  deviceRegistrationTokens: Map<String, String>.from(
    json['deviceRegistrationTokens'] as Map,
  ),
);

const _$UserFieldMap = <String, String>{
  'userId': 'userId',
  'privileges': 'privileges',
  'deviceRegistrationTokens': 'deviceRegistrationTokens',
};

// ignore: unused_element
abstract class _$UserPerFieldToJson {
  // ignore: unused_element
  static Object? userId(String instance) => instance;
  // ignore: unused_element
  static Object? privileges(List<UserPrivileges> instance) =>
      instance.map((e) => _$UserPrivilegesEnumMap[e]!).toList();
  // ignore: unused_element
  static Object? deviceRegistrationTokens(Map<String, String> instance) =>
      instance;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'userId': instance.userId,
  'privileges': instance.privileges
      .map((e) => _$UserPrivilegesEnumMap[e]!)
      .toList(),
  'deviceRegistrationTokens': instance.deviceRegistrationTokens,
};

const _$UserPrivilegesEnumMap = {
  UserPrivileges.createLobby: 'createLobby',
  UserPrivileges.modifyLobby: 'modifyLobby',
  UserPrivileges.deleteLobby: 'deleteLobby',
  UserPrivileges.createTeam: 'createTeam',
  UserPrivileges.modifyTeam: 'modifyTeam',
  UserPrivileges.deleteTeam: 'deleteTeam',
};
