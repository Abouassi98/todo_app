import '../../../../core/domain/use_cases/use_case_base.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../data/repos/todo_repo.dart';
import '../entity/todo.dart';
import '../repos/i_todo_repo.dart';
part 'add_item_uc.g.dart';

@Riverpod(keepAlive: true)
AddItemUC addItemUC(AddItemUCRef ref) {
  return AddItemUC(
    todoRepo: ref.watch(todoRepoProvider),
  );
}

class AddItemUC implements UseCaseBase<void, Todo> {
  AddItemUC({
    required this.todoRepo,
  });

  final ITodoRepo todoRepo;

  @override
  Future<void> call(Todo vs) async {
    return todoRepo.saveItem(vs);
  }
}
