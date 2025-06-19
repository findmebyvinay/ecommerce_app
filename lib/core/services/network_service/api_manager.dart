// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:ecom_app/core/flavor/get_env_config.dart';
import 'package:ecom_app/core/services/network_service/api_interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class ApiManager {
  Dio? dio;

  ApiManager() {
    final options = BaseOptions(
      baseUrl: GetEnvConfig.baseUrl,
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(minutes: 1),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    dio = Dio(options);
    dio!.interceptors.add(ApiInterceptor(dioInstance: dio));

    dio!.interceptors.add(
      PrettyDioLogger(
        request: false,
        responseBody: false,
        requestBody: false,
        requestHeader: false,
      ),
    );

    //this is for avoiding certificates error cause by dio
    //https://issueexplorer.com/issue/flutterchina/dio/1285
    //for handaling bad certificate uncomment it

    (dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };
  }
}
