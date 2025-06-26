import 'package:ecom_app/features/cart_page/domain/model/cart_item_model.dart';

sealed class  CartEvent {

}

final class AddToCartEvent extends CartEvent{
  final CartItemModel cartItems;
  AddToCartEvent({required this.cartItems});
}

final class RemoveCartEvent extends CartEvent{
  final String productId;
RemoveCartEvent({required this.productId});
}

final class UpdateCartItemEvent extends CartEvent{
  final String  productId;
  final int quantity;
  UpdateCartItemEvent({required this.productId,required this.quantity});
}
final class ClearCartEvent extends CartEvent{

}

final class LoadCartEvent extends CartEvent{

}