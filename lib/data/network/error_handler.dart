import 'package:dio/dio.dart';
import 'package:firstproject/data/network/failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handler(dynamic error) {
    if (error is DioError) {
      // dio error its an error coming from response of Api from dio it self
      failure = _handlerError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handlerError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();

    case DioErrorType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();

    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }

    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();

    case DioErrorType.other:
      return DataSource.DEFAULT.getFailure();
      
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  NOT_FOUND,
  DEFAULT,
}

extension DataSourceExtension on DataSource {
  
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(Responsecode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(Responsecode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(Responsecode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
        case DataSource.FORBIDDEN:
        return Failure(Responsecode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTORISED:
        return Failure(Responsecode.UNAUTORISED, ResponseMessage.UNAUTORISED);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(Responsecode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            Responsecode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(Responsecode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            Responsecode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(Responsecode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(Responsecode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(Responsecode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.NOT_FOUND:
        return Failure(Responsecode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(Responsecode.DEFAULT, ResponseMessage.DEFAULT);
         
    }
  }
}

class Responsecode {
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 401;
  static const int UNAUTORISED = 403;
  static const int NOT_FOUND = 404;

  static const int INTERNAL_SERVER_ERROR = 500;
// local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = "Success";
  static const String NO_CONTENT = "Success";
  static const String BAD_REQUEST = "Bad request, try again later";
  static const String FORBIDDEN = "Forbidden request, try again later ";
  static const String UNAUTORISED = "user not authorized , try again later ";
  static const String NOT_FOUND = "Not Found , try again later ";
  static const String INTERNAL_SERVER_ERROR = "Some thing went wrong";
// local status code
  static const String CONNECT_TIMEOUT = "time out later, try again later ";
  static const String CANCEL = "Request was cancelled, try again later ";
  static const String RECIEVE_TIMEOUT = "Time out error, try again later";
  static const String SEND_TIMEOUT = "Time out error, try again later";
  static const String CACHE_ERROR = "cache error, try again later ";
  static const String NO_INTERNET_CONNECTION = "Please check your connection";
  static const String DEFAULT = "Something went wrong, try again later";
}


// this class api deal with the message which will come 
class ApiInternalStatus{
  static const int success=0;
  static const int failure=1;
}