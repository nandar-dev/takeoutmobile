import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/data/models/shoptype_model.dart';

class ShoptypeLocalDataSource {
  final Box<ShoptypeModel> box;

  ShoptypeLocalDataSource(this.box);

  Future<void> cacheShoptype(List<ShoptypeModel> shoptypes) async {
    await box.clear();
    for (var shoptype in shoptypes) {
      await box.add(shoptype);
    }
  }

  List<ShoptypeModel> getCachedShoptype() {
    return box.values.toList();
  }
}
