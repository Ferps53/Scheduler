import 'dart:async';

import 'package:scheduler/core/core.dart';
import 'package:scheduler/features/auth/auth.dart';

final confirmationEmailProvider =
    AsyncNotifierProvider.autoDispose<ConfirmationEmailNotifier, void>(
        () => ConfirmationEmailNotifier());

class ConfirmationEmailNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> confirmEmail(String email, String code) async {
    try {
      state = const AsyncLoading();

      final loginRepo = ref.read(loginRepoProvider);

      await loginRepo.confirmEmail(email, code);
      state = const AsyncData(null);
    } on DioException catch (e) {
      state = AsyncError(e.response?.data, e.stackTrace);
    }
  }

  Future<void> resendEmail(String email) async {
    try {
      final loginRepo = ref.read(loginRepoProvider);

      await loginRepo.resendEmail(email);
      state = const AsyncData(null);
    } on DioException catch (e) {
      state = AsyncError(e.response?.data, e.stackTrace);
    }
  }
}

final emailConfirmationRetryCountProvider =
    NotifierProvider.autoDispose<EmailConfirmationRetryCountNotifier, int>(() {
  return EmailConfirmationRetryCountNotifier();
});

final confirmationEmailState =
    NotifierProvider.autoDispose<ConfirmationEmailStep, int>(
  () => ConfirmationEmailStep(),
);

class ConfirmationEmailStep extends AutoDisposeNotifier<int> {
  @override
  int build() {
    return 0;
  }

  void add() {
    state += 1;
  }

  void substract() {
    state -= 1;
  }
}

class EmailConfirmationRetryCountNotifier extends AutoDisposeNotifier<int> {
  @override
  int build() {
    return 0;
  }

  void add() {
    state += 1;
  }
}
