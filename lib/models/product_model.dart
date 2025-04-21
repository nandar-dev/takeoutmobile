class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final Shop shop;
  final String categoryName;
  final String description;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.shop,
    required this.categoryName,
    required this.description,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'],
      shop: Shop.fromJson(json['shop']),
      categoryName: json['category']['name'],
      description: json['description'],
      stock: json['stock'],
    );
  }

  factory Product.fromCartItem(Map<String, dynamic> item) {
    return Product(
      id: item['productId'],
      name: item['name'],
      price: (item['price'] as num).toDouble(),
      imageUrl: item['imageUrl'],
      shop: Shop(
        id: item['shopId'] ?? 0,
        name: item['shopName'] ?? '',
      ),
      categoryName: item['categoryName'] ?? '',
      description: item['description'] ?? '',
      stock: item['stock'],
    );
  }
}

class Shop {
  final int id;
  final String name;

  Shop({
    required this.id,
    required this.name,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
    );
  }
}
