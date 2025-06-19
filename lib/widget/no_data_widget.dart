import 'package:ecom_app/core/constants/app_assets.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/mixin/localization_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NoDataWidget extends StatelessWidget {
  final double? height;
  final String? title;
  final String? subtitle;
  const NoDataWidget({super.key, this.height, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.noDataImage, height: height?.h ?? 250.h),
          Text(
            title ?? l10(AppLocale.noData),
            style: context.textTheme.titleLarge,
          ).padBottom(bottom: 10.h),
          Text(
            subtitle ?? l10(AppLocale.noData),
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ).padBottom(bottom: 10.h),
        ],
      ).padHorizontal(horizontal: 10.w),
    );
  }
}
