import 'package:flutter/material.dart';
import '../../../../core/presentation/providers/provider_utils.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
part 'select_time_of_day_provider.g.dart';

//Using [Option] to indicate idle(none)/success(some) states.
//This is a shorthand. You can use custom states using [freezed] instead.

@riverpod
class SelectTimeOfDay extends _$SelectTimeOfDay with NotifierUpdate {
  @override
  Option<TimeOfDay> build() => const None();
}

@riverpod
class SelectDate extends _$SelectDate with NotifierUpdate {
  @override
  Option<DateTime> build() => const None();
}

@riverpod
void clearSelectedDateAndTime(ClearSelectedDateAndTimeRef ref) {
  ref.invalidate(selectDateProvider);
  ref.invalidate(selectTimeOfDayProvider);
}
