// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InternetCubit extends Cubit<InternetCubitState> {
  InternetCubit() : super(const InternetCubitState(isOnline: true)) {
    _connectivity = Connectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      emit(state.copyWith(isOnline: isOnline(result)));
    });

    initConnectivity();
  }

  late final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>>
  _connectivitySubscription;

  bool isOnline(List<ConnectivityResult> result) =>
      result.contains(ConnectivityResult.wifi) ||
      result.contains(ConnectivityResult.ethernet) ||
      result.contains(ConnectivityResult.vpn) ||
      result.contains(ConnectivityResult.mobile);

  Future<void> initConnectivity() async {
    final List<ConnectivityResult> result = await _connectivity
        .checkConnectivity();

    emit(state.copyWith(isOnline: isOnline(result)));
  }

  void updateCurrentScreenRoute({
    required String routeName,
    bool isPushed = true,
  }) async {
    List<String> routeList = <String>[...state.currentScreenRoute];

    bool existingRoute = routeList.isNotEmpty
        ? routeList.contains(routeName)
        : false;

    if (existingRoute) {
      if (isPushed) {
        if (!(routeName.trim() == '')) {
          routeList.add(routeName);
        }
      } else {
        routeList.removeLast();
      }
    } else {
      routeList.add(routeName);
    }

    final List<ConnectivityResult> result = await _connectivity
        .checkConnectivity();

    emit(
      state.copyWith(isOnline: isOnline(result), currentScreenRoute: routeList),
    );
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}

class InternetCubitState extends Equatable {
  final bool isOnline;
  final List<String> currentScreenRoute;

  const InternetCubitState({
    this.isOnline = true,
    this.currentScreenRoute = const <String>[],
  });

  InternetCubitState copyWith({
    bool? isOnline,
    List<String>? currentScreenRoute,
  }) {
    return InternetCubitState(
      currentScreenRoute: currentScreenRoute ?? this.currentScreenRoute,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  List<Object?> get props => <Object?>[isOnline, currentScreenRoute];
}
