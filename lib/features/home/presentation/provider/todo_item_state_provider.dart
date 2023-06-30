import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../domain/entity/todo.dart';

part 'todo_item_state_provider.g.dart';

@Riverpod(keepAlive: true)
class TodoState extends _$TodoState {
  @override
  Option<Todo> build() => const None();

  void successAddTodoItem(Todo user) {
    state = Some(user);
  }

  void unSuccessAddTodoItem() {
    state = const None();
  }

  void updateTodoItem(Todo todo) {
    state.fold(
      () {},
      (item) => state = Some(
        item.copyWith(
          date: todo.date,
          description: todo.description,
          status: todo.status,
          color: todo.color,
          itemId: todo.itemId,
        ),
      ),
    );
  }

  void deleteTodoItem(Todo user) {
    state = Some(user);
  }
}

@riverpod
FutureOr<Todo> currentTodoItemState(CurrentTodoItemStateRef ref) {
  final item = ref.watch(todoStateProvider);
  return item.match(() => ref.future, (item) => item);
}

@riverpod
Todo currentTodoItem(CurrentTodoItemRef ref) {
  return ref.watch(currentTodoItemStateProvider).requireValue;
}
