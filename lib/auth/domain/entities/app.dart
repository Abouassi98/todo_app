import 'package:freezed_annotation/freezed_annotation.dart';
import 'data.dart';
part 'app.freezed.dart';

@freezed
class App with _$App {
  factory App({
    required Data? data,
    required bool ?status,
    required String message,
    required int ?code,
    dynamic paginate,
  }) = _App;
}
