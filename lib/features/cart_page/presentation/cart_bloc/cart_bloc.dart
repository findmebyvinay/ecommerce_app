import 'dart:developer';
import 'package:ecom_app/core/constants/enum.dart';
import 'package:ecom_app/core/services/local_database/local_database_mixin.dart';
import 'package:ecom_app/features/cart_page/domain/model/cart_item_model.dart';
import 'package:ecom_app/features/cart_page/presentation/cart_bloc/cart_event.dart';
import 'package:ecom_app/features/cart_page/presentation/cart_bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent,CartState> with LocalDatabaseOperationsMixin{
  CartBloc():super(CartStateInitial()){
    on<CartEvent>((event, emit) {},);
    on<AddToCartEvent> (_onAddToCart);
    on<RemoveCartEvent> (_onRemoveCart);
    on<UpdateCartItemEvent> (_onUpdateCart);
    on<ClearCartEvent> (_onClearCart);
    on<LoadCartEvent>(_onLoadCart);
  }

  void _onAddToCart(AddToCartEvent event,Emitter<CartState> emit)async{
    if(event.cartItems.stock> event.cartItems.stock){
          emit(state.copyWith(
            cartState: state.cartState.copyWith(
              absNormalStatus: AbsNormalStatus.ERROR
            )
          ));
      }

    final currentItems= List<CartItemModel>.from(state.cartState.data ?? []);
    final existingItemIndex = currentItems.indexWhere(
      (item)=> item.id== event.cartItems.id,
    );
    final existingQuantity = existingItemIndex!=-1? currentItems[existingItemIndex].quantity:0;
    final  totalQauntity= existingQuantity + event.cartItems.quantity;
    if(totalQauntity>event.cartItems.stock){
      emit(state.copyWith(
        cartState: state.cartState.copyWith(
          absNormalStatus: AbsNormalStatus.ERROR
        )
      ));
      return;
    }
    if(existingItemIndex !=-1){
      currentItems[existingItemIndex]= currentItems[existingItemIndex].copyWith(
        // quantity: currentItems[existingItemIndex].quantity + event.cartItems.quantity
        quantity: totalQauntity,
        stock: event.cartItems.stock,
      );
      await updateCartItem(event.cartItems);
      }else{
        currentItems.add(event.cartItems);
        insertCartItem(event.cartItems);
        log('${currentItems.first}');
        
      }
     emit(state.copyWith(
      cartState: state.cartState.copyWith(
        data: currentItems,
        absNormalStatus: AbsNormalStatus.SUCCESS
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
          final updatedItems= currentItems.where((item)=> item.id!= event.productId).toList();
          emit(state.copyWith(
            cartState: state.cartState.copyWith(
              data: updatedItems,
              absNormalStatus: AbsNormalStatus.SUCCESS
            )
          ));
          deleteCartItems(event.productId);
        log('Removed the items: $updatedItems');
      }

      void _onUpdateCart(UpdateCartItemEvent event,Emitter<CartState> emit)async{
        final currentItems = List<CartItemModel>.from(state.cartState.data ?? []);
        final item= currentItems.firstWhere(
          (item)=> item.id == event.productId,
          orElse:()=> CartItemModel(id: '', title: '', thumbnail: '', price: 0, quantity: 0,stock: 0)
        );
        if(item.id.isEmpty){
          emit(state.copyWith(
            cartState: state.cartState.copyWith(
              absNormalStatus: AbsNormalStatus.ERROR
            )
          ));
        }
        if(!currentItems.any((items)=> items.id==event.productId)){
            emit(state.copyWith(
              cartState:state.cartState.copyWith(
                absNormalStatus:  AbsNormalStatus.ERROR
              )
            ));
            return;
        }

        if(event.quantity<=0){
          final updatedItems =currentItems.where((items)=> items.id != event.productId).toList();
          emit(state.copyWith(
              cartState: state.cartState.copyWith(
                data: updatedItems,
                absNormalStatus: AbsNormalStatus.SUCCESS
              )
          ));
          return;
        }

        final updatedItems= currentItems.map((items){
          if(items.id== event.productId){
            return items.copyWith(
              quantity: event.quantity
            );
          }
          return items;
        }).toList();
        // final updatedItem= updatedItems.firstWhere((items)=> items.id== event.productId);
        emit(state.copyWith(
          cartState: state.cartState.copyWith(
            data: updatedItems,
            absNormalStatus: AbsNormalStatus.SUCCESS
          )
        ));
        final updatedItem= updatedItems.where((i)=> i.id ==event.productId);
        updateCartItem(updatedItem.first);
      }
    
    void _onClearCart(ClearCartEvent event,Emitter<CartState> emit)async{
      clearCart();
      emit(state.copyWith(
        cartState: state.cartState.copyWith(
          data: List.empty(),
          absNormalStatus: AbsNormalStatus.SUCCESS
        )
      ));
    }
    
    void _onLoadCart(LoadCartEvent event,Emitter<CartState> emit)async{
      try{
            final loadItems = await getCartItems();
            emit(state.copyWith(
              cartState: state.cartState.copyWith(
                data: loadItems,
                absNormalStatus: AbsNormalStatus.SUCCESS
              )
            ));
            log('Successfully fecthed cart items from database');
      }
      catch(e){
        log('Failed to Load cart Item from Database:$e');
        rethrow;
      }
    }
    }