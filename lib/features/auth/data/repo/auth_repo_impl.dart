import 'package:ecom_app/core/constants/typedef.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/network_service/api_request.dart';
import 'package:ecom_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as:AuthRepo)
class AuthRepoImpl extends AuthRepo{
  static const String _loginEndpoint ='https://dummyjson.com/auth/login';
  @override
  FutureDynamicResponse login({
    required String username,
    required String password,
  }){
    return getIt<ApiRequest>().getResponse(
      endPoint: _loginEndpoint,
       apiMethods: ApiMethods.post,
       body: {"username": username, "password": password},
       );
  }
}