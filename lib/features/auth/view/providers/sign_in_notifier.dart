import 'dart:async';

import 'package:scheduler/features/auth/auth.dart';

import '../../../../core/core.dart';
import '../../data/model/user_model.dart';

class SiginInNotifier extends AutoDisposeAsyncNotifier<UserModel?> {
  @override
  FutureOr<UserModel?> build() {
    return null;
  }

  void signIn(DadosLogin dados, BuildContext context) async {
    try {
      state = const AsyncLoading();
      final loginRepo = ref.read(loginRepoProvider);
      state = AsyncValue.data(await loginRepo.signIn(dados));
    } on DioException catch (e) {
      state = AsyncError(
        e.response?.data,
        e.stackTrace,
      );
    }
  }
}

final signInProvider =
    AsyncNotifierProvider.autoDispose<SiginInNotifier, UserModel?>(() {
  return SiginInNotifier();
});
