import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? emailVerifiedAt;

  @HiveField(4)
  final String createdAt;

  @HiveField(5)
  final String updatedAt;

  @HiveField(6)
  final int phoneCode;

  @HiveField(7)
  final String phone;

  @HiveField(8)
  final String? postalCode;

  @HiveField(9)
  final String address;

  @HiveField(10)
  final String countryId;

  @HiveField(11)
  final String stateId;

  @HiveField(12)
  final String cityId;

  @HiveField(13)
  final int roles;

  @HiveField(14)
  final String? image;

  @HiveField(15)
  final String latlong;

  @HiveField(16)
  final String? gender;

  @HiveField(17)
  final String walletAmount;

  @HiveField(18)
  final int status;

  @HiveField(19)
  final int merchantId;

  @HiveField(20)
  final int driverId;

  @HiveField(21)
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneCode,
    required this.phone,
    this.postalCode,
    required this.address,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.roles,
    this.image,
    required this.latlong,
    this.gender,
    required this.walletAmount,
    required this.status,
    required this.merchantId,
    required this.driverId,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final user = data['user'];

    return UserModel(
      id: user['id'] ?? 0,
      name: user['name'] ?? '',
      email: user['email'] ?? '',
      emailVerifiedAt: user['email_verified_at'],
      createdAt: user['created_at'] ?? '',
      updatedAt: user['updated_at'] ?? '',
      phoneCode: user['phone_code'] ?? 0,
      phone: user['phone'] ?? '',
      postalCode: user['postal_code'],
      address: user['address'] ?? '',
      countryId: user['country_id'] ?? '',
      stateId: user['state_id'] ?? '',
      cityId: user['city_id'] ?? '',
      roles: user['roles'] ?? 0,
      image: user['image'],
      latlong: user['latlong'] ?? '',
      gender: user['gender'],
      walletAmount: user['wallet_amount'] ?? '',
      status: user['status'] ?? 0,
      merchantId: user['merchant_id'] ?? 0,
      driverId: user['driver_id'] ?? 0,
      role: user['role'] ?? '',
    );
  }
}
