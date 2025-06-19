import 'package:ecom_app/core/mixin/localization_mixin.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/local_storage/shared_pref_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LanguageCubit extends Cubit<String> {
  LanguageCubit() : super(AppLanguage.en_lang);

  void init() {
    final String language = getIt<SharedPrefData>().getLanguage;
    emit(language.isNotEmpty ? language : AppLanguage.en_lang);
  }

  void changeLanguage(String newLanguage) async {
    emit(newLanguage);
    getIt<SharedPrefData>().saveLanguage(language: newLanguage);
  }

  void resetLanguage() {
    emit(AppLanguage.en_lang);
  }

  bool isEnglish() {
    return state == AppLanguage.en_lang;
  }

  bool isNepali() {
    return state == AppLanguage.ne_lang;
  }

  String get currentLanguage => state;
  String get currentLanguageName {
    return state == AppLanguage.en_lang
        ? AppLocale.en[AppLocale.languagae]
        : AppLocale.ne[AppLocale.languagae];
  }
}
