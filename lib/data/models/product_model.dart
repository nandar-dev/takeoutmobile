import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/utils/hive_type_ids.dart';

part 'product_model.g.dart';

@HiveType(typeId: productModelTypeId)
@JsonSerializable()
class ProductModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;
  @HiveField(1)
  @JsonKey(name: 'm_id')
  final int mId;
  @HiveField(2)
  @JsonKey(name: 'm_name')
  final String mName;
  @HiveField(3)
  @JsonKey(name: 'shop_name')
  final String shopName;
  @HiveField(4)
  @JsonKey(name: 'c_id')
  final int cId;
  @HiveField(5)
  @JsonKey(name: 'c_name')
  final String cName;
  @HiveField(6)
  @JsonKey(name: 'p_id')
  final int pId;
  @HiveField(7)
  @JsonKey(name: 'p_name')
  final String pName;
  @HiveField(8)
  @JsonKey(name: 'en_description')
  final String enDescription;
  @HiveField(9)
  @JsonKey(name: 'mm_description')
  final String mmDescription;
  @HiveField(10)
  @JsonKey(name: 'th_description')
  final String thDescription;
  @HiveField(11)
  @JsonKey(name: 'cn_description')
  final String cnDescription;
  @HiveField(12)
  @JsonKey(name: 'p_price')
  final double pPrice;
  @HiveField(13)
  @JsonKey(name: 'discount_type')
  final String discountType;
  @HiveField(14)
  @JsonKey(name: 'discount_percent')
  final double discountPercent;
  @HiveField(15)
  @JsonKey(name: 'discount_amount')
  final double discountAmount;
  @HiveField(16)
  @JsonKey(name: 'p_stock')
  final int pStock;
  @HiveField(17)
  @JsonKey(name: 'p_is_available')
  final int pIsAvailable;
  @HiveField(18)
  @JsonKey(name: 'p_sortBy')
  final int pSortBy;
  @HiveField(19)
  @JsonKey(name: 'p_image')
  final String pImage;
  @HiveField(20)
  @JsonKey(name: 'product_image')
  final List<ProductImageModel> productImage;

  ProductModel({
    int? id,
    int? mId,
    String? mName,
    String? shopName,
    int? cId,
    String? cName,
    int? pId,
    String? pName,
    String? enDescription,
    String? mmDescription,
    String? thDescription,
    String? cnDescription,
    double? pPrice,
    String? discountType,
    double? discountPercent,
    double? discountAmount,
    int? pStock,
    int? pIsAvailable,
    int? pSortBy,
    String? pImage,
    List<ProductImageModel>? productImage,
  }) : id = id ?? 0,
       mId = mId ?? 0,
       mName = mName ?? '',
       shopName = shopName ?? '',
       cId = cId ?? 0,
       cName = cName ?? '',
       pId = pId ?? 0,
       pName = pName ?? '',
       enDescription = enDescription ?? '',
       mmDescription = mmDescription ?? '',
       thDescription = thDescription ?? '',
       cnDescription = cnDescription ?? '',
       pPrice = pPrice ?? 0.0,
       discountType = discountType ?? 'none',
       discountPercent = discountPercent ?? 0.0,
       discountAmount = discountAmount ?? 0.0,
       pStock = pStock ?? 0,
       pIsAvailable = pIsAvailable ?? 0,
       pSortBy = pSortBy ?? 0,
       pImage = pImage ?? '',
       productImage = productImage ?? [];

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductModel(
        id: json['id'] as int?,
        mId: json['m_id'] as int?,
        mName: json['m_name'] as String?,
        shopName: json['shop_name'] as String?,
        cId: json['c_id'] as int?,
        cName: json['c_name'] as String?,
        pId: json['p_id'] as int?,
        pName: json['p_name'] as String?,
        enDescription: json['en_description'] as String?,
        mmDescription: json['mm_description'] as String?,
        thDescription: json['th_description'] as String?,
        cnDescription: json['cn_description'] as String?,
        pPrice: (json['p_price'] as num?)?.toDouble(),
        discountType: json['discount_type'] as String?,
        discountPercent: (json['discount_percent'] as num?)?.toDouble(),
        discountAmount: (json['discount_amount'] as num?)?.toDouble(),
        pStock: json['p_stock'] as int?,
        pIsAvailable: json['p_is_available'] as int?,
        pSortBy: json['p_sortBy'] as int?,
        pImage: json['p_image'] as String?,
        productImage:
            (json['product_image'] as List<dynamic>?)
                ?.map(
                  (e) => ProductImageModel.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
      );
    } catch (e) {
      return ProductModel.empty();
    }
  }

  // Empty product with loading state defaults
  factory ProductModel.empty() => ProductModel(
    pName: 'Loading..........',
    pPrice: 0.0,
    shopName: "Loading...",
    // productImage: [ProductImageModel.loading()],
  );

  // For JSON serialization
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  // Helper methods
  double get finalPrice {
    if (discountType == 'percent') {
      return pPrice * (1 - discountPercent / 100);
    } else if (discountType == 'amount') {
      return pPrice - discountAmount;
    }
    return pPrice;
  }

  bool get isAvailable => pIsAvailable == 1 && pStock > 0;
  bool get hasDiscount => discountPercent > 0 || discountAmount > 0;
}

@HiveType(typeId: productImageModelTypeId)
@JsonSerializable()
class ProductImageModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;
  @HiveField(1)
  @JsonKey(name: 'p_id')
  final int pId;
  @HiveField(2)
  @JsonKey(name: 'link')
  final String link;
  @HiveField(3)
  @JsonKey(name: 'type')
  final String type;
  @HiveField(4)
  @JsonKey(name: 'created_at')
  final String createdAt;
  @HiveField(5)
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  ProductImageModel({
    int? id,
    int? pId,
    String? link,
    String? type,
    String? createdAt,
    String? updatedAt,
  }) : id = id ?? 0,
       pId = pId ?? 0,
       link = link ?? '',
       type = type ?? 'image',
       createdAt = createdAt ?? '',
       updatedAt = updatedAt ?? '';

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: json['id'] as int?,
      pId: json['p_id'] as int?,
      link: json['link'] as String?,
      type: json['type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  factory ProductImageModel.loading() =>
      ProductImageModel(link: 'assets/loading.gif', type: 'loading');

  Map<String, dynamic> toJson() => _$ProductImageModelToJson(this);

  bool get isValid => link.isNotEmpty;
}

// Singleton Product Loader
class ProductLoader {
  static final ProductLoader _instance = ProductLoader._internal();
  late ProductModel loadingProduct;

  factory ProductLoader() {
    return _instance;
  }

  ProductLoader._internal() {
    loadingProduct = ProductModel.empty();
  }

  List<ProductModel> getLoadingProducts(int count) {
    return List.generate(count, (_) => ProductModel.empty());
  }
}
