import 'package:freezed_annotation/freezed_annotation.dart';
part 'role.freezed.dart';


@freezed
class Role with _$Role {
  factory Role({
 required   int id,
  required  String name,
  }) = _Role;


}
