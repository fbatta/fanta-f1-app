import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, int> {
  const TimestampConverter();

  @override
  DateTime fromJson(int millis) =>
      Timestamp.fromMillisecondsSinceEpoch(millis).toDate();

  @override
  int toJson(DateTime timestamp) => timestamp.millisecondsSinceEpoch;
}
