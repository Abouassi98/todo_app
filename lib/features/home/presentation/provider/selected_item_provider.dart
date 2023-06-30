import 'package:flutter/material.dart';

import '../../../../core/presentation/providers/provider_utils.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../domain/entity/todo.dart';
part 'selected_item_provider.g.dart';

//Using [Option] to indicate idle(none)/success(some) states.
//This is a shorthand. You can use custom states using [freezed] instead.

@riverpod
class SelectedItem extends _$SelectedItem with NotifierUpdate {
  @override
  Option<Todo> build() => const None();
}

@riverpod
class SelectColorItem extends _$SelectColorItem with NotifierUpdate {
  @override
  Option<Color> build() => const None();
}
@riverpod
void clearSelectedItemAndColor(ClearSelectedItemAndColorRef ref) {
  ref.invalidate(selectedItemProvider);
  ref.invalidate(selectColorItemProvider);
}
