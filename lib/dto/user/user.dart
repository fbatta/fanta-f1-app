import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanta_f1/converter.dart';
import 'package:fanta_f1/enum/user_privileges.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
@JsonSerializable()
class User with _$User {
  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String email;
  @override
  final String? avatarUrl;
  @override
  final List<UserPrivileges> privileges;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  const User({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.privileges,
    required this.createdAt,
    this.avatarUrl,
    this.updatedAt
  });

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}