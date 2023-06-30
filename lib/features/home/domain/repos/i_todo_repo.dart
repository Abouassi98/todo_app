// contract between domain layer with another layer

import 'dart:async';

import '../entity/todo.dart';

abstract class ITodoRepo {
  Future<void> saveItem(Todo vs);
  FutureOr<List<Todo>> getAllItems();
  Future<void> updateItem(Todo vs, String oldItemId);
  Future<void> deleteItem({required String noteId});
}
