import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/todo.dart';
part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  factory TodoModel({
    String? itemId,
    String? date,
    String? time,
    String? description,
    int? color,
    String? status,
  }) = _TodoModel;
  const TodoModel._();

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  factory TodoModel.fromEntity(Todo visualNote) {
    return TodoModel(
      date: visualNote.date,
      description: visualNote.description,
      color: visualNote.color,
      itemId: visualNote.itemId,
      time:visualNote.time,
      status: visualNote.status,
    );
  }

  Todo toEntity() {
    return Todo(
      date: date,
      description: description,
      color: color,
      time:time,
      itemId: itemId,
      status: status,
    );
  }
}
