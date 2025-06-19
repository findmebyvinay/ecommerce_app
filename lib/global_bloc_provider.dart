// ignore_for_file: depend_on_referenced_packages

import 'package:ecom_app/core/bloc/app_open_cubit.dart';
import 'package:ecom_app/core/bloc/internet_cubit.dart';
import 'package:ecom_app/core/bloc/language_cubit.dart';
import 'package:ecom_app/core/bloc/theme_cubit.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/features/auth/presentation/Login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
/// Provides the core blocs as global providers.
List<SingleChildWidget> _coreBlocProvider() {
  return [
    BlocProvider<AppOpenCubit>.value(value: getIt<AppOpenCubit>()),
    BlocProvider<InternetCubit>.value(value: getIt<InternetCubit>()),
    BlocProvider<ThemeCubit>.value(value: getIt<ThemeCubit>()),
    BlocProvider<LanguageCubit>.value(value: getIt<LanguageCubit>()),
    BlocProvider<LoginBloc>.value(value: getIt<LoginBloc>(),),
  ];
}

/// Combines all global bloc providers into a single list.
List<SingleChildWidget> globalBlocProvider() {
  return [..._coreBlocProvider()];
}
