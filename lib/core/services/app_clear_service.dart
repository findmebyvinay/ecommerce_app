import 'package:ecom_app/core/bloc/app_open_cubit.dart';
import 'package:ecom_app/core/bloc/language_cubit.dart';
import 'package:ecom_app/core/bloc/theme_cubit.dart';
import 'package:ecom_app/core/routes/routes_name.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/local_storage/shared_pref_data.dart';
import 'package:ecom_app/core/services/navigation_service.dart';

class AppClearService {
  void clearAllData() async {
    /// Clear Token Data
    getIt<SharedPrefData>().clearAuthToken();
    getIt<SharedPrefData>().clearAllSharedData();

    /// Clear Bloc Data
    getIt<AppOpenCubit>().reset();
    getIt<ThemeCubit>().resetTheme();
    getIt<LanguageCubit>().resetLanguage();

    /// Navigate To
    getIt<NavigationService>().pushNamedAndRemoveUntil(
      RoutesName.loginScreen,
      false,
    );
  }
}
