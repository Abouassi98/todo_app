import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';
part 'data.freezed.dart';


@freezed
class Data with _$Data {
  factory Data({
  required  User user,
  required  String token,
  }) = _Data;

}
