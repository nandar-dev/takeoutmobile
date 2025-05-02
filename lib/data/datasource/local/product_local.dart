import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/data/models/product_model.dart';

class ProductLocalDataSource {
  final Box<ProductModel> box;

  ProductLocalDataSource(this.box);

  Future<void> cacheProduct(List<ProductModel> products) async {
    await box.clear();
    for (var product in products) {
      await box.add(product);
    }
  }

  List<ProductModel> getCachedProduct() {
    return box.values.toList();
  }
}
