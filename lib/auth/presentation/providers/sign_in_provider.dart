import '../../../auth/domain/entities/app.dart';
import '../../../auth/domain/use_cases/log_in_uc.dart';
import '../../../core/presentation/providers/provider_utils.dart';
import '../../../core/presentation/utils/event.dart';
import '../../../core/presentation/utils/fp_framework.dart';
import '../../../core/presentation/utils/riverpod_framework.dart';
import 'auth_state_provider.dart';
part 'sign_in_provider.g.dart';

//Using [Option] to indicate idle(none)/success(some) states.
//This is a shorthand. You can use custom states using [freezed] instead.
@riverpod
FutureOr<Option<App>> signInState(SignInStateRef ref) {
  final sub = ref.listen(authStateProvider.notifier, (prev, next) {});
  ref.listenSelf((previous, next) {
    next.whenOrNull(
      data: (user) {
        if (user is Some<App>) {
          sub.read().authenticateUser(user.value);
        }
      },
    );
  });

  final event = ref.watch(signInEventProvider);
  return event.match(
    None.new,
    (event) {
      return ref.watch(signInProvider(event).future).then(Some.new);
    },
  );
}

@riverpod
class SignInEvent extends _$SignInEvent with NotifierUpdate {
  @override
  Option<Event<SignInParams>> build() => const None();
}

@riverpod
Future<App> signIn(
  SignInRef ref,
  Event<SignInParams> event,
) async {
  return ref.watch(signInUCProvider).call(event.arg);
}
