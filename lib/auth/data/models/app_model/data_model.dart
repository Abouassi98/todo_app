import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/data.dart';
import 'user_model.dart';

part 'data_model.freezed.dart';
part 'data_model.g.dart';

@freezed
class DataModel with _$DataModel {
  factory DataModel({
    required UserModel user,
    required String token,
  }) = _DataModel;
  const DataModel._();

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  factory DataModel.fromEntity(Data data) {
    return DataModel(
      token: data.token,
      user: UserModel.fromEntity(data.user),
    );
  }

  Data toEntity() {
    return Data(
      token: token,
      user: user.toEntity(),
    );
  }
}
