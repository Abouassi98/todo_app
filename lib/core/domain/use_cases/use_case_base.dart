import 'dart:async';

//A way to prevent one class having a call method and another an execute method is to provide an explicit interface.
// ignore: one_member_abstracts
abstract class UseCaseBase<T, Params> {
  FutureOr<T> call(Params params);
}

// ignore: one_member_abstracts
abstract class UseCaseNoParamsBase<T> {
  FutureOr<T> call();
}
