import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/app.dart';
import 'data_model.dart';
part 'app_model.freezed.dart';
part 'app_model.g.dart';

@freezed
class AppModel with _$AppModel {
  factory AppModel({
    required DataModel? data,
    required bool? status,
    required String message,
    required int? code,
    dynamic paginate,
  }) = _AppModel;
  const AppModel._();

  factory AppModel.fromJson(Map<String, dynamic> json) =>
      _$AppModelFromJson(json);

  factory AppModel.fromEntity(App app) {
    return AppModel(
      data: app.data != null ? DataModel.fromEntity(app.data!) : null,
      code: app.code ,
      message: app.message,
      status: app.status,
      paginate: app.paginate,
    );
  }

  App toEntity() {
    return App(
      code: code,
      data: data!.toEntity(),
      message: message,
      status: status,
      paginate: paginate,
    );
  }
}
