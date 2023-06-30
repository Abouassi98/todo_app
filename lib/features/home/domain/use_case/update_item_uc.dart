import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/use_cases/use_case_base.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../data/repos/todo_repo.dart';
import '../entity/todo.dart';
import '../repos/i_todo_repo.dart';
part 'update_item_uc.freezed.dart';
part 'update_item_uc.g.dart';

@Riverpod(keepAlive: true)
UpdateItemUC updateItemUC(UpdateItemUCRef ref) {
  return UpdateItemUC(
    todoRepo: ref.watch(todoRepoProvider),
  );
}

class UpdateItemUC implements UseCaseBase<void, UpdateItemParams> {
  UpdateItemUC({
    required this.todoRepo,
  });

  final ITodoRepo todoRepo;

  @override
  Future<void> call(UpdateItemParams vs) async {
    return todoRepo.updateItem(vs.todo, vs.oldId);
  }
}

@freezed
class UpdateItemParams with _$UpdateItemParams {
  const factory UpdateItemParams({
    required String oldId,
    required Todo todo,
  }) = _UpdateItemParams;
}
