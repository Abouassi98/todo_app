import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo.freezed.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    String? itemId,
    String? date,
    String? time,
    String? description,
    int? color,
    String? status,
  }) = _Todo;
}
