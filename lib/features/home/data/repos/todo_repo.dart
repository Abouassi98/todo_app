import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entity/todo.dart';
import '../../domain/repos/i_todo_repo.dart';
import '../data_source/todo_items_local_data_source.dart';

part 'todo_repo.g.dart';

@Riverpod(keepAlive: true)
ITodoRepo todoRepo(TodoRepoRef ref) {
  return TodoRepo(
    localDataSource: ref.watch(todoItemsDataSourceProvider),
  );
}

class TodoRepo implements ITodoRepo {
  TodoRepo({
    required this.localDataSource,
  });

  final ITodoItemsDataSource localDataSource;

  @override
  Future<void> deleteItem({required String noteId}) async {
    try {
      await localDataSource.deleteItem(itemId: noteId);
    } catch (_) {}
  }

  @override
  Future<List<Todo>> getAllItems() async {
    final items = await localDataSource.getAllItems();
    return items!.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveItem(Todo vs) async {
    try {
      await localDataSource.saveItem(vs);
    } catch (_) {}
  }

  @override
  Future<void> updateItem(Todo vs, String oldItemId) async {
    try {
      await localDataSource.updateItem(vs, oldItemId);
    } catch (_) {}
  }
}
