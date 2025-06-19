import 'dart:io';

import 'package:ecom_app/core/bloc/internet_cubit.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/mixin/localization_mixin.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InternetConnectionWidget extends StatelessWidget {
  final Widget onlineWidget;
  final Widget offlineWidget;
  final Function(bool isConnected)? callBack;

  const InternetConnectionWidget({
    super.key,
    required this.onlineWidget,
    required this.offlineWidget,
    this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetCubit, InternetCubitState>(
      listener: (BuildContext context, InternetCubitState state) {
        if (callBack != null) {
          callBack!(state.isOnline);
        }
      },
      builder: (BuildContext ctx, InternetCubitState state) {
        return state.isOnline ? onlineWidget : offlineWidget;
      },
    );
  }
}

class InternetConnectionMsgWidget extends StatelessWidget {
  final bool isConnected;

  const InternetConnectionMsgWidget({super.key, required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Platform.isIOS ? 15.h : 3.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isConnected ? Colors.green[700] : Colors.red,
      ),
      child: Text(
        isConnected
            ? l10(AppLocale.backOnline)
            : l10(AppLocale.noInternetConnection),
        textAlign: TextAlign.center,
        style: context.textTheme.bodySmall!.copyWith(color: Colors.white),
      ),
    );
  }
}

class NoInternetConnectionWidget extends StatefulWidget {
  const NoInternetConnectionWidget({super.key});

  @override
  State<NoInternetConnectionWidget> createState() =>
      _NoInternetConnectionWidgetState();
}

class _NoInternetConnectionWidgetState
    extends State<NoInternetConnectionWidget> {
  final ValueNotifier<bool> _isToHide = ValueNotifier<bool>(
    getIt<InternetCubit>().state.isOnline,
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isToHide,
      builder: (_, bool isToHide, __) {
        return InternetConnectionWidget(
          callBack: (bool isConnected) {
            if (isConnected) {
              // Call your method after 3 seconds
              Future<void>.delayed(const Duration(seconds: 3), () {
                // Set showWidget to true after 3 seconds
                _isToHide.value = true;
              });
            } else {
              _isToHide.value = false;
            }
          },
          offlineWidget: const Align(
            alignment: Alignment.bottomCenter,
            child: InternetConnectionMsgWidget(isConnected: false),
          ),
          onlineWidget: Align(
            alignment: Alignment.bottomCenter,
            child: isToHide
                ? SizedBox.fromSize()
                : const InternetConnectionMsgWidget(isConnected: true),
          ),
        );
      },
    );
  }
}
