import 'dart:async';

abstract class ISqfliteStorageCaller {
  Future<List<T>?> getAllData<T>();
  Future<void> addData<T>({
    required T visualNoteModel,
  });
  Future<void> deleteData({
    required String itemId,
  });
  Future<void> updateData<T>({
    required T visualNoteModel,
    required String oldItemId,
  });
}
