import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String imageUrl;
  final String targetScreen;
  final bool active;
  final bool isLocal; // true = asset, false = network URL

  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
    this.isLocal = false,
  });

  Map<String, dynamic> toJson() => {
        'ImageUrl': imageUrl,
        'TargetScreen': targetScreen,
        'Active': active,
      };

  factory BannerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return BannerModel(
      imageUrl: data['ImageUrl'] ?? '',
      targetScreen: data['TargetScreen'] ?? '',
      active: data['Active'] ?? false,
      isLocal: false,
    );
  }
}
