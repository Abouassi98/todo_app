import '../../domain/use_case/add_item_uc.dart';
import 'get_items_provider.dart';
import 'todo_item_state_provider.dart';
import '../../../../core/presentation/providers/provider_utils.dart';
import '../../../../core/presentation/utils/event.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../domain/entity/todo.dart';
part 'add_item_provider.g.dart';

//Using [Option] to indicate idle(none)/success(some) states.
//This is a shorthand. You can use custom states using [freezed] instead.
@riverpod
FutureOr<Option<void>> addItemState(
  AddItemStateRef ref,
) {
  final sub = ref.listen(todoStateProvider.notifier, (prev, next) {});
  ref.listenSelf((previous, next) {
    next.whenData(
      (user) {
        if (user is Some<Todo>) {
          sub.read().successAddTodoItem(user.value);
        }
      },
    );
  });
  final event = ref.watch(addTodoItemEventProvider);

  return event.match(
    None.new,
    (event) {
      return ref
          .watch(
            addItemProvider(
              event,
            ).future,
          )
          .then(Some.new);
    },
  );
}

@riverpod
class AddTodoItemEvent extends _$AddTodoItemEvent with NotifierUpdate {
  @override
  Option<Event<Todo>> build() => const None();
}

@riverpod
Future<void> addItem(
  AddItemRef ref,
  Event<Todo> event,
) async {
  await ref.watch(addItemUCProvider).call(event.arg);
  ref.invalidate(getItemsProvider);
}
