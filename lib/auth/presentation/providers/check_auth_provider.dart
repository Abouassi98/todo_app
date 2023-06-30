import 'dart:async';
import '../../../auth/presentation/providers/auth_state_provider.dart';
import '../../../auth/presentation/providers/sign_out_provider.dart';
import '../../../core/presentation/utils/event.dart';
import '../../../core/presentation/utils/fp_framework.dart';
import '../../../core/presentation/utils/riverpod_framework.dart';
import '../../domain/entities/app.dart';
import '../../domain/use_cases/check_auth_uc.dart';

part 'check_auth_provider.g.dart';

@riverpod
Future<App> checkAuth(CheckAuthRef ref) async {
  final sub = ref.listen(authStateProvider.notifier, (prev, next) {});
  ref.listenSelf((previous, next) {
    next.whenOrNull(
      data: (user) => sub.read().authenticateUser(user),
      error: (err, st) => ref.read(signOutProvider(const Event(arg: unit))),
    );
  });

  return  ref.watch(checkAuthUCProvider).call();
}
