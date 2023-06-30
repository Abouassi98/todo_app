import 'package:flutter/material.dart';
import '../../../../core/presentation/providers/provider_utils.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../domain/entity/todo.dart';
part 'filter_item_provider.g.dart';

//Using [Option] to indicate idle(none)/success(some) states.
//This is a shorthand. You can use custom states using [freezed] instead.

@riverpod
class FilterColorItem extends _$FilterColorItem with NotifierUpdate {
  @override
  Option<Color> build() => const None();
}

@riverpod
class FilterDateItem extends _$FilterDateItem with NotifierUpdate {
  @override
  Option<String> build() => const None();
}

@riverpod
void clearFilterDateAndColor(ClearFilterDateAndColorRef ref) {
  ref.invalidate(filterColorItemProvider);
  ref.invalidate(filterDateItemProvider);
}

@riverpod
List<Todo> filterList(FilterListRef ref, List<Todo> items) {
  final color = ref.watch(filterColorItemProvider);
  final date = ref.watch(filterDateItemProvider);
  return items.where((element) {
    if (color.isNone() && date.isNone()) {
      return false;
    } else if (color.isSome() && date.isNone()) {
      return element.color! == color.toNullable()?.value;
    } else if (color.isNone() && date.isSome()) {
      return element.date!.startsWith(date.toNullable()!);
    } else {
      return element.color! == color.toNullable()?.value &&
          element.date!.startsWith(date.toNullable() ?? '');
    }
  }).toList();
}
