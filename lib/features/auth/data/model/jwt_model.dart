import 'package:freezed_annotation/freezed_annotation.dart';

part 'jwt_model.g.dart';
part 'jwt_model.freezed.dart';

@freezed
class JwtModel with _$JwtModel {
  factory JwtModel({
    required String access_token,
    required String refresh_token,
    required String type,
    required int expires_in,
  }) = _JwtModel;

  factory JwtModel.fromJson(Map<String, Object?> json) =>
      _$JwtModelFromJson(json);
}
