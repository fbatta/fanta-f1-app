// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
  teamId: json['teamId'] as String,
  ownerId: json['ownerId'] as String,
  name: json['name'] as String,
  logoUrl: json['logoUrl'] as String?,
  lobbyId: json['lobbyId'] as String,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
    json['updatedAt'],
    const TimestampConverter().fromJson,
  ),
);

const _$TeamFieldMap = <String, String>{
  'teamId': 'teamId',
  'ownerId': 'ownerId',
  'name': 'name',
  'logoUrl': 'logoUrl',
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
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? logoUrl(String? instance) => instance;
  // ignore: unused_element
  static Object? lobbyId(String instance) => instance;
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

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
  'teamId': instance.teamId,
  'ownerId': instance.ownerId,
  'name': instance.name,
  'logoUrl': instance.logoUrl,
  'lobbyId': instance.lobbyId,
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
