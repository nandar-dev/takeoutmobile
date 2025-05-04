// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as int?,
      mId: fields[1] as int?,
      mName: fields[2] as String?,
      shopName: fields[3] as String?,
      cId: fields[4] as int?,
      cName: fields[5] as String?,
      pId: fields[6] as int?,
      pName: fields[7] as String?,
      enDescription: fields[8] as String?,
      mmDescription: fields[9] as String?,
      thDescription: fields[10] as String?,
      cnDescription: fields[11] as String?,
      pPrice: fields[12] as double?,
      discountType: fields[13] as String?,
      discountPercent: fields[14] as double?,
      discountAmount: fields[15] as double?,
      pStock: fields[16] as int?,
      pIsAvailable: fields[17] as int?,
      pSortBy: fields[18] as int?,
      pImage: fields[19] as String?,
      productImage: (fields[20] as List?)?.cast<ProductImageModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mId)
      ..writeByte(2)
      ..write(obj.mName)
      ..writeByte(3)
      ..write(obj.shopName)
      ..writeByte(4)
      ..write(obj.cId)
      ..writeByte(5)
      ..write(obj.cName)
      ..writeByte(6)
      ..write(obj.pId)
      ..writeByte(7)
      ..write(obj.pName)
      ..writeByte(8)
      ..write(obj.enDescription)
      ..writeByte(9)
      ..write(obj.mmDescription)
      ..writeByte(10)
      ..write(obj.thDescription)
      ..writeByte(11)
      ..write(obj.cnDescription)
      ..writeByte(12)
      ..write(obj.pPrice)
      ..writeByte(13)
      ..write(obj.discountType)
      ..writeByte(14)
      ..write(obj.discountPercent)
      ..writeByte(15)
      ..write(obj.discountAmount)
      ..writeByte(16)
      ..write(obj.pStock)
      ..writeByte(17)
      ..write(obj.pIsAvailable)
      ..writeByte(18)
      ..write(obj.pSortBy)
      ..writeByte(19)
      ..write(obj.pImage)
      ..writeByte(20)
      ..write(obj.productImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductImageModelAdapter extends TypeAdapter<ProductImageModel> {
  @override
  final int typeId = 2;

  @override
  ProductImageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductImageModel(
      id: fields[0] as int?,
      pId: fields[1] as int?,
      link: fields[2] as String?,
      type: fields[3] as String?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductImageModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pId)
      ..writeByte(2)
      ..write(obj.link)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductImageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: (json['id'] as num?)?.toInt(),
      mId: (json['m_id'] as num?)?.toInt(),
      mName: json['m_name'] as String?,
      shopName: json['shop_name'] as String?,
      cId: (json['c_id'] as num?)?.toInt(),
      cName: json['c_name'] as String?,
      pId: (json['p_id'] as num?)?.toInt(),
      pName: json['p_name'] as String?,
      enDescription: json['en_description'] as String?,
      mmDescription: json['mm_description'] as String?,
      thDescription: json['th_description'] as String?,
      cnDescription: json['cn_description'] as String?,
      pPrice: (json['p_price'] as num?)?.toDouble(),
      discountType: json['discount_type'] as String?,
      discountPercent: (json['discount_percent'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      pStock: (json['p_stock'] as num?)?.toInt(),
      pIsAvailable: (json['p_is_available'] as num?)?.toInt(),
      pSortBy: (json['p_sortBy'] as num?)?.toInt(),
      pImage: json['p_image'] as String?,
      productImage: (json['product_image'] as List<dynamic>?)
          ?.map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'm_id': instance.mId,
      'm_name': instance.mName,
      'shop_name': instance.shopName,
      'c_id': instance.cId,
      'c_name': instance.cName,
      'p_id': instance.pId,
      'p_name': instance.pName,
      'en_description': instance.enDescription,
      'mm_description': instance.mmDescription,
      'th_description': instance.thDescription,
      'cn_description': instance.cnDescription,
      'p_price': instance.pPrice,
      'discount_type': instance.discountType,
      'discount_percent': instance.discountPercent,
      'discount_amount': instance.discountAmount,
      'p_stock': instance.pStock,
      'p_is_available': instance.pIsAvailable,
      'p_sortBy': instance.pSortBy,
      'p_image': instance.pImage,
      'product_image': instance.productImage,
    };

ProductImageModel _$ProductImageModelFromJson(Map<String, dynamic> json) =>
    ProductImageModel(
      id: (json['id'] as num?)?.toInt(),
      pId: (json['p_id'] as num?)?.toInt(),
      link: json['link'] as String?,
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ProductImageModelToJson(ProductImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'p_id': instance.pId,
      'link': instance.link,
      'type': instance.type,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
