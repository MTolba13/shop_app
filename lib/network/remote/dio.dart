import 'dart:async';

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static late Response response;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> get({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return response = await dio.get(url, queryParameters: query);
  }

  static Future<Response> post({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };
    return response = await dio.post(url, data: data);
  }
}
