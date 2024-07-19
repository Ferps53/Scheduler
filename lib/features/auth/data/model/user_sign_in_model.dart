import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_sign_in_model.freezed.dart';

@freezed
class UserSignInModel with _$UserSignInModel {
  factory UserSignInModel({
    required String username,
    required String email,
    required String password,
  }) = _UserSignInModel;
}
