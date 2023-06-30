import '../../../auth/data/repos/auth_repo.dart';
import '../../../auth/domain/repos/i_auth_repo.dart';
import '../../../core/domain/use_cases/use_case_base.dart';
import '../../../core/presentation/utils/riverpod_framework.dart';
import '../entities/app.dart';

part 'get_user_data_uc.g.dart';

@Riverpod(keepAlive: true)
GetUserDataUC getUserDataUC(GetUserDataUCRef ref) {
  return GetUserDataUC(
    authRepo: ref.watch(authRepoProvider),
  );
}

class GetUserDataUC implements UseCaseNoParamsBase<App> {
  GetUserDataUC({required this.authRepo});

  final IAuthRepo authRepo;

  @override
  Future<App> call() async {
    return authRepo.getUserData();
  }
}
