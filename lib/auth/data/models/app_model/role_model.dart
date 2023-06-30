import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/role.dart';

part 'role_model.freezed.dart';
part 'role_model.g.dart';

@freezed
class RoleModel with _$RoleModel {
  factory RoleModel({
    required int id,
    required String name,
  }) = _RoleModel;
  const RoleModel._();

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  factory RoleModel.fromEntity(Role role) {
    return RoleModel(
      id: role.id,
      name: role.name,
    );
  }

  Role toEntity() {
    return Role(id: id, name: name);
  }
}
