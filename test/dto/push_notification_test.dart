import 'package:fanta_f1/dto/push_notification/push_notification.dart';
import 'package:fanta_f1/dto/push_notification/push_notification_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PushNotification', () {
    test(
      'fromJson correctly parses raceWeekendResultsAvailable with raceId, teamId, and lobbyId',
      () {
        final json = {
          'type': 'raceWeekendResultsAvailable',
          'raceId': 'race-123',
          'teamId': 'team-456',
          'lobbyId': 'lobby-789',
        };

        final notification = PushNotification.fromJson(json);

        expect(
          notification.type,
          equals(PushNotificationType.raceWeekendResultsAvailable),
        );
        expect(notification.raceId, equals('race-123'));
        expect(notification.teamId, equals('team-456'));
        expect(notification.lobbyId, equals('lobby-789'));
      },
    );

    test('toJson serializes raceWeekendResultsAvailable correctly', () {
      const notification = PushNotification(
        type: PushNotificationType.raceWeekendResultsAvailable,
        raceId: 'race-123',
        teamId: 'team-456',
        lobbyId: 'lobby-789',
      );

      final json = notification.toJson();

      expect(json['type'], equals('raceWeekendResultsAvailable'));
      expect(json['raceId'], equals('race-123'));
      expect(json['teamId'], equals('team-456'));
      expect(json['lobbyId'], equals('lobby-789'));
    });

    test('fromJson handles null raceId, teamId, and lobbyId', () {
      final json = {
        'type': 'raceWeekendResultsAvailable',
      };

      final notification = PushNotification.fromJson(json);

      expect(
        notification.type,
        equals(PushNotificationType.raceWeekendResultsAvailable),
      );
      expect(notification.raceId, isNull);
      expect(notification.teamId, isNull);
      expect(notification.lobbyId, isNull);
    });
  });
}
