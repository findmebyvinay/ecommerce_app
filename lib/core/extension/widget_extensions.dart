import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/constants/defalut_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension WidgetExtension on Widget {
  Center center() => Center(child: this);

  GestureDetector onTap(
    GestureTapCallback callback, {
    VoidCallback? onLongPress,
  }) => GestureDetector(onTap: callback, onLongPress: onLongPress, child: this);

  Padding padLeft({double? left}) => Padding(
    padding: EdgeInsets.only(left: left ?? kDefault20HorizontalSpace),
    child: this,
  );

  Padding padRight({double? right}) => Padding(
    padding: EdgeInsets.only(right: right ?? kDefault20HorizontalSpace),
    child: this,
  );

  Padding padTop({double? top}) => Padding(
    padding: EdgeInsets.only(top: top ?? kDefault20VerticalSpace),
    child: this,
  );

  Padding padBottom({double? bottom}) => Padding(
    padding: EdgeInsets.only(bottom: bottom ?? kDefault20VerticalSpace),
    child: this,
  );

  Padding padAll({double? value}) => Padding(
    padding: EdgeInsets.all(value ?? kDefault10HorizontalSpace),
    child: this,
  );

  Padding padZero() => Padding(padding: EdgeInsets.zero, child: this);

  Padding padHorizontal({double? horizontal}) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontal ?? kDefault20HorizontalSpace,
    ),
    child: this,
  );

  Padding padVertical({double? vertical}) => Padding(
    padding: EdgeInsets.symmetric(
      vertical: vertical ?? kDefault20VerticalSpace,
    ),
    child: this,
  );

  SizedBox get defaultVerticalSpace => SizedBox(height: 10.h);

  SizedBox get defaultHorizontalSpace => SizedBox(width: 10.w);

  /// set visibility
  Widget visible(bool visible, {Widget? defaultWidget}) {
    return visible ? this : (defaultWidget ?? const SizedBox());
  }

  Container lightGreyBackground({required BuildContext context}) => Container(
    decoration: BoxDecoration(color: AppColors.lightGreyColor),
    padding: EdgeInsets.zero,
    margin: EdgeInsets.zero,
    child: this,
  );
}
