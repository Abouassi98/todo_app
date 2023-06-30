import '../../../core/presentation/utils/event.dart';
import '../../../core/presentation/utils/riverpod_framework.dart';

import '../../../core/presentation/providers/provider_utils.dart';
import '../../../core/presentation/utils/fp_framework.dart';
import '../../domain/use_cases/sign_out_uc.dart';
import 'auth_state_provider.dart';

part 'sign_out_provider.g.dart';

enum SignOutState {
  idle,
  success,
}

@riverpod
FutureOr<SignOutState> signOutState(SignOutStateRef ref) {
  final sub = ref.listen(authStateProvider.notifier, (prev, next) {});
  ref.listenSelf((previous, next) {
    next.whenOrNull(
      data: (state) {
        if (state == SignOutState.success) {
          sub.read().unAuthenticateUser();
        }
      },
    );
  });

  final event = ref.watch(signOutEventProvider);
  return event.match(
    () => SignOutState.idle,
    (event) {
      return ref
          .watch(signOutProvider(event).future)
          .then((_) => SignOutState.success);
    },
  );
}

@riverpod
class SignOutEvent extends _$SignOutEvent with NotifierUpdate {
  @override
  Option<Event<Unit>> build() => const None();
}

@riverpod
Future<void> signOut(
  SignOutRef ref,
  Event<Unit> event,
) async {
  return ref.watch(signOutUCProvider).call();
}
