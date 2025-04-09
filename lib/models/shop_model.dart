class Shop {
  final int id;
  final String name;
  final String openingTime;
  final String closingTime;
  final String imageUrl;

  Shop({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.openingTime,
    required this.closingTime,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'imageUrl': imageUrl,
    };
  }
}
