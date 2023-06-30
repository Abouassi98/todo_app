import '../../../auth/domain/entities/app.dart';
import '../../../core/presentation/utils/riverpod_framework.dart';
import '../../../core/presentation/utils/fp_framework.dart';
part 'auth_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  Option<App> build() => const None();

  void authenticateUser(App user) {
    state = Some(user);
  }

  void unAuthenticateUser() {
    state = const None();
  }
}
