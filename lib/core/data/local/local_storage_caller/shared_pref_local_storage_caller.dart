import '../../../presentation/utils/riverpod_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'i_local_storage_caller.dart';
import '../extensions/local_error_extension.dart';
part 'shared_pref_local_storage_caller.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPrefs(SharedPrefsRef ref) {
  return ref.watch(sharedPrefsAsyncProvider).requireValue;
}

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPrefsAsync(SharedPrefsAsyncRef ref) async {
  return SharedPreferences.getInstance();
}

@Riverpod(keepAlive: true)
ILocalStorageCaller localStorageCaller(LocalStorageCallerRef ref) {
  return SharedPrefsLocalStorageCaller(
    sharedPreferences: ref.watch(sharedPrefsProvider),
  );
}

class SharedPrefsLocalStorageCaller implements ILocalStorageCaller {
  SharedPrefsLocalStorageCaller({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  /*
  late final bool hasHistory;
  initHasHistory() async {
    hasHistory =
        await restoreData(key: 'has_history', dataType: DataType.bool) ?? false;
    log('hasHistory: ' + hasHistory.toString());
    if (!hasHistory){
      saveData(key: 'has_history', value: true, dataType: DataType.bool);
    }
  }*/

  @override
  Future<bool> saveData({
    required String key,
    required Object value,
    required DataType dataType,
  }) async {
    return _errorHandler(
      () async {
        return getSetMethod(
          sharedPrefsMethod: dataType,
          key: key,
          value: value,
        );
      },
    );
  }

  @override
  FutureOr<T?> restoreData<T>({
    required String key,
    required DataType dataType,
  }) async {
    return await _errorHandler(
      () async {
        return getGetMethod(sharedPrefsMethod: dataType, key: key);
      },
    );
  }

  @override
  Future<bool> clearAll() async {
    return await _errorHandler(
      () async {
        return sharedPreferences.clear();
      },
    );
  }

  @override
  Future<bool> clearKey({required String key}) async {
    return _errorHandler(
      () async {
        return sharedPreferences.remove(key);
      },
    );
  }

  @override
  Future<bool> getSetMethod({
    required DataType sharedPrefsMethod,
    required String key,
    required Object value,
  }) {
    switch (sharedPrefsMethod) {
      case DataType.string:
        return sharedPreferences.setString(key, value as String);
      case DataType.int:
        return sharedPreferences.setInt(key, value as int);
      case DataType.double:
        return sharedPreferences.setDouble(key, value as double);
      case DataType.bool:
        return sharedPreferences.setBool(key, value as bool);
      case DataType.stringList:
        return sharedPreferences.setStringList(key, value as List<String>);
    }
  }

  @override
  FutureOr<T?> getGetMethod<T>({
    required DataType sharedPrefsMethod,
    required String key,
  }) {
    switch (sharedPrefsMethod) {
      case DataType.string:
        return sharedPreferences.getString(key) as T?;
      case DataType.int:
        return sharedPreferences.getInt(key) as T?;
      case DataType.double:
        return sharedPreferences.getDouble(key) as T?;
      case DataType.bool:
        return sharedPreferences.getBool(key) as T?;
      case DataType.stringList:
        return sharedPreferences.getStringList(key) as T?;
    }
  }

  FutureOr<T> _errorHandler<T>(FutureOr<T> Function() body) async {
    try {
      return await body.call();
    } catch (e, st) {
      final error = e.localErrorToCacheException();
      throw Error.throwWithStackTrace(error, st);
    }
  }
}
