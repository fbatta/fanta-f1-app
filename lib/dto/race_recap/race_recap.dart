import 'package:freezed_annotation/freezed_annotation.dart';

part 'race_recap.freezed.dart';
part 'race_recap.g.dart';

@freezed
@JsonSerializable()
class RaceRecap with _$RaceRecap {
  @override
  final String raceId;
  @override
  final String raceName;
  @override
  final List<String> recapParagraphs;

  const RaceRecap({
    required this.raceId,
    required this.raceName,
    required this.recapParagraphs,
  });

  factory RaceRecap.fromJson(Map<String, dynamic> json) =>
      _$RaceRecapFromJson(json);

  Map<String, dynamic> toJson() => _$RaceRecapToJson(this);
}
