import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/utils/hive_type_ids.dart';

part 'shoptype_model.g.dart';

@HiveType(typeId: shopTypeModelTypeId)
@JsonSerializable()
class ShoptypeModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;

  @HiveField(1)
  @JsonKey(name: 'name')
  final String name;

  @HiveField(2)
  @JsonKey(name: 'img_url')
  final String imageUrl;

  @HiveField(3)
  @JsonKey(name: 'status')
  final String status;

  @HiveField(4)
  @JsonKey(name: 'created_at')
  final String createdAt;

  @HiveField(5)
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  ShoptypeModel({
    int? id,
    String? name,
    String? imageUrl,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) : id = id ?? 0,
       name = name ?? '',
       imageUrl = imageUrl ?? '',
       status = status ?? '',
       createdAt = createdAt ?? '',
       updatedAt = updatedAt ?? '';

  factory ShoptypeModel.fromJson(Map<String, dynamic> json) {
    try {
      return ShoptypeModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        imageUrl: json['image'] as String?,
        status: json['status'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );
    } catch (e) {
      return ShoptypeModel.empty();
    }
  }

  // Empty category
  factory ShoptypeModel.empty() => ShoptypeModel();

  // Loading state category
  factory ShoptypeModel.loading() => ShoptypeModel(name: 'Loading...');

  Map<String, dynamic> toJson() => _$ShoptypeModelToJson(this);
}

// Singleton Category Loader
class ShoptypeLoader {
  static final ShoptypeLoader _instance = ShoptypeLoader._internal();
  late ShoptypeModel loadingCategory;

  factory ShoptypeLoader() {
    return _instance;
  }

  ShoptypeLoader._internal() {
    loadingCategory = ShoptypeModel.loading();
  }

  List<ShoptypeModel> getLoadingCategories(int count) {
    return List.generate(count, (_) => ShoptypeModel.loading());
  }
}
