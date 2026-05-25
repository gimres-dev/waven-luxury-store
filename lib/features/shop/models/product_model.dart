import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/shop/models/brand_model.dart';

enum ProductType { single, variable }

class ProductAttributeModel {
  String name;
  List<String> values;

  ProductAttributeModel({required this.name, required this.values});

  Map<String, dynamic> toJson() => {'Name': name, 'Values': values};

  factory ProductAttributeModel.fromMap(Map<String, dynamic> data) {
    return ProductAttributeModel(
      name: data['Name'] ?? '',
      values: List<String>.from(data['Values'] ?? []),
    );
  }
}

class ProductVariationModel {
  String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description,
    required this.price,
    this.salePrice = 0.0,
    required this.stock,
    required this.attributeValues,
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'SKU': sku,
        'Image': image,
        'Description': description ?? '',
        'Price': price,
        'SalePrice': salePrice,
        'Stock': stock,
        'AttributeValues': attributeValues,
      };

  factory ProductVariationModel.fromMap(Map<String, dynamic> data) {
    return ProductVariationModel(
      id: data['Id'] ?? '',
      sku: data['SKU'] ?? '',
      image: data['Image'] ?? '',
      description: data['Description'],
      price: (data['Price'] ?? 0.0).toDouble(),
      salePrice: (data['SalePrice'] ?? 0.0).toDouble(),
      stock: data['Stock'] ?? 0,
      attributeValues: Map<String, String>.from(data['AttributeValues'] ?? {}),
    );
  }
}

class ProductModel {
  String id;
  String title;
  String? sku;
  int stock;
  double price;
  double? salePrice;
  String? thumbnail;
  String? description;
  String? categoryId;
  List<String>? images;
  bool? isFeatured;
  BrandModel? brand;
  ProductType productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    this.sku,
    required this.stock,
    required this.price,
    this.salePrice,
    this.thumbnail,
    this.description,
    this.categoryId,
    this.images,
    this.isFeatured,
    this.brand,
    required this.productType,
    this.productAttributes,
    this.productVariations,
  });

  static ProductModel empty() => ProductModel(
        id: '',
        title: '',
        stock: 0,
        price: 0,
        productType: ProductType.single,
      );

  double get displayPrice =>
      (salePrice != null && salePrice! > 0) ? salePrice! : price;

  Map<String, dynamic> toJson() => {
        'Title': title,
        'SKU': sku ?? '',
        'Stock': stock,
        'Price': price,
        'SalePrice': salePrice ?? 0.0,
        'Thumbnail': thumbnail ?? '',
        'Description': description ?? '',
        'CategoryId': categoryId ?? '',
        'Images': images ?? [],
        'IsFeatured': isFeatured ?? false,
        'Brand': brand?.toJson(),
        'ProductType': productType.toString(),
        'ProductAttributes':
            productAttributes?.map((a) => a.toJson()).toList() ?? [],
        'ProductVariations':
            productVariations?.map((v) => v.toJson()).toList() ?? [],
      };

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) return ProductModel.empty();

    return ProductModel(
      id: snapshot.id,
      title: data['Title'] ?? '',
      sku: data['SKU'],
      stock: data['Stock'] ?? 0,
      price: (data['Price'] ?? 0.0).toDouble(),
      salePrice: (data['SalePrice'] ?? 0.0).toDouble(),
      thumbnail: data['Thumbnail'],
      description: data['Description'],
      categoryId: data['CategoryId'],
      images: List<String>.from(data['Images'] ?? []),
      isFeatured: data['IsFeatured'] ?? false,
      brand: data['Brand'] != null
          ? BrandModel.fromMap(Map<String, dynamic>.from(data['Brand']))
          : null,
      productType: data['ProductType'] == 'ProductType.variable'
          ? ProductType.variable
          : ProductType.single,
      productAttributes: (data['ProductAttributes'] as List?)
              ?.map((a) =>
                  ProductAttributeModel.fromMap(Map<String, dynamic>.from(a)))
              .toList() ??
          [],
      productVariations: (data['ProductVariations'] as List?)
              ?.map((v) =>
                  ProductVariationModel.fromMap(Map<String, dynamic>.from(v)))
              .toList() ??
          [],
    );
  }
}
