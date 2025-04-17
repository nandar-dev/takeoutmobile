import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';
import '../../services/cart_service.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService _cartService;

  CartBloc(this._cartService) : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<UpdateItemQuantity>(_onUpdateItemQuantity);
    on<RemoveCartItem>(_onRemoveCartItem);
    on<ClearCart>(_onClearCart);
    on<GetCartItemById>(_onGetCartItemById);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = await _cartService.getCartItems();
      emit(CartLoaded(items));
    } catch (_) {
      emit(CartError('Failed to load cart.'));
    }
  }

  Future<void> _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      await _cartService.addToCart(event.item);
      add(LoadCart());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onUpdateItemQuantity(UpdateItemQuantity event, Emitter<CartState> emit) async {
    try {
      await _cartService.setItemQuantity(event.productId, event.quantity);
      add(LoadCart());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveCartItem(RemoveCartItem event, Emitter<CartState> emit) async {
    await _cartService.removeItem(event.productId);
    add(LoadCart());
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    await _cartService.clearCart();
    add(LoadCart());
  }

  Future<void> _onGetCartItemById(GetCartItemById event, Emitter<CartState> emit) async {
    try {
      final item = await _cartService.getItemById(event.productId);
      emit(CartItemLoaded(item));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}