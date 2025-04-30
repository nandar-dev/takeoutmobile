// import 'package:hive_flutter/hive_flutter.dart';
// part 'category_model.g.dart';

// @HiveType(typeId: 2)
// class CategoryModel extends HiveObject {
//   @HiveField(0)
//   final int? id;

//   @HiveField(1)
//   final String? orderNo;

//   @HiveField(2)
//   final String? voucherNo;

//   @HiveField(3)
//   final String? date;

//   @HiveField(4)
//   final int? status;

//   @HiveField(5)
//   final int? isDelete;

//   @HiveField(7)
//   final String? subTotal;

//   @HiveField(8)
//   final String? discountTotal;

//   @HiveField(9)
//   final String? grandTotal;

//   @HiveField(10)
//   final int? userId;

//   @HiveField(11)
//   final String? confirmationTime;

//   @HiveField(12)
//   final String? createdAt;

//   @HiveField(13)
//   final String? updatedAt;

//   @HiveField(14)
//   final List<OrderItemModel>? orderItems;

//   CategoryModel({
//     this.id,
//     this.orderNo,
//     this.voucherNo,
//     this.date,
//     this.status,
//     this.isDelete,
//     this.subTotal,
//     this.discountTotal,
//     this.grandTotal,
//     this.userId,
//     this.confirmationTime,
//     this.createdAt,
//     this.updatedAt,
//     this.orderItems,
//   });

//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     final orderData = json['order'];
//     if (orderData is List && orderData.isNotEmpty) {
//       final order = orderData.first;

//       List<OrderItemModel> parseOrderItems(List? items) {
//         if (items == null) return [];
//         return items.map((item) => OrderItemModel.fromJson(item)).toList();
//       }

//       return CategoryModel(
//         id: order['id'] ?? 0,
//         orderNo: order['order_no'],
//         voucherNo: order['voucher_no'],
//         date: order['date'],
//         status: order['status'],
//         isDelete: order['isDelete'],
//         subTotal: order['sub_total'],
//         discountTotal: order['discount_total'],
//         grandTotal: order['grand_total'],
//         userId: order['user_id'],
//         confirmationTime: order['confirmation_time'],
//         createdAt: order['created_at'],
//         updatedAt: order['updated_at'],
//         orderItems: parseOrderItems(order['order_items']),
//       );
//     } else {
//       return CategoryModel();
//     }
//   }
// }

// @HiveType(typeId: 3)
// class OrderItemModel extends HiveObject {
//   @HiveField(0)
//   final int? id;
//   @HiveField(1)
//   final int? orderId;
//   @HiveField(2)
//   final int? merchantId;
//   @HiveField(3)
//   final int? driverId;
//   @HiveField(4)
//   final int? status;
//   @HiveField(5)
//   final int? productId;
//   @HiveField(6)
//   final String? promoCode;
//   @HiveField(7)
//   final String? name;
//   @HiveField(8)
//   final int? quantity;
//   @HiveField(9)
//   final String? price;
//   @HiveField(10)
//   final int? discountId;
//   @HiveField(11)
//   final String? discountAmt;
//   @HiveField(12)
//   final String? total;
//   @HiveField(13)
//   final String? confirmationTime;
//   @HiveField(14)
//   final String? createdAt;
//   @HiveField(15)
//   final String? updatedAt;

//   OrderItemModel({
//     this.id,
//     this.orderId,
//     this.merchantId,
//     this.driverId,
//     this.status,
//     this.productId,
//     this.promoCode,
//     this.name,
//     this.quantity,
//     this.price,
//     this.discountId,
//     this.discountAmt,
//     this.total,
//     this.confirmationTime,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory OrderItemModel.fromJson(Map<String, dynamic> json) {
//     return OrderItemModel(
//       id: json['id'],
//       orderId: json['order_id'],
//       merchantId: json['merchant_id'],
//       driverId: json['driver_id'],
//       status: json['status'],
//       productId: json['product_id'],
//       promoCode: json['promo_code'],
//       name: json['name'],
//       quantity: json['quantity'],
//       price: json['price'],
//       discountId: json['discount_id'],
//       discountAmt: json['discount_amt'],
//       total: json['total'],
//       confirmationTime: json['confirmation_time'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }
