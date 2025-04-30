// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 2;

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
      isAvailable: fields[7] as int?,
      image: fields[8] as String?,
      shopTypeId: fields[9] as int?,
      createdAt: fields[10] as String?,
      updatedAt: fields[11] as String?,
      sortingOrder: fields[12] as String?,
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
      ..writeByte(7)
      ..write(obj.isAvailable)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.shopTypeId)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
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
      enDescription: json['enDescription'] as String?,
      mmDescription: json['mmDescription'] as String?,
      thDescription: json['thDescription'] as String?,
      cnDescription: json['cnDescription'] as String?,
      isAvailable: (json['isAvailable'] as num?)?.toInt(),
      image: json['image'] as String?,
      shopTypeId: (json['shopTypeId'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      sortingOrder: json['sortingOrder'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'enDescription': instance.enDescription,
      'mmDescription': instance.mmDescription,
      'thDescription': instance.thDescription,
      'cnDescription': instance.cnDescription,
      'isAvailable': instance.isAvailable,
      'image': instance.image,
      'shopTypeId': instance.shopTypeId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'sortingOrder': instance.sortingOrder,
    };
