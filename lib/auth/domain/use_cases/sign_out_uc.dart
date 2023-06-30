import '../../../auth/domain/repos/i_auth_repo.dart';
import '../../../core/presentation/utils/riverpod_framework.dart';
import '../../../core/domain/use_cases/use_case_base.dart';
import '../../data/repos/auth_repo.dart';
part 'sign_out_uc.g.dart';

@Riverpod(keepAlive: true)
SignOutUC signOutUC(SignOutUCRef ref) {
  return SignOutUC(
    ref,
    authRepo: ref.watch(authRepoProvider),
  );
}

class SignOutUC implements UseCaseNoParamsBase<void> {
  SignOutUC(this.ref, {required this.authRepo});

  final SignOutUCRef ref;
  final IAuthRepo authRepo;

  @override
  Future<void> call() async {
    await authRepo.signOut();
  }
}
