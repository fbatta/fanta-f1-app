import 'package:fanta_f1/dto/push_notification/push_notification_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_notification.freezed.dart';
part 'push_notification.g.dart';

@freezed
@JsonSerializable()
class PushNotification with _$PushNotification {
  @override
  final PushNotificationType type;
  @override
  final String? raceId;

  const PushNotification({required this.type, required this.raceId});

  factory PushNotification.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$PushNotificationToJson(this);
}
