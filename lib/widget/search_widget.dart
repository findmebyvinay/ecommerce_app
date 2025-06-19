import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:ecom_app/core/utils/decore_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
              Icons.arrow_back,
              color: context.isDark
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
            )
            .onTap(() => getIt<NavigationService>().goBack())
            .padRight(right: 10.w),
        Expanded(
          child: SizedBox(
            height: 40.h,
            child: TextFormField(
              controller: _searchCtr,
              decoration: inputDecoration(
                context: context,
                hintText: 'Search',
                suffixIcon: Icon(Icons.search, size: 18.w),
                borderRadius: 50.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
