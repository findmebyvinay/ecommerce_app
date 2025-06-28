import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/routes/routes_name.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:ecom_app/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEmptyCart extends StatefulWidget {
  const CustomEmptyCart({super.key});

  @override
  State<CustomEmptyCart> createState() => _CustomEmptyCartState();
}

class _CustomEmptyCartState extends State<CustomEmptyCart> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100.w,
            color: AppColors.primaryColor,
          ),
          20.verticalSpace,
          Text(
            'Your cart is empty',
            style: context.textTheme.headlineSmall?.copyWith(
              color: AppColors.greyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          10.verticalSpace,
          Text(
            'Add some products to get started',
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.greyColor,
            ),
          ),
          30.verticalSpace,
          ButtonWidget(
            lable: 'Continue Shopping',
            buttonColor: AppColors.primaryColor,
            height: 50.h,
            width: 200.w,
            onTap: () {
              getIt<NavigationService>().navigateTo(RoutesName.dashboardScreen);
            },
          ),
        ],
      ),
    );
  }
}