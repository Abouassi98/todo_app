import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'sign_out_uc.dart';

import '../../../core/domain/use_cases/use_case_base.dart';
import '../entities/app.dart';
import 'get_user_data_uc.dart';

part 'check_auth_uc.g.dart';

@Riverpod(keepAlive: true)
CheckAuthUC checkAuthUC(CheckAuthUCRef ref) {
  return CheckAuthUC(
    ref,
  );
}

class CheckAuthUC implements UseCaseNoParamsBase<App> {
  CheckAuthUC(
    this.ref,
  );

  final CheckAuthUCRef ref;

  @override
  Future<App> call() async {
    return getUserData();
  }

  Future<App> getUserData() async {
    try {
      final user = await ref.read(getUserDataUCProvider).call();
      return user;
    } catch (err) {
      await ref.read(signOutUCProvider).call();
      rethrow;
    }
  }
}
