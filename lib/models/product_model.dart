class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String shopName;
  final String categoryName;
  final String description;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.shopName,
    required this.categoryName,
    required this.description,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['image_url'],
      shopName: json['shop']['name'],
      categoryName: json['category']['name'],
      description: json['description'],
      stock: json['stock']
    );
  }
}
