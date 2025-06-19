import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/mixin/localization_mixin.dart';
import 'package:ecom_app/widget/three_dot_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final String? lable;
  final Function() onTap;
  final Color? buttonColor, lableColor, borderColor;
  final double? width;
  final double? height;
  final double? horizontal;
  final bool isLoading;
  final bool isDisabled;
  const ButtonWidget({
    super.key,
    this.lable,
    required this.onTap,
    this.buttonColor,
    this.lableColor,
    this.borderColor,
    this.width,
    this.height,
    this.horizontal,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          height: height?.h ?? 48.h,
          alignment: Alignment.center,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: isDisabled
                ? AppColors.greyColor
                : (buttonColor ??
                      (context.isDark
                          ? AppColors.lightGreyColor
                          : AppColors.blackColor)),
            border: Border.all(
              color: isDisabled
                  ? AppColors.greyColor
                  : (borderColor ??
                        (context.isDark
                            ? AppColors.lightGreyColor
                            : AppColors.blackColor)),
            ),
          ),
          child: isLoading
              ? ThreeDotLoader().padVertical(vertical: 8.h)
              : Text(
                  lable ?? l10(AppLocale.submit),
                  style: context.textTheme.titleMedium!.copyWith(
                    color:
                        lableColor ??
                        (context.isDark
                            ? AppColors.blackColor
                            : AppColors.whiteColor),
                  ),
                ).padHorizontal(horizontal: 20.w).padVertical(vertical: 8.h),
        )
        .onTap(isDisabled ? () {} : onTap)
        .padHorizontal(horizontal: horizontal ?? 20.w);
  }
}
