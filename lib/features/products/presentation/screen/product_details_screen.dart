import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:ecom_app/features/products/domain/model/product_model.dart';
import 'package:ecom_app/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatelessWidget {
    final ProductModel product;
   const ProductDetailsScreen({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: (){
            getIt<NavigationService>().goBack();
          },
          icon: Icon(Icons.arrow_back_ios),color: AppColors.whiteColor,),
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
                  product.thumbnail != null
                      ? Image.network(
                          product.thumbnail!,
                          height: 300.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.image_not_supported,
                            size: 100,
                          ),
                        )
                      : const Icon(
                          Icons.image_not_supported,
                          size: 100,
                        ),
                  // Product Details
                  Divider(
                    thickness: 2,
                    color: AppColors.darkGreyColor,
                  ),
                  Text(
                    product.title ?? 'No Title',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).padHorizontal(horizontal: 16.w).padVertical(vertical: 10.h),
                  // Product Price
                  Text(
                    'Rs ${product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ).padHorizontal(horizontal: 16.w),
                  // Product Rating and Minimum Order
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: AppColors.lightGreen,
                      ),
                      Text(
                        '${product.rating} (${product.minimumOrderQuantity})',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ).padHorizontal(horizontal: 16.w).padVertical(vertical: 5.h),
                  Divider(
                    thickness: 1,
                    color: AppColors.darkGreyColor,
                  ),
                  // Product Category
                  Text(
                    'Category: ${product.category ?? 'Not Categorized'}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ).padHorizontal(horizontal: 16.w).padVertical(vertical: 5.h),
                  // Product Description (if available in ProductModel)
                  if (product.description != null)
                    Text(
                      product.description!,
                      style: context.textTheme.bodyMedium,
                    ).padHorizontal(horizontal: 16.w).padVertical(vertical: 10.h),
                ],
              ),
            ),
          ),
          ButtonWidget(
            lable: 'Add To Cart',
            height: 50,
            width: 150,
            buttonColor: AppColors.primaryColor,
            onTap: (){
                showModalBottomSheet(
                  context: context,
                   builder: (BuildContext context){
                    return Container(
                      height: 600,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12),)
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
                                    color: AppColors.greyColor
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[300]),
                                height: 200,
                                width: 200,
                                 child: product.thumbnail != null
                                                       ? Image.network(
                                                           product.thumbnail!,
                                                           height: 200,
                                                           width: 200,
                                                           fit: BoxFit.cover,
                                                           errorBuilder: (context, error, stackTrace) => const Icon(
                                                             Icons.image_not_supported,
                                                             size: 40,
                                                           ),
                                                         )
                                                       : const Icon(
                                                           Icons.image_not_supported,
                                                           size: 40,
                                                         ),
                               ),
                        const SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                                    'Rs ${product.price?.toStringAsFixed(2) ?? '0.00'}',
                                style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 25
                                            ),
                                        
                                          ),
                      )
                            ],
                          ).padAll(value: 10),
                          Divider(
                            thickness: 0.5,
                            color: AppColors.greyColor,
                          ).padBottom(
                            bottom: 20.h
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text('Quantity',style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.minimize,size: 25,)),
                                Text('0'),
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.add,size: 25,))
                            ],
                          ).padHorizontal(horizontal: 10.w)

                        ],
                      ),
                    );
                   });
            }).padBottom(bottom: 20.h)
        ],
      ),
    );
  }
}