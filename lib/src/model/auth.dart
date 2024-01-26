import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/src/converter/date_add_and_covert.dart';

part 'generated/auth.freezed.dart';
part 'generated/auth.g.dart';

@freezed
class Auth with _$Auth {
  const factory Auth({
    required String token,
    @DatePlusDuration() required DateTime expDate,
    required String id,
    required String nome,
  }) = _Auth;

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
}
