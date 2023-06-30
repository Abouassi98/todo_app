import 'package:dio/dio.dart';


class ApiKeyInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    return handler.next(options);
  }
}
