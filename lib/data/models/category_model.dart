import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class CategoryModel extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? enDescription;

  @HiveField(3)
  final String? mmDescription;

  @HiveField(4)
  final String? thDescription;

  @HiveField(5)
  final String? cnDescription;

  @HiveField(7)
  final int? isAvailable;

  @HiveField(8)
  final String? image;

  @HiveField(9)
  final int? shopTypeId;

  @HiveField(10)
  final String? createdAt;

  @HiveField(11)
  final String? updatedAt;

  @HiveField(12)
  final String? sortingOrder;

  CategoryModel({
    this.id,
    this.name,
    this.enDescription,
    this.mmDescription,
    this.thDescription,
    this.cnDescription,
    this.isAvailable,
    this.image,
    this.shopTypeId,
    this.createdAt,
    this.updatedAt,
    this.sortingOrder,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  static CategoryModel fromJsonModel(CategoryModel model) => CategoryModel(
    id: model.id,
    name: model.name,
    enDescription: model.enDescription,
    mmDescription: model.mmDescription,
    thDescription: model.thDescription,
    cnDescription: model.cnDescription,
    isAvailable: model.isAvailable,
    image: model.image,
    shopTypeId: model.shopTypeId,
    createdAt: model.createdAt,
    updatedAt: model.updatedAt,
    sortingOrder: model.sortingOrder,
  );
}
