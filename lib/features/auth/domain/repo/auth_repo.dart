import 'package:ecom_app/core/constants/typedef.dart';

abstract class AuthRepo {
  FutureDynamicResponse login({
    required String username,
    required String password
  });
}