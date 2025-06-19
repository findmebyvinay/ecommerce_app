import 'package:dio/dio.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/local_storage/shared_pref_data.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({this.dioInstance});

  final Dio? dioInstance;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String accessToken = getIt<SharedPrefData>().getAuthToken;

    if (accessToken.isNotEmpty) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $accessToken');
    }
    return super.onRequest(options, handler);
  }
}
