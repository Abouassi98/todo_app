// ignore: depend_on_referenced_packages
import '../../../../core/data/local/sqflite_caller/i_sqflite_storage_caller.dart';
import '../../../../core/data/local/sqflite_caller/sqflite_pref_local_storage_caller.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../domain/entity/todo.dart';
import '../models/todo_model.dart';
part 'todo_items_local_data_source.g.dart';

abstract class ITodoItemsDataSource {
  /// Gets the cached data which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<void> saveItem(Todo vs);
  Future<List<TodoModel>?> getAllItems();
  Future<void> updateItem(Todo vs, String oldItemId);
  Future<void> deleteItem({required String itemId});
}

@Riverpod(keepAlive: true)
ITodoItemsDataSource todoItemsDataSource(TodoItemsDataSourceRef ref) {
  return TodoItemsDataSource(
    sqfliteStorageService: ref.watch(sqfliteStorageCallerProvider),
  );
}

class TodoItemsDataSource implements ITodoItemsDataSource {
  TodoItemsDataSource({required this.sqfliteStorageService});
  final ISqfliteStorageCaller sqfliteStorageService;
  @override
  Future<void> saveItem(Todo vs) async {
    await sqfliteStorageService.addData(
      visualNoteModel: TodoModel(
        color: vs.color,
        date: vs.date,
        time: vs.time,
        itemId: vs.itemId,
        description: vs.description,
        status: vs.status,
      ).toJson(),
    );
  }

  @override
  Future<void> updateItem(Todo vs, String oldItemId) async {
    await sqfliteStorageService.updateData(
      visualNoteModel: TodoModel(
        color: vs.color,
        date: vs.date,
        time: vs.time,
        itemId: vs.itemId,
        description: vs.description,
        status: vs.status,
      ).toJson(),
      oldItemId: oldItemId,
    );
  }

  @override
  Future<void> deleteItem({required String itemId}) async {
    await sqfliteStorageService.deleteData(itemId: itemId);
  }

  @override
  Future<List<TodoModel>?> getAllItems() async {
    return sqfliteStorageService.getAllData();
  }
}
