import 'package:flutter/material.dart';
import '../../../auth/domain/use_cases/log_in_uc.dart';

import '../../../core/data/error/app_exception.dart';
import '../../../core/data/network/api_caller/api_caller.dart';
import '../../../core/data/network/i_api_caller.dart';
import '../../../core/presentation/utils/riverpod_framework.dart';
import '../models/app_model/app_model.dart';

part 'auth_remote_data_source.g.dart';

abstract class IAuthRemoteDataSource {
  /// Calls the api endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<AppModel> signIn(SignInParams params);
  Future<AppModel> getUserData();
}

@Riverpod(keepAlive: true)
IAuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  return AuthRemoteDataSource(
    ref,
    apiCaller: ref.watch(apiCallerProvider),
  );
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  AuthRemoteDataSource(
    this.ref, {
    required this.apiCaller,
  });

  final AuthRemoteDataSourceRef ref;
  final IApiCaller apiCaller;

  @override
  Future<AppModel> signIn(SignInParams params) async {
    debugPrint('phone >>> ${params.email}');
    final response = await apiCaller.postData<Map<String, dynamic>>(
      data: {
        'email': params.email,
        'password': params.password,
      },
      path: 'login',
    );

    return AppModel.fromJson(response.data!);
  }

  @override
  Future<AppModel> getUserData() async {
    final response = await apiCaller.postData<Map<String, dynamic>>(
      path: 'refresh-token',
    );

    return AppModel.fromJson(response.data!);
  }
}
