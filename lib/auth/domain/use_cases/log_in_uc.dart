import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../auth/data/repos/auth_repo.dart';
import '../../../auth/domain/repos/i_auth_repo.dart';
import '../../../core/presentation/utils/riverpod_framework.dart';
import '../../../core/domain/use_cases/use_case_base.dart';
import '../entities/app.dart';
part 'log_in_uc.freezed.dart';
part 'log_in_uc.g.dart';

@Riverpod(keepAlive: true)
SignInUC signInUC(SignInUCRef ref) {
  return SignInUC(
    ref,
    authRepo: ref.watch(authRepoProvider),
  );
}

class SignInUC implements UseCaseBase<App, SignInParams> {
  SignInUC(this.ref, {required this.authRepo});

  final SignInUCRef ref;
  final IAuthRepo authRepo;

  @override
  Future<App> call(SignInParams params) async {
 
    return authRepo.signInUser(params);
  }
}

@Freezed(toJson: true)
class SignInParams with _$SignInParams {
  const factory SignInParams({
    required String email,
    required String password,
  }) = _SignInParams;
}
