import 'dart:convert';
import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/data/error/app_exception.dart';
import '../../../core/data/local/local_storage_caller/i_local_storage_caller.dart';
import '../../../core/data/local/local_storage_caller/shared_pref_local_storage_caller.dart';
import '../models/app_model/app_model.dart';
part 'auth_local_data_source.g.dart';

abstract class IAuthLocalDataSource {
  /// Gets the cached data which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<void> cacheUserData(AppModel userModel);
  Future<void> cacheUserToken(AppModel userModel);
  Future<AppModel> getUserData();
  Future<String?> getUserToken();
  Future<void> clearUserData();
}

@Riverpod(keepAlive: true)
IAuthLocalDataSource authLocalDataSource(AuthLocalDataSourceRef ref) {
  return AuthLocalDataSource(
    localStorageService: ref.watch(localStorageCallerProvider),
  );
}

class AuthLocalDataSource implements IAuthLocalDataSource {
  AuthLocalDataSource({required this.localStorageService});

  final ILocalStorageCaller localStorageService;

  static const String userDataKey = 'user_data';
  static const String userTokenKey = 'user_token';

  @override
  Future<void> cacheUserData(AppModel userModel) async {
    final jsonString = json.encode(userModel.toJson());
    await localStorageService.saveData(
      key: userDataKey,
      dataType: DataType.string,
      value: jsonString,
    );
  }

  @override
  Future<void> cacheUserToken(AppModel userModel) async {
    await localStorageService.saveData(
      key: userTokenKey,
      dataType: DataType.string,
      value: userModel.data!.token,
    );
  }

  @override
  Future<AppModel> getUserData() async {
    final jsonString = await localStorageService.restoreData<String>(
      key: userDataKey,
      dataType: DataType.string,
    );
    if (jsonString != null) {
      final userModel =
          AppModel.fromJson(json.decode(jsonString) as Map<String, dynamic>);

      return userModel;
    } else {
      throw const CacheException(
        type: CacheExceptionType.notFound,
        message: 'Cache Not Found',
      );
    }
  }

  @override
  Future<String?> getUserToken() async {
    final token = await localStorageService.restoreData<String>(
      key: userTokenKey,
      dataType: DataType.string,
    );
    log('token >>> $token');
    return token;
  }

  @override
  Future<void> clearUserData() async {
    await localStorageService.clearKey(
      key: userDataKey,
    );
    await localStorageService.clearKey(
      key: userTokenKey,
    );
  }
}
