import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.productsCount,
  });

  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'Image': image,
        'IsFeatured': isFeatured,
        'ProductsCount': productsCount ?? 0,
      };

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: data['ProductsCount'] ?? 0,
      );
    }
    return BrandModel.empty();
  }

  factory BrandModel.fromMap(Map<String, dynamic> data) {
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      productsCount: data['ProductsCount'] ?? 0,
    );
  }
}
