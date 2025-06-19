import 'package:flutter/material.dart';

mixin ScrollMixin {
  void scrollListener({
    required ScrollController scrollController,
    required ValueNotifier<bool> showBottomSheet,
  }) {
    scrollController.addListener(() {
      _onScroll(
        scrollController: scrollController,
        showBottomSheet: showBottomSheet,
      );
    });
  }

  void _onScroll({
    required ScrollController scrollController,
    required ValueNotifier<bool> showBottomSheet,
  }) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (maxScroll == 0) return; // Avoid division by zero on short lists

    final percentScrolled = currentScroll / maxScroll;

    final shouldShow = percentScrolled >= 0.95;

    if (shouldShow != showBottomSheet.value) {
      showBottomSheet.value = shouldShow;
    }
  }
}
