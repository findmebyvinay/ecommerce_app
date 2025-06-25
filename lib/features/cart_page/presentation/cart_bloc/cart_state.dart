
import 'package:ecom_app/core/common/abs_normal_state.dart';
import 'package:ecom_app/features/cart_page/domain/model/cart_item_model.dart';
import 'package:equatable/equatable.dart';

sealed class CartState extends Equatable{
  final AbsNormalState<List<CartItemModel>> cartState;
  

 const CartState({required this.cartState});

 CartState copyWith({AbsNormalState<List<CartItemModel>> ? cartState}){
   return CartStateImpl(cartState: cartState ?? this.cartState);
 }

 @override
 List<Object?> get props=>[cartState];

 double get totalAmount{
  return cartState.data!.fold(0,(sum,items)=> sum+ items.totalPrice);
 }
 int  get totalItemCount{
return cartState.data!.fold(0, (sum,items)=> sum+ items.quantity);
 }
}

final class CartStateImpl extends CartState{
 const CartStateImpl({required super.cartState});

 @override
 CartState copyWith({AbsNormalState<List<CartItemModel>>? cartState}){
  return CartStateImpl(cartState: cartState ?? this.cartState);
 }
 @override
 List<Object?> get props=> [cartState];
}

final class CartStateInitial extends CartState{
  CartStateInitial():super(cartState: AbsNormalInitialState<List<CartItemModel>>());
}