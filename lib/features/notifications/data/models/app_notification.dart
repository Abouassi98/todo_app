import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

@freezed
class AppNotification with _$AppNotification {
  factory AppNotification({
    String? id,
    String? title,
    String? content,
    String? type,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'order_id') String? orderId,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
