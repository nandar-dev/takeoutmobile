import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:takeout/models/product_model.dart';

class ProductService {
  Future<List<Product>> loadProducts() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/products.json');
      final List<dynamic> jsonResponse = json.decode(jsonString);
      return jsonResponse.map((data) => Product.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Error loading products: $e');
    }
  }

  Future<List<Product>> getRelatedProducts(int productId) async {
    try {
      final products = await loadProducts();
      return products.where((product) => product.id != productId).toList();
    } catch (e) {
      throw Exception('Error filtering related products: $e');
    }
  }
}
