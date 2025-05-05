// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 3;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      enDescription: fields[2] as String?,
      mmDescription: fields[3] as String?,
      thDescription: fields[4] as String?,
      cnDescription: fields[5] as String?,
      isAvailable: fields[6] as int?,
      image: fields[7] as String?,
      shopTypeId: fields[8] as String?,
      createdAt: fields[9] as String?,
      updatedAt: fields[10] as String?,
      sortingOrder: fields[11] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.enDescription)
      ..writeByte(3)
      ..write(obj.mmDescription)
      ..writeByte(4)
      ..write(obj.thDescription)
      ..writeByte(5)
      ..write(obj.cnDescription)
      ..writeByte(6)
      ..write(obj.isAvailable)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.shopTypeId)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.sortingOrder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      enDescription: json['en_description'] as String?,
      mmDescription: json['mm_description'] as String?,
      thDescription: json['th_description'] as String?,
      cnDescription: json['cn_description'] as String?,
      isAvailable: (json['is_available'] as num?)?.toInt(),
      image: json['image'] as String?,
      shopTypeId: json['shop_type_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      sortingOrder: (json['sorting_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'en_description': instance.enDescription,
      'mm_description': instance.mmDescription,
      'th_description': instance.thDescription,
      'cn_description': instance.cnDescription,
      'is_available': instance.isAvailable,
      'image': instance.image,
      'shop_type_id': instance.shopTypeId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'sorting_order': instance.sortingOrder,
    };
