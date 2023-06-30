import '../../../../core/domain/use_cases/use_case_base.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../data/repos/todo_repo.dart';
import '../repos/i_todo_repo.dart';
part 'delete_item_uc.g.dart';

@Riverpod(keepAlive: true)
DeleteItemUC deleteItemUC(DeleteItemUCRef ref) {
  return DeleteItemUC(
    todoRepo: ref.watch(todoRepoProvider),
  );
}

class DeleteItemUC implements UseCaseBase<void, String> {
  DeleteItemUC({required this.todoRepo});

  final ITodoRepo todoRepo;

  @override
  Future<void> call(String noteId) async {
    return todoRepo.deleteItem(noteId: noteId);
  }
}
