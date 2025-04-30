// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      email: fields[2] as String?,
      emailVerifiedAt: fields[3] as String?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
      phoneCode: fields[6] as int?,
      phone: fields[7] as String?,
      postalCode: fields[8] as String?,
      address: fields[9] as String?,
      countryId: fields[10] as String?,
      stateId: fields[11] as String?,
      cityId: fields[12] as String?,
      roles: fields[13] as int?,
      image: fields[14] as String?,
      latlong: fields[15] as String?,
      gender: fields[16] as String?,
      walletAmount: fields[17] as String?,
      status: fields[18] as int?,
      merchantId: fields[19] as int?,
      driverId: fields[20] as int?,
      role: fields[21] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.emailVerifiedAt)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.phoneCode)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.postalCode)
      ..writeByte(9)
      ..write(obj.address)
      ..writeByte(10)
      ..write(obj.countryId)
      ..writeByte(11)
      ..write(obj.stateId)
      ..writeByte(12)
      ..write(obj.cityId)
      ..writeByte(13)
      ..write(obj.roles)
      ..writeByte(14)
      ..write(obj.image)
      ..writeByte(15)
      ..write(obj.latlong)
      ..writeByte(16)
      ..write(obj.gender)
      ..writeByte(17)
      ..write(obj.walletAmount)
      ..writeByte(18)
      ..write(obj.status)
      ..writeByte(19)
      ..write(obj.merchantId)
      ..writeByte(20)
      ..write(obj.driverId)
      ..writeByte(21)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      phoneCode: (json['phoneCode'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      postalCode: json['postalCode'] as String?,
      address: json['address'] as String?,
      countryId: json['countryId'] as String?,
      stateId: json['stateId'] as String?,
      cityId: json['cityId'] as String?,
      roles: (json['roles'] as num?)?.toInt(),
      image: json['image'] as String?,
      latlong: json['latlong'] as String?,
      gender: json['gender'] as String?,
      walletAmount: json['walletAmount'] as String?,
      status: (json['status'] as num?)?.toInt(),
      merchantId: (json['merchantId'] as num?)?.toInt(),
      driverId: (json['driverId'] as num?)?.toInt(),
      role: json['role'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'emailVerifiedAt': instance.emailVerifiedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'phoneCode': instance.phoneCode,
      'phone': instance.phone,
      'postalCode': instance.postalCode,
      'address': instance.address,
      'countryId': instance.countryId,
      'stateId': instance.stateId,
      'cityId': instance.cityId,
      'roles': instance.roles,
      'image': instance.image,
      'latlong': instance.latlong,
      'gender': instance.gender,
      'walletAmount': instance.walletAmount,
      'status': instance.status,
      'merchantId': instance.merchantId,
      'driverId': instance.driverId,
      'role': instance.role,
    };
