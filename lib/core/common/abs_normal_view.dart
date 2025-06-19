import 'package:ecom_app/core/constants/enum.dart';
import 'package:ecom_app/widget/error_widget.dart';
import 'package:ecom_app/widget/no_data_widget.dart';
import 'package:ecom_app/widget/pull_to_refresh_widget.dart';
import 'package:ecom_app/widget/three_dot_loader.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AbsNormalView<T> extends StatelessWidget {
  final bool isToRefresh;
  final Widget child;
  final Widget? errorWidget;
  final AbsNormalStatus absNormalStatus;
  final T? data;
  final VoidCallback? onRetry;
  AbsNormalView({
    super.key,
    this.isToRefresh = false,
    required this.child,
    this.errorWidget,
    required this.absNormalStatus,
    this.data,
    this.onRetry,
  }) : assert(
         !isToRefresh || onRetry != null,
         'If isToRefresh is true, onRetry must not be null',
       );

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    switch (absNormalStatus) {
      case AbsNormalStatus.LOADING:
      case AbsNormalStatus.INITIAL:
        return const Center(child: ThreeDotLoader());

      case AbsNormalStatus.ERROR:
        return errorWidget ?? CustomErrorWidget(onRetry: onRetry ?? () {});

      case AbsNormalStatus.SUCCESS:
        if (data is List && (data as List).isEmpty) {
          return const NoDataWidget();
        } else if (data != null) {
          return isToRefresh
              ? SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () {
                    onRetry!();
                    _refreshController.refreshCompleted();
                  },
                  child: child,
                )
              : child;
        } else {
          return const NoDataWidget();
        }
    }
  }
}

class AbsPaginationNormalView<T> extends StatelessWidget {
  final Widget child;
  final Widget? errorWidget;
  final AbsNormalStatus absNormalStatus;
  final T? data;
  final VoidCallback onLoading;
  final VoidCallback onRefresh;
  const AbsPaginationNormalView({
    super.key,
    required this.child,
    this.errorWidget,
    required this.absNormalStatus,
    this.data,
    required this.onLoading,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    switch (absNormalStatus) {
      case AbsNormalStatus.LOADING:
      case AbsNormalStatus.INITIAL:
        return const Center(child: ThreeDotLoader());

      case AbsNormalStatus.ERROR:
        return errorWidget ?? CustomErrorWidget(onRetry: onRefresh);

      case AbsNormalStatus.SUCCESS:
        if (data is List && (data as List).isEmpty) {
          return const NoDataWidget();
        } else if (data != null) {
          return PullToRefreshWidget(
            onLoading: onLoading,
            onRefresh: onRefresh,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: child,
            ),
          );
        } else {
          return const NoDataWidget();
        }
    }
  }
}
