import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/utils/hive_type_ids.dart';

part 'category_model.g.dart';

@HiveType(typeId: categoryModelTypeId)
@JsonSerializable()
class CategoryModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;

  @HiveField(1)
  @JsonKey(name: 'name')
  final String name;

  @HiveField(2)
  @JsonKey(name: 'en_description')
  final String enDescription;

  @HiveField(3)
  @JsonKey(name: 'mm_description')
  final String mmDescription;

  @HiveField(4)
  @JsonKey(name: 'th_description')
  final String thDescription;

  @HiveField(5)
  @JsonKey(name: 'cn_description')
  final String cnDescription;

  @HiveField(6)
  @JsonKey(name: 'is_available')
  final int isAvailable;

  @HiveField(7)
  @JsonKey(name: 'image')
  final String image;

  @HiveField(8)
  @JsonKey(name: 'shop_type_id')
  final int shopTypeId;

  @HiveField(9)
  @JsonKey(name: 'created_at')
  final String createdAt;

  @HiveField(10)
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @HiveField(11)
  @JsonKey(name: 'sorting_order')
  final int sortingOrder;

  CategoryModel({
    int? id,
    String? name,
    String? enDescription,
    String? mmDescription,
    String? thDescription,
    String? cnDescription,
    int? isAvailable,
    String? image,
    int? shopTypeId,
    String? createdAt,
    String? updatedAt,
    int? sortingOrder,
  }) : id = id ?? 0,
       name = name ?? '',
       enDescription = enDescription ?? '',
       mmDescription = mmDescription ?? '',
       thDescription = thDescription ?? '',
       cnDescription = cnDescription ?? '',
       isAvailable = isAvailable ?? 0,
       image = image ?? '',
       shopTypeId = shopTypeId ?? 0,
       createdAt = createdAt ?? '',
       updatedAt = updatedAt ?? '',
       sortingOrder = sortingOrder ?? 0;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      return CategoryModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        enDescription: json['en_description'] as String?,
        mmDescription: json['mm_description'] as String?,
        thDescription: json['th_description'] as String?,
        cnDescription: json['cn_description'] as String?,
        isAvailable: json['is_available'] as int?,
        image: json['image'] as String?,
        shopTypeId: json['shop_type_id'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        sortingOrder: json['sorting_order'] as int?,
      );
    } catch (e) {
      return CategoryModel.empty();
    }
  }

  // Empty category
  factory CategoryModel.empty() => CategoryModel();

  // Loading state category
  factory CategoryModel.loading() =>
      CategoryModel(name: 'Loading...', image: 'assets/loading.gif');

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  // Helper methods
  bool get isActive => isAvailable == 1;
  String get displayDescription =>
      enDescription.isNotEmpty
          ? enDescription
          : mmDescription.isNotEmpty
          ? mmDescription
          : thDescription.isNotEmpty
          ? thDescription
          : cnDescription.isNotEmpty
          ? cnDescription
          : 'No description available';
}

// Singleton Category Loader
class CategoryLoader {
  static final CategoryLoader _instance = CategoryLoader._internal();
  late CategoryModel loadingCategory;

  factory CategoryLoader() {
    return _instance;
  }

  CategoryLoader._internal() {
    loadingCategory = CategoryModel.loading();
  }

  List<CategoryModel> getLoadingCategories(int count) {
    return List.generate(count, (_) => CategoryModel.loading());
  }
}
