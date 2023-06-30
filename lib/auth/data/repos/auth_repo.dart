import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/data/data_sources/auth_local_data_source.dart';
import '../../../auth/data/data_sources/auth_remote_data_source.dart';

import '../../../auth/domain/repos/i_auth_repo.dart';
import '../../../auth/domain/use_cases/log_in_uc.dart';
import '../../../core/data/network/network_info.dart';
import '../../domain/entities/app.dart';

part 'auth_repo.g.dart';

@Riverpod(keepAlive: true)
IAuthRepo authRepo(AuthRepoRef ref) {
  return AuthRepo(
    networkInfo: ref.watch(networkInfoProvider),
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
}

class AuthRepo implements IAuthRepo {
  AuthRepo({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final INetworkInfo networkInfo;
  final IAuthRemoteDataSource remoteDataSource;
  final IAuthLocalDataSource localDataSource;

  @override
  Future<App> signInUser(SignInParams params) async {
   
    final user = await remoteDataSource.signIn(params);

    await localDataSource.cacheUserData(user);
    await localDataSource.cacheUserToken(user);

    return user.toEntity();
  }

  @override
  Future<App> getUserData() async {
    if (await networkInfo.hasInternetConnection) {
      try {
        final user = await remoteDataSource.getUserData();
        await localDataSource.cacheUserData(user);
        await localDataSource.cacheUserToken(user);
        return user.toEntity();
      } catch (_) {
        final user = await localDataSource.getUserData();
        return user.toEntity();
      }
    } else {
      final user = await localDataSource.getUserData();

      return user.toEntity();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await localDataSource.clearUserData();
    } catch (_) {}
  }
}
