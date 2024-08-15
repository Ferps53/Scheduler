// ignore_for_file: invalid_annotation_target
// ignored warning because it works
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/auth/data/model/jwt_model.g.dart';
part '../../../../generated/features/auth/data/model/jwt_model.freezed.dart';

@freezed
class JwtModel with _$JwtModel {
  factory JwtModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    required String type,
    @JsonKey(name: 'expires_in') required int expiresIn,
  }) = _JwtModel;

  factory JwtModel.fromJson(Map<String, Object?> json) =>
      _$JwtModelFromJson(json);
}
