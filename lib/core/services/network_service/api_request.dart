// ignore_for_file: unused_field

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecom_app/core/common/failure_state.dart';
import 'package:ecom_app/core/constants/typedef.dart';
import 'package:ecom_app/core/services/app_clear_service.dart';
import 'package:ecom_app/core/services/network_service/api_manager.dart';
import 'package:ecom_app/core/utils/app_toast.dart';
import 'package:injectable/injectable.dart';

enum ApiMethods { get, post, delete, put }

abstract class ApiRequest {
  ApiManager get apiManager;

  FutureDynamicResponse decodeHttpRequestResponse(
    Response? response, {
    String message = "",
  });

  FutureDynamicResponse getResponse({
    required String endPoint,
    required ApiMethods apiMethods,
    Map<String, dynamic>? queryParams,
    dynamic body,
    Options? options,
    String? errorMessage,
  });
}

@LazySingleton(as: ApiRequest)
class ApiRequestImpl implements ApiRequest {
  final ApiManager _apiManager;

  // Constructor injection: ApiManager will be injected automatically by injectable
  ApiRequestImpl(this._apiManager);

  @override
  ApiManager get apiManager => _apiManager;

  @override
  FutureDynamicResponse decodeHttpRequestResponse(
    Response? response, {
    String message = "",
  }) async {
    AppToasts toastHelper = AppToasts();
    List<int> successStatusCode = [200, 201];
    if (successStatusCode.contains(response?.statusCode)) {
      return Left({'data': response?.data, 'message': message});
    } else if (response?.statusCode == 500) {
      toastHelper.showToast(message: 'Server Error', isSuccess: false);
      return Left(response?.data);
    } else if (response?.statusCode == 401) {
      toastHelper.showToast(message: 'Unauthorized', isSuccess: false);
      AppClearService().clearAllData();
    } else if (response?.statusCode == 400) {
      return Right(Failure.fromJson(response?.data));
    } else if (response?.statusCode == 422) {
      return Right(Failure.fromJson(response?.data));
    } else if (response?.data == null) {
      return Right(response?.data);
    } else {
      return Right(Failure(message: 'Something went wrong'));
    }
    return response?.data;
  }

  @override
  FutureDynamicResponse getResponse({
    required String endPoint,
    required ApiMethods apiMethods,
    Map<String, dynamic>? queryParams,
    body,
    Options? options,
    String? errorMessage,
  }) async {
    Response? response;
    try {
      if (apiMethods == ApiMethods.post) {
        response = await apiManager.dio!.post(
          endPoint,
          data: body,
          queryParameters: queryParams,
          options: options,
        );
      } else if (apiMethods == ApiMethods.delete) {
        response = await apiManager.dio!.delete(
          endPoint,
          data: body,
          queryParameters: queryParams,
          options: options,
        );
      } else if (apiMethods == ApiMethods.put) {
        response = await apiManager.dio!.put(
          endPoint,
          data: body,
          queryParameters: queryParams,
          options: options,
        );
      } else {
        response = await apiManager.dio!.get(
          endPoint,
          queryParameters: queryParams,
          options: options,
        );
      }

      return decodeHttpRequestResponse(response, message: errorMessage ?? "");
    } catch (e) {
      return Right(Failure(message: errorMessage ?? 'Something went wrong'));
    }
  }
}
