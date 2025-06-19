import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WarningView extends StatelessWidget {
  final String? message;
  const WarningView({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.warningContanerColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_sharp,
            color: AppColors.warningColor,
          ).padRight(right: 8.w),
          Flexible(
            child: Text(
              message ?? 'This is a warning message!',
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    ).padHorizontal(horizontal: 10.w).padVertical(vertical: 8.h);
  }
}
