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
  final List<UserPrivileges> privileges;
  @override
  final Map<String, String> deviceRegistrationTokens;

  const User({
    required this.userId,
    required this.privileges,
    required this.deviceRegistrationTokens,
  });

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
