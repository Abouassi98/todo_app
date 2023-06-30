import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../domain/entity/todo.dart';
import '../../domain/use_case/get_all_items_uc.dart';
part 'get_items_provider.g.dart';

@riverpod
Future<List<Todo>> getItems(GetItemsRef ref) async =>
    ref.watch(getAllItemsUCProvider).call();
