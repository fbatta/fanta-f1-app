import 'package:fanta_f1/converter/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'race.freezed.dart';
part 'race.g.dart';

@freezed
@JsonSerializable()
class Race with _$Race {
  @override
  final String raceId;
  @override
  final String raceName;
  @override
  final int openF1MeetingKey;
  @override
  final String circuitImage;
  @override
  @TimestampConverter()
  final DateTime dateStart;
  @override
  @TimestampConverter()
  final DateTime dateEnd;
  @override
  final String countryName;
  @override
  final String countryFlag;
  @override
  final String circuitType;
  @TimestampConverter()
  @override
  final DateTime dateLineupOpen;
  @TimestampConverter()
  @override
  final DateTime dateLineupClose;

  const Race({
    required this.raceId,
    required this.raceName,
    required this.openF1MeetingKey,
    required this.circuitImage,
    required this.dateStart,
    required this.dateEnd,
    required this.countryName,
    required this.countryFlag,
    required this.circuitType,
    required this.dateLineupOpen,
    required this.dateLineupClose,
  });

  factory Race.fromJson(Map<String, dynamic> json) => _$RaceFromJson(json);

  Map<String, dynamic> toJson() => _$RaceToJson(this);
}
