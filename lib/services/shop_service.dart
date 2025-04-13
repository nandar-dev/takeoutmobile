import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:takeout/models/shop_model.dart';

class ShopService {
  static Future<List<Shop>> loadShops() async {
    final String jsonString = await rootBundle.loadString('assets/data/shops.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((data) => Shop.fromJson(data)).toList();
  }
}
