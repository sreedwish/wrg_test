import 'dart:async';

import 'package:retrofit/retrofit.dart';
import 'package:white_rabbit_sreedwish/constants.dart';
import 'package:white_rabbit_sreedwish/rest/ip_class.dart';
import 'package:dio/dio.dart';
import '../models/user.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: appBaseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio) {
    dio.options.connectTimeout = timeOutVal;
    dio.options.receiveTimeout = timeOutVal;
    dio.interceptors.add(LoggingInterceptors());

    return _ApiClient(dio, baseUrl: appBaseUrl);
  }

  //Api calls goes here
  @GET(users)
  Future<List<User>> getUsers();
}

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (logEnabled) {
      // ignore: avoid_print
      print(
          "--> ${options.method.toUpperCase()} ${"" + (options.baseUrl) + (options.path)}");
      // ignore: avoid_print
      print("Headers:");
      // ignore: avoid_print
      options.headers.forEach((k, v) => print('$k: $v'));
      // ignore: avoid_print
      print("queryParameters:");
      // ignore: avoid_print
      options.queryParameters.forEach((k, v) => print('$k: $v'));
      if (options.data != null) {
        // ignore: avoid_print
        print("Body: ${options.data}");
      }
      // ignore: avoid_print
      print("--> END ${options.method.toUpperCase()}");
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (logEnabled) {
      // ignore: avoid_print
      print("<-- ${response.statusCode} ${(response.realUri)}");
      // ignore: avoid_print
      print("Headers:");
      // ignore: avoid_print
      response.headers.forEach((k, v) => print('$k: $v'));
      // ignore: avoid_print
      print("Response: ${response.data}");
      // ignore: avoid_print
      print("<-- END HTTP");
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
