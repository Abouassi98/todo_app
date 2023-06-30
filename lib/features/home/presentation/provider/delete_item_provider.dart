import '../../../../core/presentation/utils/event.dart';
import '../../domain/use_case/delete_item_uc.dart';
import 'todo_item_state_provider.dart';

import '../../../../core/presentation/providers/provider_utils.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';

import '../../domain/entity/todo.dart';
import 'get_items_provider.dart';

part 'delete_item_provider.g.dart';

@riverpod
FutureOr<Option<void>> deleteItemState(DeleteItemStateRef ref) {
  final sub = ref.listen(todoStateProvider.notifier, (prev, next) {});
  ref.listenSelf((previous, next) {
    next.whenData(
      (item) {
        if (item is Some<Todo>) {
          sub.read().deleteTodoItem(item.value);
        }
      },
    );
  });

  final event = ref.watch(deleteItemEventProvider);
  return event.match(
    None.new,
    (event) {
      return ref.watch(deleteItemProvider(event).future).then(Some.new);
    },
  );
}

@riverpod
class DeleteItemEvent extends _$DeleteItemEvent with NotifierUpdate {
  @override
  Option<Event<String>> build() => const None();
}

@riverpod
Future<void> deleteItem(
  DeleteItemRef ref,
  Event<String> event,
) async {
  await ref.watch(deleteItemUCProvider).call(event.arg);
  ref.invalidate(getItemsProvider);
}
