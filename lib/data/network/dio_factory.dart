import 'package:dio/dio.dart';
import 'package:firstproject/app/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:firstproject/app/shared_prefs.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "langauge";

class DioFactory {
  // adding shared prefs variable in dio factory
  final AppPrefreneces
      _appPreferences; // here before same mistake when i make variable coming from Widget name not package name
  DioFactory(this._appPreferences);
  Future<Dio?> getDio() async {
    // this making instant of Dio package, variable
    Dio dio = Dio();
    // this section deal with primary data like token, languge, authenticatin, kind of body(pdf, json,html) ,,,,
    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: language,
      // to get lan from app prefs
    };

    // this one coming after we make variable dio , _timeout, headers, then last thing to return dio
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: Constants.apiTimeOut,
      sendTimeout: Constants.apiTimeOut,
    );
    // codition to not use pretty dio loggs when release mode
    // if condition here its means if not equal kReleaseMode do this ....
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      ); // to add pretty interceptors
    }
    return dio;
  }
}
