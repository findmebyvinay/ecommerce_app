

import 'dart:developer';

import 'package:ecom_app/core/common/abs_normal_view.dart';
import 'package:ecom_app/core/extension/widget_extensions.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/features/products/domain/model/product_model.dart';
import 'package:ecom_app/features/products/presentation/product_bloc/product_bloc.dart';
import 'package:ecom_app/features/products/presentation/product_bloc/product_event.dart';
import 'package:ecom_app/features/products/presentation/product_bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              : ListView.builder(
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   mainAxisSpacing: 10,
                //   crossAxisSpacing: 5,
                //   crossAxisCount: 2),
               physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              shrinkWrap: true,
            itemCount: state.productState.data!.length,
            itemBuilder:(context,index){
              final product= state.productState.data![index];
              // log('Product at index $index:${product.title}, Price:${product.price}');
                return Card(
                  color: Colors.green[200],
                  elevation: 3,
                  child: ListTile(
                    leading:state.productState.data?[index].thumbnail!=null?
                    Image.network(
                      '${product.thumbnail}',
                      width: 50,
                      height: 50,
                    ):Icon(Icons.image_not_supported),
                    title: Text(state.productState.data?[index].title ?? 'no title'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price:Rs${product.price?.toStringAsFixed(2)?? '0.00'}'),
                        Text('Category:${product.category ?? 'not categorized'}'),
          
                      ],
                    ),
                  ),
                );
            }).padAll(value: 10),
        );
      }),
    );
  }
}