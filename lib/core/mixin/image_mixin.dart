import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:ecom_app/core/constants/app_assets.dart';
import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/constants/enum.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:ecom_app/core/services/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

mixin ImageMixin {
  Future<File?> _pickImageFromGallery() async {
    final completer = Completer<File?>();
    PermissionService.requestPermission(
      permissionFor: PermissionFor.gallery,
      onGrantedCallback: () async {
        try {
          final picker = ImagePicker();
          final image = await picker.pickImage(source: ImageSource.gallery);

          if (image != null) {
            final file = File(image.path);
            completer.complete(file);
          } else {
            completer.complete(null); // User cancelled
          }
        } catch (e) {
          log(" Error :: $e");
          completer.complete(null);
        }
      },
      onDeniedCallback: () => completer.complete(null),
      onOthersDeniedCallback: (_) => completer.complete(null),
    );

    return completer.future;
  }

  Future<File?> _pickImageFromCamera() async {
    final completer = Completer<File?>();

    PermissionService.requestPermission(
      permissionFor: PermissionFor.camera,
      onGrantedCallback: () async {
        try {
          final picker = ImagePicker();
          final image = await picker.pickImage(source: ImageSource.camera);

          if (image != null) {
            final file = File(image.path);
            completer.complete(file);
          } else {
            completer.complete(null); // User canceled
          }
        } catch (e) {
          log(" Error :: $e");
          completer.complete(null);
        }
      },
      onDeniedCallback: () => completer.complete(null),
      onOthersDeniedCallback: (_) => completer.complete(null),
    );

    return completer.future;
  }

  Future<void> bottomSheet(
    BuildContext context, {
    required Function(File? file) callBack,
  }) async {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 5.h,
              width: 0.4.sw,
              decoration: BoxDecoration(
                color: context.isDark
                    ? AppColors.lightGreyColor
                    : AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ).padBottom(bottom: 10.h),
            Text(
              "Choose Image From",
              style: context.textTheme.titleLarge,
            ).padBottom(bottom: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _view(ctx, image: AppAssets.gallery, lable: 'Gallery').onTap(
                  () async {
                    final file = await _pickImageFromGallery();
                    getIt<NavigationService>().pop(); // Dismiss bottom sheet
                    callBack(file);
                  },
                ),
                _view(ctx, image: AppAssets.camera, lable: 'Camera').onTap(
                  () async {
                    final file = await _pickImageFromCamera();
                    getIt<NavigationService>().pop(); // Dismiss bottom sheet
                    callBack(file);
                  },
                ),
              ],
            ).padBottom(bottom: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _view(
    BuildContext context, {
    required String image,
    required String lable,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          image,
          color: context.isDark ? AppColors.whiteColor : null,
          height: 0.05.sh,
        ).padBottom(bottom: 10.h),
        Text(lable, style: context.textTheme.bodyLarge).padBottom(bottom: 10.h),
      ],
    );
  }
}
