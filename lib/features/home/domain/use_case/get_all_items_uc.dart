import '../../../../core/domain/use_cases/use_case_base.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../data/repos/todo_repo.dart';
import '../entity/todo.dart';
import '../repos/i_todo_repo.dart';
part 'get_all_items_uc.g.dart';

@Riverpod(keepAlive: true)
GetAllItemsUC getAllItemsUC(GetAllItemsUCRef ref) {
  return GetAllItemsUC(
    todoRepo: ref.watch(todoRepoProvider),
  );
}

class GetAllItemsUC implements UseCaseNoParamsBase<List<Todo>> {
  GetAllItemsUC({required this.todoRepo});

  final ITodoRepo todoRepo;

  @override
  Future<List<Todo>> call() async {
    return todoRepo.getAllItems();
  }
}
