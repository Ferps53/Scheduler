import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scheduler/features/auth/auth.dart';

part '../../../../generated/features/auth/data/model/user_sign_in_model.freezed.dart';

@freezed
class UserSignInModel with _$UserSignInModel {
  const UserSignInModel._();

  factory UserSignInModel({
    required String username,
    required String email,
    required String password,
  }) = _UserSignInModel;

  factory UserSignInModel.fromLoginData(LoginData data) {
    return UserSignInModel(
      username: data.username,
      email: data.email,
      password: data.password,
    );
  }
}
