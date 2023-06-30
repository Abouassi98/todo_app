import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/user.dart';
import 'image_model.dart';
import 'role_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required int id,
    required String name,
    required String email,
    required List<RoleModel> roles,
    required ImageModel image,
  }) = _UserModel;
  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(User user) {
    return UserModel(
      email: user.email,
      id: user.id,
      image: ImageModel.fromEntity(user.image),
      roles: user.roles.map(RoleModel.fromEntity).toList(),
      name: user.name,
    );
  }

  User toEntity() {
    return User(
      email: email,
      id: id,
      name: name,
      image: image.toEntity(),
      roles: roles.map((e) => e.toEntity()).toList(),
    );
  }
}
