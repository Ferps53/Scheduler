import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/auth/domain/entities/login_data.g.dart';
part '../../../../generated/features/auth/domain/entities/login_data.freezed.dart';

@freezed
class LoginData with _$LoginData {
  const factory LoginData({
    required String username,
    required String email,
    required String password,
  }) = _LoginData;

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
}
