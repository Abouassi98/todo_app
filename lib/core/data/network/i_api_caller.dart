import 'package:dio/dio.dart';

// ignore: one_member_abstracts
abstract class IApiCaller {
 

  Future<Response<T>> postData<T>({
    required String path,
    Map<String, String>? queryParameters,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  });


}
