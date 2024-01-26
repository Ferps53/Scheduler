import 'package:freezed_annotation/freezed_annotation.dart';

class DatePlusDuration implements JsonConverter<DateTime, dynamic> {
  const DatePlusDuration();

  @override
  DateTime fromJson(duration) =>
      DateTime.now().add(Duration(seconds: duration));

  @override
  toJson(DateTime date) => date.toIso8601String();
}
