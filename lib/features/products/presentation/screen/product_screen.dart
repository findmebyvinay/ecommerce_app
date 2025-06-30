import 'package:ecom_app/core/common/abs_normal_view.dart';
import 'package:ecom_app/core/constants/app_colors.dart';
import 'package:ecom_app/core/extension/build_context_extension.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/routes/routes_name.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/navigation_service.dart';
import 'package:ecom_app/core/utils/decore_utils.dart';
import 'package:ecom_app/features/products/domain/model/product_model.dart';
import 'package:ecom_app/features/products/presentation/product_bloc/product_bloc.dart';
import 'package:ecom_app/features/products/presentation/product_bloc/product_event.dart';
import 'package:ecom_app/features/products/presentation/product_bloc/product_state.dart';
import 'package:ecom_app/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductModel? productModel;
  @override
  void initState() {
    getIt<ProductBloc>().add(GetProductEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        backgroundColor: AppColors.bgColor,
        customTitleWidget:  Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40.h,
            child: TextFormField(
              decoration: inputDecoration(
                context: context,
                hintText: 'Search',
                suffixIcon: Icon(Icons.search, size: 18.w),
                borderRadius: 50.r,
              ),
              onChanged: (query){
                context.read<ProductBloc>().add(SearchProductEvent(query));
              },
            ),
          ),
        ),
      ],
    ),),
    backgroundColor:AppColors.bgColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          // log('ProductState: ${state.productState.absNormalStatus}, Data length: ${state.productState.data?.length ?? 0}');
          return AbsNormalView<List<ProductModel>>(
            absNormalStatus: state.productState.absNormalStatus,
            data: state.productState.data,
            isToRefresh: true,
            onRetry: () {
              getIt<ProductBloc>().add(GetProductEvent(isToRefresh: true));
            },
            child:
                // state.productState.data == null ||
                //     state.productState.data!.isEmpty
                // ? const Center(child: Text('No products available')):
                 LayoutBuilder(
                   builder: (BuildContext context, BoxConstraints constraints) {  
                   return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                        crossAxisCount: 2,
                      ),
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      shrinkWrap: true,
                      itemCount: state.productState.data?.length,
                      itemBuilder: (context, index) {
                        final product = state.productState.data![index];
                        // log('Product at index $index:${product.title}, Price:${product.price}');
                        return GestureDetector(
                          onTap: () {
                            getIt<NavigationService>().navigateTo(
                              RoutesName.productDetail,
                              arguments: product,
                            );
                          },
                          child: Card(
                            color:AppColors.whiteColor,
                            elevation: 8,
                            child: Column(
                              children: [
                                // Image.network('${productModel?.thumbnail}',scale: 4,),
                                state.productState.data?[index].thumbnail == null
                                    ?
                                    Icon(Icons.image_not_supported) 
                                    : 
                                    Image.network(
                                        '${product.thumbnail}',
                                        scale: 4,
                                        loadingBuilder: (context,child,loadingProgress){
                                          if(loadingProgress ==null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes !=null? loadingProgress.cumulativeBytesLoaded/(loadingProgress.expectedTotalBytes ?? 1):null,
                                            ),
                                          );
                                        },
                                         errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.image_not_supported,
                                        size: 40,
                                      ),
                                      ),
                                const SizedBox(height: 10),
                                Text(
                                  state.productState.data?[index].title ??
                                      'no title',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ).padBottom(bottom: 5.h),
                   
                                Flexible(
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.bgColor,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Rs ${product.price?.toStringAsFixed(2) ?? '0.00'} ',
                                              style: context.textTheme.bodyMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.primaryColor,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                            ),
                                          ],
                                        ).padHorizontal(horizontal: 10.w),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Icon(
                                                Icons.star,
                                                size: 16,
                                                color: AppColors.warningColor,
                                              ),
                                            ),
                                            Text(
                                              '${product.rating}(${product.minimumOrderQuantity})',
                                              style: context.textTheme.bodySmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w300,
                                                    color: AppColors.primaryColor,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                            ),
                                          ],
                                        ).padHorizontal(horizontal: 10.w),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                   
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
                          ),
                        );
                      },
                    ).padAll(value: 10);
          } ),
          );
        },
      ),
    );
  }
}
