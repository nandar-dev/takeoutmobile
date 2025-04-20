class CartItem {
  final int productId;
  final int quantity;
  final String name;
  final double price;
  final String imageUrl;
  final int stock;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.stock,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      quantity: json['quantity'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      stock: json['stock'],
    );
  }
}
