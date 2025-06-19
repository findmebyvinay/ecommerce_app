import 'package:ecom_app/core/constants/shared_pref_keys.dart';
import 'package:ecom_app/core/constants/typedef.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/local_storage/shared_pref_data.dart';
import 'package:ecom_app/core/services/local_storage/shared_pref_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: SharedPrefData)
/// Implementation of [SharedPrefData] that uses [SharedPrefsServices] for local storage.
class SharedPrefDataImpl extends SharedPrefData {
  ///  ========= Auth Token =========
  @override
  Future<void> saveAuthToken({required String token}) async {
    await getIt<SharedPrefsServices>().setString(
      key: SharedPrefKeys.tokenKey,
      value: token,
    );
  }

  @override
  String get getAuthToken =>
      getIt<SharedPrefsServices>().getString(key: SharedPrefKeys.tokenKey) ??
      '';

  @override
  Future<void> clearAuthToken() async {
    getIt<SharedPrefsServices>().removeSharedPrefsData(
      key: SharedPrefKeys.tokenKey,
    );
  }

  ///  ========= Theme =========
  @override
  Future<void> saveTheme({required bool theme}) async {
    await getIt<SharedPrefsServices>().setBool(
      key: SharedPrefKeys.theme,
      value: theme,
    );
  }

  @override
  bool get getTheme =>
      getIt<SharedPrefsServices>().getBool(key: SharedPrefKeys.theme) ?? false;

  ///  ========= Language =========
  @override
  Future<void> saveLanguage({required String language}) async {
    await getIt<SharedPrefsServices>().setString(
      key: SharedPrefKeys.language,
      value: language,
    );
  }

  @override
  String get getLanguage =>
      getIt<SharedPreferences>().getString(SharedPrefKeys.language) ?? '';

  @override
  FutureVoid clearAllSharedData() async {
    getIt<SharedPrefsServices>().clearSharedPrefsData();
  }
}
