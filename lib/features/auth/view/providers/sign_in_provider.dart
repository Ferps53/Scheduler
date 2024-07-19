import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/features/auth/auth.dart';

import '../../data/model/user_model.dart';

class SiginInNotifier extends AutoDisposeAsyncNotifier<UserModel?> {
  @override
  FutureOr<UserModel?> build() {
    return null;
  }

  void signIn(DadosLogin dados, BuildContext context) async {
    state = const AsyncLoading();
    final loginRepo = ref.read(loginRepoProvider);
    state = await AsyncValue.guard(() async => await loginRepo.signIn(dados));
  }
}

final signInProvider =
    AsyncNotifierProvider.autoDispose<SiginInNotifier, UserModel?>(() {
  return SiginInNotifier();
});
