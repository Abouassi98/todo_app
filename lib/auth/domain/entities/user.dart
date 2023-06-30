import 'package:freezed_annotation/freezed_annotation.dart';
import 'image.dart';
import 'role.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  factory User({
    required int id,
    required String name,
    required String email,
    required List<Role> roles,
    required Image image,
  }) = _User;
}
