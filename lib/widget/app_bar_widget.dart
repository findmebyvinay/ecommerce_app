import 'package:ecom_app/core/constants/app_assets.dart';
import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({
    super.key,
    this.showBackButton = false,
    this.appbarHeight = 50,
    this.backButttonPress,
    this.backgroundColor,
    this.customLeadingWidget,
    this.isCenterTitle = true,
    this.customTitleWidget,
    this.title,
    this.action = const [],
    this.isBotton = false,
  });
  final Color? backgroundColor;
  final double appbarHeight;
  final Widget? customLeadingWidget;
  final Widget? customTitleWidget;
  bool showBackButton;
  final String? title;
  final List<Widget> action;
  bool isCenterTitle;
  VoidCallback? backButttonPress;
  final bool isBotton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundColor ??
          (context.isDark ? AppColors.blackColor : AppColors.whiteColor),
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? Image.asset(
                  AppAssets.backImage,
                  color: context.isDark
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                )
                .onTap(() => getIt<NavigationService>().pop())
                .padHorizontal(horizontal: 16.w)
          : customLeadingWidget,
      elevation: 1,
      surfaceTintColor: context.isDark
          ? AppColors.blackColor
          : AppColors.whiteColor,
      shadowColor: context.isDark
          ? AppColors.lightGreyColor
          : AppColors.lightGreyColor,
      title:
          customTitleWidget ??
          Text(
            title ?? '',
            style: context.textTheme.headlineMedium!.copyWith(
              color: context.isDark
                  ? AppColors.whiteColor
                  : AppColors.whiteColor,
            ),
          ),
      actions: [if (action.isNotEmpty) ...action, 10.horizontalSpace],
      centerTitle: customTitleWidget != null ? isCenterTitle : isCenterTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight.h);
}
