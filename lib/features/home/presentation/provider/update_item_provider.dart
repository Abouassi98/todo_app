import '../../domain/use_case/update_item_uc.dart';
import 'get_items_provider.dart';
import 'todo_item_state_provider.dart';
import '../../../../core/presentation/providers/provider_utils.dart';
import '../../../../core/presentation/utils/event.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
part 'update_item_provider.g.dart';

//Using [Option] to indicate idle(none)/success(some) states.
//This is a shorthand. You can use custom states using [freezed] instead.
@riverpod
FutureOr<Option<void>> updateItemState(
  UpdateItemStateRef ref,
) {
  final sub = ref.listen(todoStateProvider.notifier, (prev, next) {});
  ref.listenSelf((previous, next) {
    next.whenData(
      (user) {
        if (user is Some<UpdateItemParams>) {
          sub.read().updateTodoItem(user.value.todo);
        }
      },
    );
  });
  final event = ref.watch(updateTodoItemEventProvider);

  return event.match(
    () => const None(),
    (event) {
      return ref
          .watch(
            updateItemProvider(
              event,
            ).future,
          )
          .then(Some.new);
    },
  );
}

@riverpod
class UpdateTodoItemEvent extends _$UpdateTodoItemEvent with NotifierUpdate {
  @override
  Option<Event<UpdateItemParams>> build() => const None();
}

@riverpod
Future<void> updateItem(
  UpdateItemRef ref,
  Event<UpdateItemParams> updateEvent,
) async {
  await ref.watch(updateItemUCProvider).call(
        updateEvent.arg,
      );

  ref.invalidate(getItemsProvider);
}
