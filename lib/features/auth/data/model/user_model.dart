import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/auth/data/model/user_model.g.dart';
part '../../../../generated/features/auth/data/model/user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required int id,
    required String email,
    required String username,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
