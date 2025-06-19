// ignore_for_file: library_private_types_in_public_api

import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void showPermissionConfirmDialog({
    required String message,
    required Function() onConfirmed,
    Function()? onDenied,
    bool showCancelBtn = true,
    bool barrierDismissible = true,
    Color? confirmButtonColor,
    Color? confirmBtnFontColor,
    Color? cancelFontColor,
  }) async {
    final bool? state = await showDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return PermanentlyDeniedDialog(
          message: message,
          onConfirmed: onConfirmed,
          showCancelBtn: showCancelBtn,
          onDenied: onDenied,
          cancelFontColor: cancelFontColor,
          confirmBtnFontColor: confirmBtnFontColor,
          confirmButtonColor: confirmButtonColor,
        );
      },
    );
    if (state != null && state) {
      onConfirmed();
    }
  }
}

class PermanentlyDeniedDialog extends StatefulWidget {
  const PermanentlyDeniedDialog({
    required this.message,
    required this.onConfirmed,
    this.showCancelBtn = true,
    this.onDenied,
    this.confirmBtnFontColor,
    this.cancelFontColor,
    this.confirmButtonColor,
    super.key,
  });

  final Function() onConfirmed;
  final Function()? onDenied;
  final String message;
  final bool showCancelBtn;
  final Color? confirmButtonColor;
  final Color? confirmBtnFontColor;
  final Color? cancelFontColor;

  @override
  _PermanentlyDeniedDialogState createState() =>
      _PermanentlyDeniedDialogState();
}

class _PermanentlyDeniedDialogState extends State<PermanentlyDeniedDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: context.isDark
              ? AppColors.darkGreyColor
              : AppColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              widget.message,
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.showCancelBtn)
                  TextButton(
                    onPressed: () {
                      if (widget.onDenied != null) {
                        widget.onDenied!();
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(double.infinity, 40),
                    ),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: widget.cancelFontColor ?? Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, true);
                    widget.onConfirmed();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color:
                          widget.confirmButtonColor ??
                          Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      "Open App Settings",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: widget.confirmBtnFontColor ?? Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
