import 'package:dio/dio.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../i_api_config.dart';
import 'google_map_api_config.dart';
import 'interceptors/content_type_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

part 'api_caller_dio_providers.g.dart';

//Note: If you've different subdomains of an API (need same interceptors and other options but different baseUrl),
//then you can use one instance of dio and override the base URL dynamically
@Riverpod(keepAlive: true)
Dio apiCallerDio(ApiCallerDioRef ref) {
  return Dio()
    ..options = BaseOptions(
      baseUrl: GoogleMapApiConfig.kBaseUrl,
      connectTimeout: const Duration(milliseconds: IApiConfig.connectTimeout),
      receiveTimeout: const Duration(milliseconds: IApiConfig.receiveTimeout),
    )
    ..interceptors.addAll([
     
      LoggingInterceptor(),
      ContentTypeInterceptor(),
    ]);
}
