import 'package:ecom_app/core/common/abs_normal_state.dart';
import 'package:ecom_app/features/products/domain/model/product_model.dart';
import 'package:equatable/equatable.dart';

sealed class ProductState extends Equatable {
  final AbsNormalState<List<ProductModel>> productState;
  const ProductState({required this.productState});

  ProductState copyWith({AbsNormalState<List<ProductModel>>? productState}){
    return ProductStateImpl(productState: productState ?? this.productState);
  }

  @override
  List<Object?> get props=>[productState];
}

final class ProductStateImpl extends ProductState{
 const ProductStateImpl({required super.productState});
 
 @override
 ProductState copyWith({AbsNormalState<List<ProductModel>>? productState}){
  return ProductStateImpl(productState: productState ?? this.productState); 
 }
 @override
 List<Object?> get props=>[productState];
}

final class ProductIntial extends ProductState{
  ProductIntial():super(
    productState:AbsNormalInitialState<List<ProductModel>>());
} 