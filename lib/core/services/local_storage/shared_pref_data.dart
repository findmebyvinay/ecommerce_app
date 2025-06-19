import 'package:ecom_app/core/constants/typedef.dart';

abstract class SharedPrefData {
  FutureVoid saveAuthToken({required String token});
  String get getAuthToken;
  FutureVoid clearAuthToken();

  FutureVoid saveTheme({required bool theme});
  bool get getTheme;

  FutureVoid saveLanguage({required String language});
  String get getLanguage;

  FutureVoid clearAllSharedData();
}
