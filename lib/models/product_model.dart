class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String shopName;
  final String categoryName;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.shopName,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['image_url'],
      shopName: json['shop']['name'],
      categoryName: json['category']['name'],
    );
  }
}
