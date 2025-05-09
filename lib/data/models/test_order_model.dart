class OrderModel {
  final int id;
  final String orderNo;
  final String status;
  final int deliStatus;
  final String createdAt;
  final List<dynamic> orderItems;

  OrderModel({
    required this.id,
    required this.orderNo,
    required this.status,
    required this.deliStatus,
    required this.createdAt,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      orderNo: json['order_no'],
      status: json['status'],
      deliStatus: json['deli_status'],
      createdAt: json['created_at'],
      orderItems: json['order_items'],
    );
  }
}
