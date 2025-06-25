import 'package:ecom_app/core/constants/enum.dart';
import 'package:ecom_app/features/cart_page/domain/model/cart_item_model.dart';
import 'package:ecom_app/features/cart_page/presentation/cart_bloc/cart_event.dart';
import 'package:ecom_app/features/cart_page/presentation/cart_bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  CartBloc():super(CartStateInitial()){
    on<CartEvent>((event, emit) {},);
    on<AddToCartEvent> (_onAddToCart);
    on<RemoveCartEvent> (_onRemoveCart);
    on<ClearCartEvent> (_onClearCart);
  }

  void _onAddToCart(AddToCartEvent event,Emitter<CartState> emit)async{
    final currentItems= List<CartItemModel>.from(state.cartState.data ?? []);
    final existingItemIndex = currentItems.indexWhere(
      (item)=> item.id== event.cartItems.id,
    );

    if(existingItemIndex !=-1){
      currentItems[existingItemIndex]= currentItems[existingItemIndex].copyWith(
        quantity: currentItems[existingItemIndex].quantity + event.cartItems.quantity
      );
      
      }else{
        currentItems.add(event.cartItems);
      }
     emit(state.copyWith(
      cartState: state.cartState.copyWith(
        data: currentItems,
        absNormalStatus: AbsNormalStatus.SUCCESS,
      )
     ));
        }


    void _onRemoveCart(RemoveCartEvent event, Emitter<CartState> emit)async{
      final currentItems= List<CartItemModel>.from(state.cartState.data ?? []);
      if(!currentItems.any((item)=> item.id==event.productId)){
        emit(state.copyWith(
          cartState:state.cartState.copyWith(
            absNormalStatus: AbsNormalStatus.ERROR
          ) 
        ));
        return;
      }
      if(event.quantity!<=0){
        final updateItems= currentItems.map((item){
          if(item.id==event.productId){
            return  item.copyWith(
              quantity: event.quantity
            );
          }
          return item;
        }).toList();
        emit(state.copyWith(
          cartState: state.cartState.copyWith(
            data: updateItems,
            absNormalStatus: AbsNormalStatus.SUCCESS
          )
        ));
      }
    }
    void _onClearCart(ClearCartEvent event,Emitter<CartState> emit)async{
      emit(state.copyWith(
        cartState: state.cartState.copyWith(
          absNormalStatus: AbsNormalStatus.SUCCESS
        )
      ));
    }
}