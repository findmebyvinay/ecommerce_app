// ignore_for_file: use_build_context_synchronously

import 'package:ecom_app/core/mixin/localization_mixin.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:flutter/material.dart';

class AppAlertDialog {
  /// ✅ NEW: Helper method to show confirmation alert dialog
  Future<void> showExitConfirmationDialog<bool>(BuildContext context) async {
    Future.delayed(Duration(milliseconds: 100), () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10(AppLocale.exitAppTitle)), // e.g. "Exit App?"
          content: Text(
            l10(AppLocale.exitAppConfirmation),
          ), // e.g. "Are you sure you want to exit?"
          actions: [
            TextButton(
              onPressed: () {
                getIt<NavigationService>().popDialog(true);
              },
              child: Text(l10(AppLocale.cancel)), // e.g. "Cancel"
            ),
            TextButton(
              onPressed: () {
                getIt<NavigationService>().popDialog(true);
                getIt<NavigationService>().pop(true);
              },
              child: Text(l10(AppLocale.ok)), // e.g. "OK"
            ),
          ],
        ),
      );
    });
  }
}
