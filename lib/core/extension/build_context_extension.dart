import 'package:ecom_app/core/bloc/internet_cubit.dart';
import 'package:ecom_app/core/bloc/language_cubit.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

extension BuildContextExension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isOnline => getIt<InternetCubit>().state.isOnline;

  bool get isEnglish => getIt<LanguageCubit>().isEnglish();

  String l10(String key) {
    return key.getString(this);
  }

  /// return screen devicePixelRatio
  double pixelRatio() => MediaQuery.of(this).devicePixelRatio;

  /// returns brightness
  Brightness platformBrightness() => MediaQuery.of(this).platformBrightness;

  /// Return the height of status bar
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Return the height of navigation bar
  double get navigationBarHeight => MediaQuery.of(this).padding.bottom;

  /// Returns Theme.of(context)
  ThemeData get theme => Theme.of(this);

  /// Returns Theme.of(context).textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns Form.of(context)
  FormState? get formState => Form.of(this);

  /// Returns Scaffold.of(context)
  ScaffoldState get scaffoldState => Scaffold.of(this);

  /// Returns Overlay.of(context)
  OverlayState? get overlayState => Overlay.of(this);

  /// Request focus to given FocusNode
  void requestFocus(FocusNode focus) {
    FocusScope.of(this).requestFocus(focus);
  }

  /// Request focus to given FocusNode
  void unFocus(FocusNode focus) {
    focus.unfocus();
  }
}
