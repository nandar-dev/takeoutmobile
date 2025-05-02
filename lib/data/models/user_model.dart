import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
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
