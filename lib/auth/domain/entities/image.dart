import 'package:freezed_annotation/freezed_annotation.dart';
part 'image.freezed.dart';

@freezed
class Image with _$Image {
  factory Image({
    required int id,
    @JsonKey(name: 'imageable_id') required int imageableId,
    @JsonKey(name: 'imageable_type') required String imageableType,
    required String path,
    @JsonKey(name: 'full_path') required String fullPath,
    required int order,
  }) = _Image;
}
