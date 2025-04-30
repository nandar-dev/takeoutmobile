// import 'package:hive_flutter/hive_flutter.dart';

// part 'user_model.g.dart';

// @HiveType(typeId: 1)
// class UserModel extends HiveObject {
//   @HiveField(0)
//   final int? id;

//   @HiveField(1)
//   final String? name;

//   @HiveField(2)
//   final String? email;

//   @HiveField(3)
//   final String? emailVerifiedAt;

//   @HiveField(4)
//   final String? createdAt;

//   @HiveField(5)
//   final String? updatedAt;

//   @HiveField(6)
//   final int? phoneCode;

//   @HiveField(7)
//   final String? phone;

//   @HiveField(8)
//   final String? postalCode;

//   @HiveField(9)
//   final String? address;

//   @HiveField(10)
//   final String? countryId;

//   @HiveField(11)
//   final String? stateId;

//   @HiveField(12)
//   final String? cityId;

//   @HiveField(13)
//   final int? roles;

//   @HiveField(14)
//   final String? image;

//   @HiveField(15)
//   final String? latlong;

//   @HiveField(16)
//   final String? gender;

//   @HiveField(17)
//   final String? walletAmount;

//   @HiveField(18)
//   final int? status;

//   @HiveField(19)
//   final int? merchantId;

//   @HiveField(20)
//   final int? driverId;

//   @HiveField(21)
//   final String? role;

//   UserModel({
//     this.id,
//     this.name,
//     this.email,
//     this.emailVerifiedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.phoneCode,
//     this.phone,
//     this.postalCode,
//     this.address,
//     this.countryId,
//     this.stateId,
//     this.cityId,
//     this.roles,
//     this.image,
//     this.latlong,
//     this.gender,
//     this.walletAmount,
//     this.status,
//     this.merchantId,
//     this.driverId,
//     this.role,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     final data = json['data'];
//     // final user = data['user'];
//     final user =
//         data is Map<String, dynamic> && data.containsKey('user')
//             ? data['user']
//             : data;

//     return UserModel(
//       id: user['id'] ?? 0,
//       name: user['name'] ?? '',
//       email: user['email'] ?? '',
//       emailVerifiedAt: user['email_verified_at'],
//       createdAt: user['created_at'] ?? '',
//       updatedAt: user['updated_at'] ?? '',
//       phoneCode: user['phone_code'] ?? 0,
//       phone: user['phone'] ?? '',
//       postalCode: user['postal_code'],
//       address: user['address'] ?? '',
//       countryId: user['country_id'] ?? '',
//       stateId: user['state_id'] ?? '',
//       cityId: user['city_id'] ?? '',
//       roles: user['roles'] ?? 0,
//       image: user['image'],
//       latlong: user['latlong'] ?? '',
//       gender: user['gender'],
//       walletAmount: user['wallet_amount'] ?? '0',
//       status: user['status'] ?? 0,
//       merchantId: user['merchant_id'] ?? 0,
//       driverId: user['driver_id'] ?? 0,
//       role: user['role'] ?? '',
//     );
//   }
// }

// ///////////////////////////////////////////////////

// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// part 'user_model.g.dart';

// @HiveType(typeId: 1)
// @JsonSerializable()
// class UserModel extends HiveObject {
//   @HiveField(0)
//   final int? id;

//   @HiveField(1)
//   final String? name;

//   @HiveField(2)
//   final String? email;

//   @HiveField(3)
//   final String? emailVerifiedAt;

//   @HiveField(4)
//   final String? createdAt;

//   @HiveField(5)
//   final String? updatedAt;

//   @HiveField(6)
//   final int? phoneCode;

//   @HiveField(7)
//   final String? phone;

//   @HiveField(8)
//   final String? postalCode;

//   @HiveField(9)
//   final String? address;

//   @HiveField(10)
//   final String? countryId;

//   @HiveField(11)
//   final String? stateId;

//   @HiveField(12)
//   final String? cityId;

//   @HiveField(13)
//   final int? roles;

//   @HiveField(14)
//   final String? image;

//   @HiveField(15)
//   final String? latlong;

//   @HiveField(16)
//   final String? gender;

//   @HiveField(17)
//   final String? walletAmount;

//   @HiveField(18)
//   final int? status;

//   @HiveField(19)
//   final int? merchantId;

//   @HiveField(20)
//   final int? driverId;

//   @HiveField(21)
//   final String? role;

//   UserModel({
//     this.id,
//     this.name,
//     this.email,
//     this.emailVerifiedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.phoneCode,
//     this.phone,
//     this.postalCode,
//     this.address,
//     this.countryId,
//     this.stateId,
//     this.cityId,
//     this.roles,
//     this.image,
//     this.latlong,
//     this.gender,
//     this.walletAmount,
//     this.status,
//     this.merchantId,
//     this.driverId,
//     this.role,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) =>
//       _$UserModelFromJson(json);

//   Map<String, dynamic> toJson() => _$UserModelToJson(this);

//   static UserModel fromJsonModel(UserModel model) => UserModel(
//     id: model.id,
//     name: model.name,
//     email: model.email,
//     emailVerifiedAt: model.emailVerifiedAt,
//     createdAt: model.createdAt,
//     updatedAt: model.updatedAt,
//     phoneCode: model.phoneCode,
//     phone: model.phone,
//     postalCode: model.postalCode,
//     address: model.address,
//     countryId: model.countryId,
//     stateId: model.stateId,
//     cityId: model.cityId,
//     roles: model.roles,
//     image: model.image,
//     latlong: model.latlong,
//     gender: model.gender,
//     walletAmount: model.walletAmount,
//     status: model.status,
//     merchantId: model.merchantId,
//     driverId: model.driverId,
//     role: model.role,
//   );
// }

// //////////////////////////////////////////////////////

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
// @JsonSerializable()
@HiveType(typeId: 1)
class UserModel with _$UserModel {
  const factory UserModel({
    @HiveField(0) int? id,
    @HiveField(1) String? name,
    @HiveField(2) String? email,
    @HiveField(3) String? emailVerifiedAt,
    @HiveField(4) String? createdAt,
    @HiveField(5) String? updatedAt,
    @HiveField(6) int? phoneCode,
    @HiveField(7) String? phone,
    @HiveField(8) String? postalCode,
    @HiveField(9) String? address,
    @HiveField(10) String? countryId,
    @HiveField(11) String? stateId,
    @HiveField(12) String? cityId,
    @HiveField(13) int? roles,
    @HiveField(14) String? image,
    @HiveField(15) String? latlong,
    @HiveField(16) String? gender,
    @HiveField(17) String? walletAmount,
    @HiveField(18) int? status,
    @HiveField(19) int? merchantId,
    @HiveField(20) int? driverId,
    @HiveField(21) String? role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
