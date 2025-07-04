// cart_screen.dart
import 'dart:developer';

import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/routes/routes_name.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:ecom_app/features/cart_page/domain/model/cart_item_model.dart';
import 'package:ecom_app/features/cart_page/presentation/cart_bloc/cart_bloc.dart';
import 'package:ecom_app/features/cart_page/presentation/cart_bloc/cart_event.dart';
import 'package:ecom_app/features/cart_page/presentation/cart_bloc/cart_state.dart';
import 'package:ecom_app/features/cart_page/presentation/screen/widgets/custom_empty_cart.dart';
import 'package:ecom_app/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    context.read<CartBloc>().add(LoadCartEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text('Shopping Cart'),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            getIt<NavigationService>().navigateTo(RoutesName.dashboardScreen);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: AppColors.whiteColor,
        ),
     actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.cartState.data != null && state.cartState.data!.isNotEmpty) {
                return TextButton(
                  onPressed: () {
                    _showClearCartDialog(context);
                  },
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
        
          if (state.cartState.data==null) {
            return CustomEmptyCart();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: state.cartState.data!.length,
                  itemBuilder: (context, index) {
                    final cartItem = state.cartState.data?[index];
                    return _buildCartItemCard(context, cartItem!);
                  },
                ),
              ),
              _buildCartSummary(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItemCard(BuildContext context, CartItemModel cartItem) {
    return Card(
      color: AppColors.whiteColor,
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.greyColor.withValues(alpha: 0.3)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: cartItem.thumbnail.isNotEmpty
                    ? Image.network(
                        cartItem.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported, size: 30),
                      )
                    : Icon(Icons.image_not_supported, size: 30),
              ),
            ),
            12.horizontalSpace,
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.verticalSpace,
                  if (cartItem.category != null)
                    Text(
                      cartItem.category!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                  8.verticalSpace,
                  Text(
                    'Rs ${cartItem.price.toStringAsFixed(2)}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Quantity Controls and Actions
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Remove button
                GestureDetector(
                  onTap: () {
                    context.read<CartBloc>().add(
                          RemoveCartEvent(productId: cartItem.id)
                        );
                        log('Delete button tapped');
                        log(cartItem.id);
                        log('${cartItem.quantity}');
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
                10.verticalSpace,
                // Quantity controls
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        final newQuantity = cartItem.quantity - 1;
                        if (newQuantity > 0) {
                          context.read<CartBloc>().add(
                                UpdateCartItemEvent(productId: cartItem.id, quantity: cartItem.quantity-1),
                              );

                        } 
                        // else {
                        //   context.read<CartBloc>().add(
                        //         RemoveCartEvent(productId: cartItem.id,)
                        //       );
                        // }
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
                    Container(
                      width: 40.w,
                      height: 30.h,
                      alignment: Alignment.center,
                      child: Text(
                        '${cartItem.quantity}',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                        if( cartItem.quantity == cartItem.stock || cartItem.quantity>cartItem.stock){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Max quantity reached',
                          style: context.textTheme.bodyMedium,),backgroundColor: AppColors.warningColor,));
                          log('Quanity is more than stock');
                        }
                        else{
                          context.read<CartBloc>().add(
                             UpdateCartItemEvent(productId: cartItem.id, quantity: cartItem.quantity+1)
                            );
                            log(cartItem.id);
                            
                        }
                      },
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.primaryColor,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
                // Total price for this item
                Text(
                  'Rs ${cartItem.totalPrice.toStringAsFixed(2)}',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, CartState state) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Items: ${state.totalItemCount}',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Rs ${state.totalAmount.toStringAsFixed(2)}',
                style: context.textTheme.headlineSmall?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          ButtonWidget(
            lable: 'Proceed to Checkout',
            buttonColor: AppColors.primaryColor,
            height: 50,
            width: double.infinity,
            onTap: () {
              // // _showCheckoutDialog(context);
              // Esewa esewa = Esewa(
              //   productId: '1',
              //   totalQauntity: state.totalItemCount.toString(),
              //   productPrice: state.totalAmount.toString(),
              // );    
              // esewa.pay();
               showDialog(
      context: context,
       builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: AppColors.bgColor,
            title: Text('Payment Success',
            textAlign: TextAlign.center,
            style: context.textTheme.displayMedium?..copyWith(
              fontWeight: FontWeight.bold
            ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Your Order has been Successfully placed!'),
                10.verticalSpace,
                Text('PRODUCT DETAILS:',
                 style: context.textTheme.bodyLarge?..copyWith(
              fontWeight: FontWeight.bold
            ),),
                10.verticalSpace,
                Text('Product Id: 1'),
                10.verticalSpace,
                Text('Total Product item:10'),
                10.verticalSpace,
                Text('Total Amount for the product: Rs.1000')
              ],
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.whiteColor)
                ),
                onPressed: (){
                  getIt<NavigationService>().pop();
                }, child: Text('Go Back',
              style:context.textTheme.bodyMedium?.copyWith(
                color: Colors.redAccent,

              ),
              ))
            ],
          );
       });
           

            },
          ),
        ],
      ).padAll(value: 16.w),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.bgColor,
          title: Text('Clear Cart'),
          content: Text('Are you sure you want to remove all items from your cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.whiteColor)
              ),
              onPressed: () {
                context.read<CartBloc>().add(ClearCartEvent());
                //context.read<CartBloc>().add(RemoveCartEvent(productId: ))
                Navigator.of(context).pop();
              },
              child: Text(
                'Clear',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}