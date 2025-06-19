import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/utils/decore_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum PopupMode { dialog, modalBottomSheet, menu, bottomSheet }

class DropdownWidget<T> extends StatelessWidget {
  final PopupMode popupMode;
  final String? hintText, lable, index;
  final DropdownSearchOnFind<T>? items;
  final T? selectedItem;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool showSearchBox;
  final bool enable;
  const DropdownWidget({
    super.key,
    this.popupMode = PopupMode.menu,
    this.hintText,
    this.lable,
    this.index,
    required this.items,
    this.onChanged,
    this.validator,
    this.selectedItem,
    this.showSearchBox = true,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((index ?? '').isNotEmpty) ...{
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                (index ?? '').isNotEmpty ? "$index.  " : '',
                style: context.textTheme.titleMedium,
              ),
              Expanded(
                child: Text(lable ?? '', style: context.textTheme.titleMedium),
              ),
            ],
          ).padBottom(bottom: 10.h),
        } else if ((lable ?? '').isNotEmpty) ...{
          Text(
            lable ?? '',
            style: context.textTheme.titleMedium,
          ).padBottom(bottom: 10.h),
        },
        DropdownSearch<T>(
          enabled: enable,
          selectedItem: selectedItem,
          itemAsString: (item) => item.toString(),
          compareFn: (i1, i2) => i1 == i2,
          items: items,
          decoratorProps: DropDownDecoratorProps(
            decoration: inputDecoration(
              context: context,
              labelText: hintText ?? 'Select item',
              hintText: hintText ?? 'Select item',
            ),
          ),
          onChanged: onChanged,
          validator: validator,
          popupProps: PopupProps.menu(
            showSearchBox: showSearchBox,
            showSelectedItems: true,
            searchFieldProps: TextFieldProps(
              decoration: inputDecoration(context: context, hintText: 'Search'),
            ),
            fit: FlexFit.loose,
            constraints: BoxConstraints(maxHeight: 0.5.sh),
          ),
        ),
      ],
    );
  }
}
