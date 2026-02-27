import 'package:fanta_f1/dto/lineup/lineup_driver.dart';
import 'package:json_annotation/json_annotation.dart';

class LineupDriverConverter
    implements JsonConverter<List<LineupDriver>, List<dynamic>> {
  const LineupDriverConverter();

  @override
  List<LineupDriver> fromJson(List<dynamic> json) {
    return json.map((el) => LineupDriver.fromJson(el)).toList();
  }

  @override
  List<dynamic> toJson(List<LineupDriver> object) {
    return object.map((el) => el.toJson()).toList();
  }
}
