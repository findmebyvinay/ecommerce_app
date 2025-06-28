import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:ecom_app/features/cart_page/domain/model/cart_item_model.dart';
import 'package:ecom_app/features/cart_page/presentation/cart_bloc/cart_bloc.dart';
import 'package:ecom_app/features/cart_page/presentation/cart_bloc/cart_event.dart';
import 'package:ecom_app/features/products/domain/model/product_model.dart';
import 'package:ecom_app/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int num = 1;
  void increment() {
    if (widget.product.stock != null && num >= widget.product.stock!) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Max Quantity reached',
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          backgroundColor: AppColors.warningColor,
          elevation: 4,
          dismissDirection: DismissDirection.up,
        ),
      );
    }
    setState(() {
      num++;
    });
  }

  void decrement() {
    setState(() {
      num > 1 ? num-- : num = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            getIt<NavigationService>().goBack();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: AppColors.whiteColor,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  widget.product.thumbnail != null
                      ? Image.network(
                          widget.product.thumbnail!,
                          height: 300.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, size: 100),
                        )
                      : const Icon(Icons.image_not_supported, size: 100),
                  // Product Details
                  Divider(thickness: 2, color: AppColors.darkGreyColor),
                  Text(
                    widget.product.title ?? 'No Title',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).padHorizontal(horizontal: 16.w).padVertical(vertical: 10.h),
                  // Product Price
                  Text(
                    'Rs ${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ).padHorizontal(horizontal: 16.w),
                  // Product Rating and Minimum Order
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: AppColors.warningColor),
                      Text(
                        '${widget.product.rating} (${widget.product.minimumOrderQuantity})',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ).padHorizontal(horizontal: 16.w).padVertical(vertical: 5.h),
                  Divider(thickness: 1, color: AppColors.darkGreyColor),
                  // Product Category
                  Text(
                    'Category: ${widget.product.category ?? 'Not Categorized'}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).padHorizontal(horizontal: 16.w).padVertical(vertical: 5.h),
                  // Product Description (if available in ProductModel)
                  if (widget.product.description != null)
                    Text(
                          widget.product.description!,
                          style: context.textTheme.bodyMedium,
                        )
                        .padHorizontal(horizontal: 16.w)
                        .padVertical(vertical: 10.h),
                Text('${widget.product.shippingInformation}',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold
                  ),).padHorizontal(horizontal: 16)
                ],
              ),
            ),
          ),
          ButtonWidget(
            lable: 'Add To Cart',
            height: 50,
            width: 150,
            buttonColor: AppColors.primaryColor,
            onTap: () {
              showModelsheet(context);
              // CustomBottomSheet(product:ProductModel());
            },
          ).padBottom(bottom: 20.h),
        ],
      ),
    );
  }

  Future<dynamic> showModelsheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: AppColors.bgColor,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: AppColors.greyColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.whiteColor,
                        ),
                        height: 200.h,
                        width: 200.w,
                        child: widget.product.thumbnail != null
                            ? Image.network(
                                widget.product.thumbnail!,
                                height: 100.h,
                                width: 100.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.image_not_supported,
                                      size: 40,
                                    ),
                              )
                            : const Icon(Icons.image_not_supported, size: 40),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          'Rs ${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ).padAll(value: 10),
                  Divider(
                    thickness: 0.5,
                    color: AppColors.greyColor,
                  ).padBottom(bottom: 20.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Quantity',
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Text('Remaining: ${widget.product.stock}',style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      GestureDetector(
                        onTap: () {
                          setModalState(() {
                            decrement();
                          });
                        },
                        child: Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 16,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Text(
                        '$num',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      10.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          if (widget.product.stock != null &&
                              num == widget.product.stock!) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Max Quantity reached',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                backgroundColor: AppColors.warningColor,
                                elevation: 4,
                                dismissDirection: DismissDirection.up,
                              ),
                            );
                            return;
                          }
                          setModalState(increment);
                        },
                        child: Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 16,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                    ],
                  ).padHorizontal(horizontal: 10.w),
                  20.verticalSpace,
                  Flexible(
                    child: ButtonWidget(
                      lable: 'Add to Cart',
                      buttonColor: AppColors.primaryColor,
                      height: 50,
                      width: double.infinity,
                      onTap: () {
                        final cartItem = CartItemModel(
                          id: widget.product.id.toString(),
                          title: widget.product.title.toString(),
                          thumbnail: widget.product.thumbnail.toString(),
                          price: widget.product.price!.toDouble(),
                          quantity: num,
                          stock: widget.product.stock!
                        );

                        context.read<CartBloc>().add(
                          AddToCartEvent(cartItems: cartItem),
                        );
                        getIt<NavigationService>().pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.bgColor,
                            content: Text(
                              'Successully added the product in Cart',
                            ),
                          ),
                        );
                        setModalState(() {
                          num = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
