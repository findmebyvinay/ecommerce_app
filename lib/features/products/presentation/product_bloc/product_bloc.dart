import 'dart:developer';

import 'package:ecom_app/core/constants/enum.dart';
import 'package:ecom_app/core/constants/typedef.dart';
import 'package:ecom_app/core/services/get_it/service_locator.dart';
import 'package:ecom_app/core/services/local_database/local_database_mixin.dart';
import 'package:ecom_app/core/services/local_database/local_database_table.dart';
import 'package:ecom_app/features/products/domain/model/product_model.dart';
import 'package:ecom_app/features/products/domain/repo/product_repo.dart';
import 'package:ecom_app/features/products/presentation/product_bloc/product_event.dart';
import 'package:ecom_app/features/products/presentation/product_bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProductBloc extends Bloc<ProductEvent,ProductState> with LocalDatabaseOperationsMixin {
  ProductBloc():super(ProductIntial()){
    on<ProductEvent> ((event, emit) {
    },);
    on<GetProductEvent> (_onGetProductEvent);
  }

  void _onGetProductEvent(GetProductEvent event,Emitter<ProductState> emit)async{
      DynamicResponse response = await getIt<ProductRepo>().getProduct();
      response.fold(
        (l){
          List<ProductModel> productModel=[];
        //  log('reposne from API:$response');
         try{
             if(l!=null && l is Map && l.containsKey('data')&& l['data'] is Map&&
          l['data'].containsKey('products') &&
          l['data']['products'] is List){
              List productData= l['data']['products'];
              productModel= productData.map((e)=>
              ProductModel.fromJson(e)).toList();

              // log('All products details:${productData.length}');
              emit(state.copyWith(
                productState: state.productState.copyWith(
                  data: productModel,
                  absNormalStatus: AbsNormalStatus.SUCCESS,                  
                )
              ));

           if(productModel.isNotEmpty) {
            insertMultipleData(
              LocalDatabaseTable.products,
              productModel.map((e)=> e.toJson()).toList(),
            );
            log('Successfully saved inside database:${LocalDatabaseTable.products}');
           }  
          }
         }
         catch(e){
            log('Exception occure fetching data:$e');
            rethrow;
         }

        },

         (r){
          emit(state.copyWith(
            productState: state.productState.copyWith(
              absNormalStatus: AbsNormalStatus.ERROR,
              failure: r
            )
          ));
          log('Error occurred while fetching products from response.right:$r');
         });
  }
}