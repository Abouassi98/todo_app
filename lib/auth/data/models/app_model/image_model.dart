import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/image.dart';
part 'image_model.freezed.dart';
part 'image_model.g.dart';

@freezed
class ImageModel with _$ImageModel {
  factory ImageModel({
    required int id,
    @JsonKey(name: 'imageable_id') required int imageableId,
    @JsonKey(name: 'imageable_type') required String imageableType,
    required String path,
    @JsonKey(name: 'full_path') required String fullPath,
    required int order,
  }) = _ImageModel;
  const ImageModel._();

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  factory ImageModel.fromEntity(Image image) {
    return ImageModel(
      fullPath: image.fullPath,
      id: image.id,
      imageableId: image.imageableId,
      imageableType: image.imageableType,
      order: image.order,
      path: image.path,
    );
  }

  Image toEntity() {
    return Image(
      id: id,
      imageableId: imageableId,
      imageableType: imageableType,
      order: order,
      path: path,
      fullPath: fullPath,
    );
  }
}
