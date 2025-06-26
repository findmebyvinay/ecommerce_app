import 'package:ecom_app/core/common/abs_normal_state.dart';
import 'package:ecom_app/features/products/domain/model/product_model.dart';
import 'package:equatable/equatable.dart';

sealed class ProductState extends Equatable {
  final AbsNormalState<List<ProductModel>> productState;
  final String searchQuery;
  const ProductState({required this.productState, this.searchQuery=''});

  ProductState copyWith({AbsNormalState<List<ProductModel>>? productState,searchQuery}){
    return ProductStateImpl(productState: productState ?? this.productState,searchQuery: searchQuery ?? this.searchQuery);
  }

  @override
  List<Object?> get props=>[productState,searchQuery];
}

final class ProductStateImpl extends ProductState{
 const ProductStateImpl({required super.productState, super.searchQuery});
 
 @override
 ProductState copyWith({AbsNormalState<List<ProductModel>>? productState,searchQuery}){
  return ProductStateImpl(productState: productState ?? this.productState,searchQuery:  searchQuery ?? this.searchQuery); 
 }
 @override
 List<Object?> get props=>[productState,searchQuery];
}

final class ProductIntial extends ProductState{
  ProductIntial():super(
    productState:AbsNormalInitialState<List<ProductModel>>());
} 