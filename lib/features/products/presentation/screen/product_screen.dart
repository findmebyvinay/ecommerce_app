

import 'package:ecom_app/core/common/abs_normal_view.dart';
import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/features/products/domain/model/product_model.dart';
import 'package:ecom_app/features/products/presentation/product_bloc/product_bloc.dart';
import 'package:ecom_app/features/products/presentation/product_bloc/product_event.dart';
import 'package:ecom_app/features/products/presentation/product_bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    getIt<ProductBloc>().add(GetProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc,ProductState>
      (builder: (context,state){
        // log('ProductState: ${state.productState.absNormalStatus}, Data length: ${state.productState.data?.length ?? 0}');
        return AbsNormalView<List<ProductModel>>(
          absNormalStatus: state.productState.absNormalStatus,
          data: state.productState.data,
          isToRefresh: true,
            onRetry: () {
              getIt<ProductBloc>().add(
                GetProductEvent(isToRefresh: true),
              );
            },
          child:state.productState.data == null ||
                  state.productState.data!.isEmpty? const Center(child: Text('No products available'))
              : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2),
               physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              shrinkWrap: true,
            itemCount: state.productState.data!.length,
            itemBuilder:(context,index){
              final product= state.productState.data![index];
              // log('Product at index $index:${product.title}, Price:${product.price}');
                return Card(
                  color: Colors.grey[100],
                  elevation: 3,
                  child:Column(
                    children: [
                      state.productState.data?[index].thumbnail!=null?
                      Image.network('${product.thumbnail}',scale: 4,):Icon(Icons.image_not_supported),
                      const SizedBox(
                        height: 10,
                      ),
                       Text(state.productState.data?[index].title ?? 'no title',
                       style: context.textTheme.bodyMedium?.copyWith(
                        overflow: TextOverflow.ellipsis
                       ),).padBottom(
                        bottom: 5.h
                       ),

                      Flexible(
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white
                          ),
                          child:  Column(
                            children: [
                              Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                   Text('Rs ${product.price?.toStringAsFixed(2)?? '0.00'} ',
                                     style: context.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                              overflow: TextOverflow.ellipsis
                                                       ),),   
                              ],
                                                       ).padHorizontal(horizontal: 10.w),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    Icon(Icons.star,size: 16,
                                    color: AppColors.lightGreen,
                                    ),
                                    Text('${product.rating}(${product.minimumOrderQuantity})',
                                       style: context.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w300,
                              color: AppColors.primaryColor,
                              overflow: TextOverflow.ellipsis
                                                       ),)

                              ],
                            ).padHorizontal(horizontal: 10.w)                                                       
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                  
                  
                  //  ListTile(
                  //   leading:state.productState.data?[index].thumbnail!=null?
                  //   Image.network(
                  //     '${product.thumbnail}',
                  //     width: 50,
                  //     height: 50,
                  //   ):Icon(Icons.image_not_supported),
                  //   title: Text(state.productState.data?[index].title ?? 'no title'),
                  //   subtitle: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text('Price:Rs${product.price?.toStringAsFixed(2)?? '0.00'}'),
                  //       Text('Category:${product.category ?? 'not categorized'}'),
          
                  //     ],
                  //   ),
                  // ),
                );
            }).padAll(value: 10),
        );
      }),
    );
  }
}