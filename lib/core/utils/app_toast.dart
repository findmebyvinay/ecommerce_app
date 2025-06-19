import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToasts {
  showToast({
    required String message,
    Color? backgroundColor,
    bool isSuccess = true,
  }) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor:
          backgroundColor ??
          (isSuccess ? AppColors.successColor : AppColors.errorColor),
      gravity: ToastGravity.BOTTOM,
      fontSize: 11.sp,
    );
  }
}
