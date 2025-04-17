abstract class CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Map<String, dynamic>> items;

  CartLoaded(this.items);
}

class CartItemLoaded extends CartState {
  final Map<String, dynamic>? item;

  CartItemLoaded(this.item);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}