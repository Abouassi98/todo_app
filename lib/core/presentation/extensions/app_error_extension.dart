import 'package:flutter/material.dart';
import '../../data/error/app_exception.dart';

extension AppErrorExtension on Object {
  String errorMessage(BuildContext context) {
    final error = this;
    if (error is AppException) {
      return error.map(
        serverException: (ex) => ex.serverErrorMessage(context),
        //TODO: handle other cache exception error messages
        cacheException: (ex) => 'unknown Error',
      );
    }
    return 'unknown Error';
  }
}

extension ServerErrorExtension on ServerException {
  String serverErrorMessage(BuildContext context) {
    switch (type) {
      case ServerExceptionType.unknown:
        return 'unknown Error';
      case ServerExceptionType.general:
        return message; //Business logic error message from the backend
      case ServerExceptionType.unauthorized:
        return 'unauthorized Error';
      case ServerExceptionType.forbidden:
        return 'forbidden Error';
      case ServerExceptionType.notFound:
        return 'notFound Error';
      case ServerExceptionType.conflict:
        return 'conflict Error';
      case ServerExceptionType.internal:
        return 'internal Error';
      case ServerExceptionType.serviceUnavailable:
        return 'serviceUnavailableError';
      case ServerExceptionType.timeOut:
        return 'timeout Error';
      case ServerExceptionType.noInternet:
        return 'no Internet Error';
      case ServerExceptionType.authInvalidEmail:
        return 'auth Invalid Email Error';
      case ServerExceptionType.authWrongPassword:
        return 'auth WrongP assword Error';
      case ServerExceptionType.authUserNotFound:
        return 'auth User Not Found Error';
      case ServerExceptionType.authUserDisabled:
        return 'auth User Disabled Error';
    }
  }
}
