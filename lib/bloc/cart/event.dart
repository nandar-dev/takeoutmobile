abstract class CartEvent {}

class LoadCart extends CartEvent {}

class CalculateTotalPrice extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final Map<String, dynamic> item;

  AddToCartEvent(this.item);
}

class UpdateItemQuantity extends CartEvent {
  final int productId;
  final int quantity;

  UpdateItemQuantity(this.productId, this.quantity);
}

class RemoveCartItem extends CartEvent {
  final int productId;

  RemoveCartItem(this.productId);
}

class ClearCart extends CartEvent {}

class GetCartItemById extends CartEvent {
  final int productId;

  GetCartItemById(this.productId);
}