// contract between domain layer with another layer

import '../../../auth/domain/use_cases/log_in_uc.dart';

import '../entities/app.dart';


abstract class IAuthRepo {
  Future<App> signInUser(SignInParams params);
  Future<App> getUserData();
  Future<void> signOut();
}
