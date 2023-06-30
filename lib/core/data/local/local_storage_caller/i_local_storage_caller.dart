import '../../../presentation/utils/riverpod_framework.dart';

enum DataType {
  string,
  int,
  double,
  bool,
  stringList,
}

abstract class ILocalStorageCaller {
  Future<bool> saveData({
    required String key,
    required Object value,
    required DataType dataType,
  });

  FutureOr<T?> restoreData<T>({
    required String key,
    required DataType dataType,
  });

  Future<bool> clearAll();

  Future<bool> clearKey({required String key});

  Future<bool> getSetMethod({
    required DataType sharedPrefsMethod,
    required String key,
    required Object value,
  });
  FutureOr<T?> getGetMethod<T>({
    required DataType sharedPrefsMethod,
    required String key,
  });
}
