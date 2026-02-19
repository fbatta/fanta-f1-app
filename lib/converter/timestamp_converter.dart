import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<int, Timestamp> {
  const TimestampConverter();

  @override
  int fromJson(Timestamp timestamp) => timestamp.millisecondsSinceEpoch;

  @override
  Timestamp toJson(int millis) => Timestamp.fromMillisecondsSinceEpoch(millis);
}
