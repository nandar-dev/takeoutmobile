import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartService {
  static const String _cartKey = 'cart_items';

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(_cartKey);
    if (cartJson != null) {
      final decoded = json.decode(cartJson);
      return (decoded as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    return [];
  }

  Future<void> addToCart(Map<String, dynamic> item) async {
    final prefs = await SharedPreferences.getInstance();
    final cartItems = await getCartItems();
    final productId = item['productId'];
    final stock = item['stock'] ?? 0;
    final quantity = item['quantity'] ?? 0;

    if (quantity > stock) {
      throw Exception('Cannot add more than $stock items.');
    }

    final index = cartItems.indexWhere((i) => i['productId'] == productId);
    if (index >= 0) {
      cartItems[index] = item;
    } else {
      cartItems.add(item);
    }

    await prefs.setString(_cartKey, json.encode(cartItems));
  }

  Future<void> setItemQuantity(int productId, int quantity) async {
    final prefs = await SharedPreferences.getInstance();
    final cartItems = await getCartItems();
    final index = cartItems.indexWhere(
      (item) => item['productId'] == productId,
    );

    if (index >= 0) {
      if (quantity <= 0) {
        cartItems.removeAt(index);
      } else {
        cartItems[index]['quantity'] = quantity;
      }
      await prefs.setString(_cartKey, json.encode(cartItems));
    }
  }

  Future<void> removeItem(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final cartItems = await getCartItems();
    cartItems.removeWhere((item) => item['productId'] == productId);
    await prefs.setString(_cartKey, json.encode(cartItems));
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  Future<int> getCartItemCount() async {
    final items = await getCartItems();
    return items.fold<int>(
      0,
      (sum, item) => sum + (item['quantity'] as int? ?? 0),
    );
  }

  Future<Map<String, dynamic>?> getItemById(int productId) async {
    final cartItems = await getCartItems();
    try {
      return cartItems.firstWhere((item) => item['productId'] == productId);
    } catch (_) {
      return null;
    }
  }
}
