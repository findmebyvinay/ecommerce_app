// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../../features/auth/data/repo/auth_repo_impl.dart' as _i732;
import '../../../features/auth/domain/repo/auth_repo.dart' as _i913;
import '../../../features/auth/presentation/Login_bloc/login_bloc.dart' as _i81;
import '../../../features/products/data/product_repo_impl.dart' as _i385;
import '../../../features/products/domain/repo/product_repo.dart' as _i186;
import '../../../features/products/presentation/product_bloc/product_bloc.dart'
    as _i125;
import '../../bloc/app_open_cubit.dart' as _i150;
import '../../bloc/internet_cubit.dart' as _i636;
import '../../bloc/language_cubit.dart' as _i957;
import '../../bloc/location_cubit.dart' as _i67;
import '../../bloc/theme_cubit.dart' as _i1027;
import '../local_storage/shared_pref_data.dart' as _i324;
import '../local_storage/shared_pref_data_impl.dart' as _i566;
import '../local_storage/shared_pref_module.dart' as _i421;
import '../local_storage/shared_pref_service.dart' as _i942;
import '../navigation_service.dart' as _i892;
import '../network_service/api_manager.dart' as _i609;
import '../network_service/api_request.dart' as _i601;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPrefsModule = _$SharedPrefsModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefsModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i150.AppOpenCubit>(() => _i150.AppOpenCubit());
    gh.lazySingleton<_i636.InternetCubit>(() => _i636.InternetCubit());
    gh.lazySingleton<_i957.LanguageCubit>(() => _i957.LanguageCubit());
    gh.lazySingleton<_i67.LocationCubit>(() => _i67.LocationCubit());
    gh.lazySingleton<_i1027.ThemeCubit>(() => _i1027.ThemeCubit());
    gh.lazySingleton<_i892.NavigationService>(() => _i892.NavigationService());
    gh.lazySingleton<_i609.ApiManager>(() => _i609.ApiManager());
    gh.lazySingleton<_i81.LoginBloc>(() => _i81.LoginBloc());
    gh.lazySingleton<_i125.ProductBloc>(() => _i125.ProductBloc());
    gh.lazySingleton<_i324.SharedPrefData>(() => _i566.SharedPrefDataImpl());
    gh.lazySingleton<_i186.ProductRepo>(() => _i385.ProductRepoImpl());
    gh.lazySingleton<_i913.AuthRepo>(() => _i732.AuthRepoImpl());
    gh.lazySingleton<_i942.SharedPrefsServices>(
      () => _i942.SharedPrefsServices(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i601.ApiRequest>(
      () => _i601.ApiRequestImpl(gh<_i609.ApiManager>()),
    );
    return this;
  }
}

class _$SharedPrefsModule extends _i421.SharedPrefsModule {}
