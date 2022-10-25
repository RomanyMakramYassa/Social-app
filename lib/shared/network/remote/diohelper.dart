import 'package:dio/dio.dart';

class Diohelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      /* NEWwws AAAP
          baseUrl: 'https://newsapi.org/', in newsApp
        receiveDataWhenStatusError: true,
        headers: {'Content_Type': 'application/json'}));*/
      // SHHHHHHHHHHHOP APPPPP
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
    //headers: {'Content_Type': 'application/json'}));
  }

  static Future<Response> getdate(
      {required String url,
      Map<String, dynamic>? pram,
      String? taken,
      String lang = 'en'}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': taken ?? '',
      'Content_Type': 'application/json'
    };
    return await dio.get(url, queryParameters: pram ?? null);
  }

  static Future<Response> postdate(
      {required String url,
      Map<String, dynamic>? pram,
      String? Taken,
      String lang = 'en',
      required Map<String, dynamic> ddata}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': Taken ?? '',
      'Content_Type': 'application/json'
    };
    return await dio.post(url, queryParameters: pram, data: ddata);
  }

  static Future<Response> putdate(
      {required String url,
      Map<String, dynamic>? pram,
      String? Taken,
      String lang = 'en',
      required Map<String, dynamic> ddata}) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': Taken ?? '',
      'Content_Type': 'application/json'
    };
    return await dio.put(url, queryParameters: pram, data: ddata);
  }
}
