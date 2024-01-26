import 'package:freezed_annotation/freezed_annotation.dart';

class DateConverter implements JsonConverter<DateTime, String> {
  const DateConverter();

  @override
  DateTime fromJson(String dateString) => DateTime.parse(dateString);

  @override
  String toJson(DateTime object) => object.toIso8601String();
}
