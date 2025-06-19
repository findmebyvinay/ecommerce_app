import 'dart:ui';

import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/local_storage/shared_pref_data.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);

  void init() {
    final bool isDarkMode = getIt<SharedPrefData>().getTheme;
    emit(isDarkMode);
  }

  void toggleTheme({bool? state}) {
    emit(state ?? !this.state);
    getIt<SharedPrefData>().saveTheme(theme: state ?? !this.state);
  }

  void resetTheme() {
    emit(false);
  }

  void setDeviceTheme() {
    final Brightness brightness = MediaQuery.of(
      getIt<NavigationService>().getNavigationContext(),
    ).platformBrightness;

    bool isDarkMode = brightness == Brightness.dark;
    if (isDarkMode != state) {
      emit(isDarkMode);
    }
  }
}
