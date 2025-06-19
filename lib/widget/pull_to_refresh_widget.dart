import 'package:ecom_app/widget/three_dot_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefreshWidget extends StatelessWidget {
  final Widget child;
  final Function() onRefresh;
  final Function() onLoading;
  PullToRefreshWidget({
    super.key,
    required this.child,
    required this.onRefresh,
    required this.onLoading,
  });
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      onRefresh: () {
        onRefresh();
        _refreshController.refreshCompleted();
      },
      onLoading: () {
        onLoading();
        _refreshController.loadComplete();
      },
      enablePullDown: true,
      enablePullUp: true,
      footer: CustomFooter(
        builder: (context, mode) {
          return const Center(child: CupertinoActivityIndicator());
        },
      ),
      header: const WaterDropHeader(
        complete: Icon(Icons.check, color: Colors.white),
        waterDropColor: Colors.black,
        refresh: ThreeDotLoader(),
      ),
      controller: _refreshController,
      child: child,
    );
  }
}
